//
//  AppDelegate.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/10/29.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabbarVC.h"

#import "AppDelegate+LLDebug_Ex.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.backgroundColor = kMainBackColor;
    self.window.rootViewController = [BaseTabbarVC new];
    
    [self settingLLDebug];
    
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.6]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:3];
    [SVProgressHUD setActivityIndicatorType:7];
    [SVProgressHUD setActivityIndicatorTintColor:[UIColor whiteColor]];
    
    return YES;
}


@end
