//
//  AppDelegate.m
//  HotSpots
//
//  Created by Jerry Marino on 1/31/15.
//  Copyright (c) 2015 JM. All rights reserved.
//

#import "AppDelegate.h"
#import "HotSpotsViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[HotSpotsViewController new]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
