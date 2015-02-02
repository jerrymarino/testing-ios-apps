//
//  HotSpotCell.m
//  HotSpots
//
//  Created by Jerry Marino on 2/1/15.
//  Copyright (c) 2015 JM. All rights reserved.
//

#import "HotSpotCell.h"
#import "HSLocation.h"

@implementation HotSpotCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _nameLabel = [UILabel new];
        _accessoryLabel = [UILabel new];
        _accessoryLabel.alpha = 0;
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_accessoryLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _nameLabel.frame = CGRectMake(0, 0, self.bounds.size.width - 46, self.bounds.size.height);
    _accessoryLabel.frame = CGRectMake(self.bounds.size.width - 46, 0, 46, self.bounds.size.height);
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self.layer removeAllAnimations];
}

- (void)displayHottnessForLocation:(HSLocation *)location animated:(BOOL)animated
{
    _accessoryLabel.text = [NSString stringWithFormat:@"%ldpts", (unsigned long)location.hottness];
    if (animated){
        [UIView animateWithDuration:0.75 animations:^{
            _accessoryLabel.alpha = 1;
        }];
    } else {
        _accessoryLabel.alpha = 1;
    }
}

- (void)displayLocation:(HSLocation *)location
{
    _nameLabel.text = location.name;
    _displayedLocationId = location.guid;
    
    if (location.hottness) {
        [self displayHottnessForLocation:location animated:NO];
    } else {
        _accessoryLabel.alpha = 0;
        [location addObserver:self forKeyPath:@"hottness" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([[object guid] isEqual:self.displayedLocationId]) {
        [self displayHottnessForLocation:object animated:YES];
    }
    
    [object removeObserver:self forKeyPath:@"hottness"];
}

@end
