//
//  EditorActivityVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/12/3.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "EditorActivityVC.h"

@interface EditorActivityVC ()

@end

@implementation EditorActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self AxcBase_settingBackBtn];
}
- (void)createUI{
    self.title = @"编辑所有活动";
    [self AxcBase_addBarButtonItem:AxcBaseBarButtonItemLocationRight image:@"add_white" handler:^(UIButton *barItemBtn) {
        [self AxcTool_pushVCName:@"AddActivityVC"];
    }];
}

@end
