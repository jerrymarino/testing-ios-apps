//
//  HSLocationsService.m
//  HotSpots
//
//  Created by Jerry Marino on 2/1/15.
//  Copyright (c) 2015 JM. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "HSLocationsService.h"
#import "HSLocationsAPIClient.h"
#import "HSLocation.h"

NSString *const HSLocationsServiceDidScoreLocationNotification = @"HSLocationsServiceDidScoreLocationNotification";
NSString *const HSLocationsServiceDidFetchLocationsNotification = @"HSLocationsServiceDidFetchLocationsNotification";

@interface HSLocationsService() <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) NSMutableArray *locationsInternal;
@property (nonatomic) CLLocation *location;
@property (nonatomic) NSString *cursor;
@property (nonatomic) NSUInteger fetchCount;

@end

@implementation HSLocationsService

- (id)init
{
    if (self = [super init]) {
        _locationsInternal = [NSMutableArray array];
        [self.locationManager startUpdatingLocation];
    }
    return self;
}

- (NSArray *)locations
{
    return _locationsInternal;
}

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationManager;
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    if (_location && [newLocation distanceFromLocation:_location] < 100){
        return;
    }
    _location = newLocation;
    [self fetch];
}

- (BOOL)fetch
{
    _fetchCount++;
    if (_fetchCount > 2) {
        return NO;
    }
    [[HSLocationsAPIClient sharedClient] fetchPlacesForLoacation:_location.coordinate
                                                          radius:300
                                                            type:@"bar"
                                                          cursor:_cursor
                                                      completion:^(NSDictionary *locationInfo, NSError *error) {
                                                          NSArray *results = locationInfo[@"results"];
                                                          _cursor = locationInfo[@"next_page_token"];
                                                          [_locationsInternal addObjectsFromArray:results];
                                                          [[NSNotificationCenter defaultCenter] postNotificationName:HSLocationsServiceDidFetchLocationsNotification
                                                                                                              object:self
                                                                                                            userInfo:@{@"locations": results}];
                                                          for (HSLocation *location in results){
                                                              [self scoreLocation:location];
                                                          }
                                                      }];
    return YES;
}

// In real life this is a long running task based on machine learning and big data.
- (void)scoreLocation:(HSLocation *)location
{
    int seed = (rand() % 10) + 1;
    double delayInSeconds = (10.0 / seed);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSUInteger score = (seed % 5) + 1;
        [location setValue:@(score) forKey:@"hottness"];
        [[NSNotificationCenter defaultCenter] postNotificationName:HSLocationsServiceDidScoreLocationNotification
                                                            object:self
                                                          userInfo:@{@"location": location}];
    });
}

- (BOOL)fetchMoreAfter:(id)sender
{
    if (!_cursor || _locationsInternal.count >= 40) {
        return NO;
    }
    return [self fetch];
}

@end
