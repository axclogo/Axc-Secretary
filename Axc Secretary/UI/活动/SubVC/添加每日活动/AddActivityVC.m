//
//  AddActivityVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AddActivityVC.h"

@interface AddActivityVC ()

@end

@implementation AddActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self AxcBase_settingBackBtn];
}

- (void)createUI{
    [super createUI];
    self.title = @"添加活动";
}

@end
