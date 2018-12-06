//
//  AppDelegate+JCAlertController_Ex.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/12/6.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AppDelegate+JCAlertController_Ex.h"

@implementation AppDelegate (JCAlertController_Ex)

- (void)settingJCAlentStyle{
    JCAlertStyle *style = [JCAlertStyle shareStyle];
    
    style.background.blur = YES;
    style.background.alpha = 0.65;
    style.background.canDismiss = YES;
    
    style.alertView.cornerRadius = 10;
    
    style.title.backgroundColor = kNavColor;
    style.title.textColor = kUncheckColor;
    
    style.content.backgroundColor = kMainBackColor;
    style.content.textColor = kViceTitleColor;
    style.content.insets = UIEdgeInsetsMake(20, 20, 40, 20);
    
    style.buttonNormal.textColor = kMainTitleColor;
    style.buttonNormal.highlightTextColor = [style.buttonNormal.textColor hightlightedColor];
    style.buttonNormal.backgroundColor = kMainBackColor;
    style.buttonNormal.highlightBackgroundColor = kMainTitleColor;
    
    style.buttonCancel.textColor = kViceTitleColor;
    style.buttonCancel.highlightTextColor = [style.buttonNormal.textColor hightlightedColor];
    style.buttonCancel.backgroundColor = kMainBackColor;
    style.buttonCancel.highlightBackgroundColor = kMainTitleColor;
}


@end
