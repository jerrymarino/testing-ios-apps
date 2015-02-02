//
//  HSLocation.m
//  HotSpots
//
//  Created by Jerry Marino on 2/1/15.
//  Copyright (c) 2015 JM. All rights reserved.
//

#import "HSLocation.h"

@implementation HSLocation

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    if (self = [super init]) {
        _guid = [attributes objectForKey:@"place_id"];
        _name = [attributes objectForKey:@"name"];
        _vicinity = [attributes objectForKey:@"vicinity"];
        NSDictionary *geometry = [attributes objectForKey:@"geometry"];
        NSDictionary *location = [geometry objectForKey:@"location"];
        _coordinate.latitude = [[location objectForKey:@"lat"] doubleValue];
        _coordinate.longitude = [[location objectForKey:@"lng"] doubleValue];
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    return [[object guid] isEqual:_guid];
}

- (NSUInteger)hash
{
    return [_guid hash];
}

@end
