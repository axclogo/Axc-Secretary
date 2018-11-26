//
//  AppDelegate+SVProgressHUD_Ex.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/26.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AppDelegate+SVProgressHUD_Ex.h"

@implementation AppDelegate (SVProgressHUD_Ex)

- (void)settingSVProgressHUD{
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.6]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:3];
    [SVProgressHUD setActivityIndicatorType:7];
    [SVProgressHUD setActivityIndicatorTintColor:[UIColor whiteColor]];
}


@end
