//
//  HSLocation.h
//  HotSpots
//
//  Created by Jerry Marino on 2/1/15.
//  Copyright (c) 2015 JM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface HSLocation : NSObject

@property (nonatomic, readonly) NSString *guid;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *address;
@property (nonatomic, readonly) NSString *vicinity;
// The level of hottness ranging from 1-5
@property (nonatomic, readonly) NSUInteger hottness;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
