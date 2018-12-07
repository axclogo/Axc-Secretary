//
//  AxcThemeManager.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/26.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AxcThemeManager.h"

static AxcThemeManager    *_manager;


@implementation AxcThemeManager

+ (AxcThemeManager *)shareManager{
    if (!_manager) {
        kDISPATCH_ONCE_BLOCK(^{
            _manager = [[AxcThemeManager alloc] init];
        });
    }
    return _manager;
}
// 线程安全
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t once;
    dispatch_once(&once, ^{                             // 为防止Alloc初始化 将alloc方法锁定
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}

- (void)setTheme:(AxcTheme)theme{
    BOOL animation = _theme != AxcThemeNone;
    if (_theme == theme) {
        [SVProgressHUD showErrorWithStatus:@"已经是当前主题，无需更换"];
        return;
    }
    _theme = theme;
    switch (_theme) {
        case AxcThemeLight:{
            self.navColor = [UIColor AxcTool_colorHex:@"09213E"];
            self.navDarkColor = [UIColor AxcTool_colorHex:@"1C2A3C"];
            self.mainBackColor = [UIColor AxcTool_colorHex:@"ffffff"];
            self.uncheckColor = [UIColor grayColor];
            self.selectedColor = [UIColor AxcTool_colorHex:@"3BB9DE"];
            self.warningColor = [UIColor orangeColor];
            self.mainTitleColor = [UIColor blackColor];
            self.markColor = [UIColor AxcTool_colorHex:@"00285A"];
            self.viceColor = [UIColor AxcTool_colorHex:@"f6f6f6"];
            self.viceTitleColor = self.mainTitleColor;
                    }break;
            
            
        case AxcThemeDark:{
            self.navColor = [UIColor AxcTool_colorHex:@"212A36"];
            self.navDarkColor = [UIColor AxcTool_colorHex:@"171D26"];
            self.mainBackColor = [UIColor AxcTool_colorHex:@"2C3546"];
            self.uncheckColor = [UIColor AxcTool_colorHex:@"818D9A"];
            self.selectedColor = [UIColor AxcTool_colorHex:@"5CA479"];
            self.warningColor = [UIColor AxcTool_colorHex:@"F86865"];
            self.mainTitleColor = [UIColor whiteColor];
            self.markColor = self.uncheckColor;
            self.viceColor = self.navColor;
            self.viceTitleColor = [UIColor whiteColor];
        }break;
//            背景色：#262638    圆圈：#363658   绿色：#24B290   黄色：#FFCE33   树枝：#363658
        default:  break;
    }
    if (animation) {
        [SVProgressHUD showWithStatus:@"正在变更主题..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.appDelegate resetWindow:animation];
            [SVProgressHUD dismiss];
        });
    }
}



@end
