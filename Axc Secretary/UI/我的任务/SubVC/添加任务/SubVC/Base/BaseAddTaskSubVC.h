//
//  BaseAddTaskSubVC.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AxcBaseAppVC.h"

typedef NS_ENUM(NSInteger, TaskType) {
    TaskTypeNone,           // 未设置
    TaskTypeOrdinary,       // 普通任务
    TaskTypeActivity,       // 活动
};

NS_ASSUME_NONNULL_BEGIN

@interface BaseAddTaskSubVC : AxcBaseAppVC

// 任务类型
@property(nonatomic , assign)TaskType taskType;
// 任务名称的TextField
@property(nonatomic , strong)UITextField *taskNameTextFiled;
// 确认添加的按钮
@property(nonatomic , strong)UIButton *confirmBtn;


@end

NS_ASSUME_NONNULL_END
