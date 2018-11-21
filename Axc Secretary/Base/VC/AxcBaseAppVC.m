//
//  AxcBaseAppVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/10/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AxcBaseAppVC.h"

@interface AxcBaseAppVC ()

@end

@implementation AxcBaseAppVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kVCBackColor;

    
}

#pragma mark - 懒加载
- (AxcDBManager *)db{
    if (!_db) {
        _db = [AxcDBManager manager];
    }
    return _db;
}

#pragma mark - 重写
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.barTintColor = kBackColor;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;   //状态栏字体白色 UIStatusBarStyleDefault黑色
}

@end
