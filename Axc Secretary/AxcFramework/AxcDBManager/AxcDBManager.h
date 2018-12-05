//
//  AxcDBManager.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/19.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDB.h"
#import "TaskModel.h"



NS_ASSUME_NONNULL_BEGIN

@interface AxcDBManager : NSObject

+(AxcDBManager *)manager;
/**
 从数据库获取所有的任务事项
 @return 任务事项列表
 */
- (NSArray <TaskModel *>*)getAllTaskMatters;

/**
 添加一个事项
 @param model 添加的任务事项
 */
- (void)addTaskMatter:(MonthEventModel *)model;

/**
 删除一个事项
 @param model 删除的事项
 */
- (void)deleteTaskMatter:(MonthEventModel *)model;

/**
 讲一个事项标记成已完成
 @param model 完成的事项
 */
- (void)completeTaskMatter:(MonthEventModel *)model;

/**
 检测某个表是否存在
 @param tableName 表名
 @return 存在与否
 */
- (BOOL )detectionTableExistWithTableName:(NSString *)tableName;

@end

NS_ASSUME_NONNULL_END
