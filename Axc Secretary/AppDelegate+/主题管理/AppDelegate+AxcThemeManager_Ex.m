//
//  AppDelegate+AxcThemeManager_Ex.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/26.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AppDelegate+AxcThemeManager_Ex.h"

@implementation AppDelegate (AxcThemeManager_Ex)

- (void)loadTheme{
    AxcThemeManager *themeManager = [AxcThemeManager shareManager];
    // 加载黑色主题
    if (themeManager.theme == AxcThemeNone) {
        themeManager.theme = AxcThemeDark;
    }
#warning 可设置每周不同皮肤
    
}


@end
