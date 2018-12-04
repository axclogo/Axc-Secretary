//
//  SwitchIconVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/12/4.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "SwitchIconVC.h"

@interface SwitchIconVC ()

@end

@implementation SwitchIconVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self AxcBase_settingBackBtn];
    self.title = @"更换图标";
}

- (void)createUI{
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([UIApplication sharedApplication].supportsAlternateIcons) {
        [[UIApplication sharedApplication] setAlternateIconName:@"newIcon" completionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"set icon error: %@",error);
            }
        }];
    }
}

@end
