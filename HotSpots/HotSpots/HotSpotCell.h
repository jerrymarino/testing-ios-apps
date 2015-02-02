//
//  HotSpotCell.h
//  HotSpots
//
//  Created by Jerry Marino on 2/1/15.
//  Copyright (c) 2015 JM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HSLocation;

@interface HotSpotCell : UITableViewCell

@property (nonatomic, readonly) UILabel *nameLabel;
@property (nonatomic, readonly) UILabel *accessoryLabel;
@property (nonatomic, readonly) NSString *displayedLocationId;

- (void)displayLocation:(HSLocation *)location;

@end


