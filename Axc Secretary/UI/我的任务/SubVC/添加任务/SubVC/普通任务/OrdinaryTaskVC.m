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
// 添加
- (void)click_confirmBtn{
    MonthEventModel *addModel = [MonthEventModel new];
    addModel.title = self.taskNameTextFiled.text;
    addModel.Introduction = self.taskInstructionsTextView.text;
    addModel.date = self.selectDate;
    addModel.addDate = [NSDate date];
    addModel.level = 1;
    [self.db addTaskMatter:addModel];
    [SVProgressHUD showSuccessWithStatus:@"添加成功！"];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 懒加载

@end
