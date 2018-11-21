//
//  TaskModel.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/12.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AxcBaseModel.h"

#define kStartingCellHeight 70
#define kDateFormat @"yyyy-MM-dd HH:mm:ss"


NS_ASSUME_NONNULL_BEGIN

@interface MonthEventModel : AxcBaseModel
// 日期
@property(nonatomic , strong)NSDate *date;
// 日期
@property(nonatomic , strong)NSDate *addDate;
// 标题
@property(nonatomic , strong)NSString *title;
// 简介
@property(nonatomic , strong)NSString *Introduction;
// 是否合并单元格 默认NO
@property(nonatomic , assign)BOOL isMergeUnit;
// 是否隐藏日期显示
@property(nonatomic , assign)BOOL isHiddenDate;
// 事务级别 0-10
@property(nonatomic , assign)NSInteger level;
// 事务级别名称
@property(nonatomic , strong , readonly)NSString *levelStr;

// 是否已完成
@property(nonatomic , assign)BOOL isComplete;

// cell控制展开
@property(nonatomic , assign)BOOL isSelect;

@end
////////////////////////////////////////////////////////
@interface TaskModel : AxcBaseModel


@property(nonatomic , strong)NSDate *date;
/**
 月事项
 */
@property(nonatomic , strong)NSArray <MonthEventModel *>*monthEvents;


@end

NS_ASSUME_NONNULL_END
