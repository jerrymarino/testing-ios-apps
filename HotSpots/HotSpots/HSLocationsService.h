//
//  HSLocationsService.h
//  HotSpots
//
//  Created by Jerry Marino on 2/1/15.
//  Copyright (c) 2015 JM. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *const HSLocationsServiceDidScoreLocationNotification;
NSString *const HSLocationsServiceDidFetchLocationsNotification;

@interface HSLocationsService : NSObject

@property (nonatomic, readonly) NSArray *locations;

- (BOOL)fetchMoreAfter:(id)sender;

@end
