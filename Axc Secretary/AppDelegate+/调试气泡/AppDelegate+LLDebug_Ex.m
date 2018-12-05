//
//  AppDelegate+LLDebug_Ex.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/23.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AppDelegate+LLDebug_Ex.h"
#import "LLDebug.h"

@implementation AppDelegate (LLDebug_Ex)

- (void)settingLLDebug{
    [LLConfig sharedConfig].colorStyle = LLConfigColorStyleSimple;
    [[LLConfig sharedConfig] configBackgroundColor:kNavColor
                                         textColor:kSelectedColor
                                    statusBarStyle:UIStatusBarStyleDefault];
    NSDictionary *settingKeys = [self.userDefaults objectForKey:kSettingKeys];
    if ([[settingKeys objectForKey:kSetting_DebugAirBubbles] integerValue]) {
        [[LLDebugTool sharedTool] startWorking];
    }else{
        [[LLDebugTool sharedTool] stopWorking];
    }
}


@end
