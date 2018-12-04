//
//  OrdinaryTaskVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "OrdinaryTaskVC.h"

@interface OrdinaryTaskVC ()

@end

@implementation OrdinaryTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.taskType = TaskTypeOrdinary;
}

- (void)createUI{
    [super createUI];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self AxcBase_showDateSelectCompleteBlock:nil];
}


#pragma mark - 懒加载
//- (UITextField *)taskNameTextFiled{
//    if (!_taskNameTextFiled) {
//        _taskNameTextFiled = [UITextField ];
//    }
//}

@end
