//
//  AppDelegate+Sakura_Ex.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/26.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AppDelegate+Sakura_Ex.h"
#import <TXSakuraKit.h>

@implementation AppDelegate (Sakura_Ex)

- (void)loadTheme{
    [TXSakuraManager registerLocalSakuraWithNames:@[@"typewriter"] ];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    button.sakura
    .backgroundColor(@"Home.buttonBackgroundColor")
    .titleColor(@"Home.buttonTitleColor", UIControlStateNormal);
}


@end
