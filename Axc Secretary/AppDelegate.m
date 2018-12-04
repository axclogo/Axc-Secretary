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
#import "AppDelegate+JLRoutes_Ex.h"

#import "AppDelegate+AxcThemeManager_Ex.h"
#import "AppDelegate+Axc3DTouch_Ex.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 加载资源
    [self loadLibResources];
    // 设置Window
    [self settingWindow];
    
    return YES;
}
- (void)settingWindow{
    self.window.backgroundColor = kMainBackColor;
    self.window.rootViewController = [BaseTabbarVC new];
}
- (void)loadLibResources{
    // 加载主题
    [self loadTheme];
    // 设置提示HUD
    [self settingSVProgressHUD];
    // 设置调试气泡
    [self settingLLDebug];
    // 设置3DTouch
    [self setting3DTouch];
    // 注册路由
    [self registerRoute];
}

- (void)resetWindow:(BOOL )animation{
    [self loadLibResources]; // 重新加载资源
    if (animation) {
        // 动画过度
        self.window.rootViewController.view.alpha = 1;
        [UIView animateWithDuration:0.3 animations:^{
            self.window.rootViewController.view.alpha = 0;
        }completion:^(BOOL finished) {
            self.window.rootViewController = nil;
            BaseTabbarVC *vc = [BaseTabbarVC new];
            self.window.rootViewController = vc;
            self.window.rootViewController.view.alpha = 0;
            [UIView animateWithDuration:0.3 animations:^{
                self.window.rootViewController.view.alpha = 1;
            }];
        }];
    }else{
        [self settingWindow];    // 设置Window
    }
}



@end
