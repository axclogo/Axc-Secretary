//
//  AppDelegate.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/10/29.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabbarVC.h"

#import "AppDelegate+SVProgressHUD_Ex.h"
#import "AppDelegate+LLDebug_Ex.h"
#import "AppDelegate+Sakura_Ex.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.backgroundColor = kMainBackColor;
    self.window.rootViewController = [BaseTabbarVC new];
    // 加载三方资源
    [self loadLibResources];
    
    return YES;
}

- (void)loadLibResources{
    // 设置提示HUD
    [self settingSVProgressHUD];
    // 设置调试气泡
    [self settingLLDebug];
    // 加载主题
    [self loadTheme];
}


@end
