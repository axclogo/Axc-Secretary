//
//  AppDelegate.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/10/29.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabbarVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [BaseTabbarVC new];
    return YES;
}


@end
