//
//  HSLocationsAPIClient.h
//  HotSpots
//
//  Created by Jerry Marino on 1/31/15.
//  Copyright (c) 2015 JM. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "AFHTTPSessionManager.h"

@interface HSLocationsAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;
- (void)fetchPlacesForLoacation:(CLLocationCoordinate2D)location
                         radius:(CGFloat)radius
                           type:(NSString *)type
                         cursor:(NSString *)cursor
                     completion:(void (^)(NSDictionary *locationInfo, NSError *error))completion;

@end
