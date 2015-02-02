//
//  HotSpotsViewController.m
//  HotSpots
//
//  Created by Jerry Marino on 1/31/15.
//  Copyright (c) 2015 JM. All rights reserved.
//

#import "HotSpotsViewController.h"
#import "HSLocationsService.h"
#import "HSLocation.h"
#import "HotSpotCell.h"

static NSString *CellIdentifier = @"Cell";

@interface HotSpotsViewController ()

@property (nonatomic) NSArray *locations;
@property (nonatomic) HSLocationsService *locationService;
@property (nonatomic) NSMutableDictionary *locationByIndex;

@end

@implementation HotSpotsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _locationService = [HSLocationsService new];
        _locationByIndex = [NSMutableDictionary dictionary];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didFetchLocations:)
                                                     name:HSLocationsServiceDidFetchLocationsNotification
                                                   object:_locationService];
        self.title = @"Hotspots";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[HotSpotCell class] forCellReuseIdentifier:CellIdentifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _locations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotSpotCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    HSLocation *location = _locations[indexPath.row];
    [cell displayLocation:location];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetDelta = scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.size.height;
    if (_locations.count && offsetDelta  < 10) {
        ;
        NSLog(@"%@ %s %d", self, __PRETTY_FUNCTION__, [_locationService fetchMoreAfter:_locations.lastObject]);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[_locations[indexPath.row] name] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alertView show];
}

#pragma mark - HSLocationService

- (void)didFetchLocations:(NSNotification *)notification
{
    _locations = _locationService.locations;
    [_locations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        _locationByIndex[[obj guid]] = @(idx);
    }];
    [self.tableView reloadData];
    self.title = [NSString stringWithFormat:@"%d Hotspots", _locations.count];
}

@end
