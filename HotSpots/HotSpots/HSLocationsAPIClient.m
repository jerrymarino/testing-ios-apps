//
//  HSLocationsAPIClient.m
//  HotSpots
//
//  Created by Jerry Marino on 1/31/15.
//  Copyright (c) 2015 JM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "HSLocationsAPIClient.h"
#import "HSLocation.h"

// From google dev console (Key for iOS apps (with bundle identifiers))
// Note this took quite a while for the endpoint to return a value after setting up a
// test acconnt and enabling the **places** api service

static NSString *APIKey = @"";

@implementation HSLocationsAPIClient

+ (instancetype)sharedClient {
    static id _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"https://maps.googleapis.com/maps/api/place"]];
    });
    
    return _sharedClient;
}

- (void)fetchPlacesForLoacation:(CLLocationCoordinate2D)location
                         radius:(CGFloat)radius
                           type:(NSString *)type
                         cursor:(NSString *)cursor
                     completion:(void (^)(NSDictionary *locationInfo, NSError *error))completion
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"location"] = [NSString stringWithFormat:@"%f,%f", location.latitude, location.longitude];
    parameters[@"types"] = type;
    parameters[@"sensor"] = @"false";
    parameters[@"key"] = APIKey;
    parameters[@"radius"] = @(radius);
    if (cursor) {
        parameters[@"next_page_token"] = cursor;
    }
    
    [self GET:@"search/json" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);

        NSMutableArray *locations = [NSMutableArray array];
        for (NSDictionary *locationInfo in responseObject[@"results"]) {
            [locations addObject:[[HSLocation alloc] initWithAttributes:locationInfo]];
        }
        
        completion(@{@"results" : locations, @"next_page_token" : responseObject[@"next_page_token"]}, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        completion(nil, error);
    }];
}

@end
