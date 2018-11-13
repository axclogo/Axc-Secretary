//
//  TaskModel.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/12.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "TaskModel.h"

@implementation MonthEventModel

@end
@implementation TaskModel

- (void)setMonthEvents:(NSArray<MonthEventModel *> *)monthEvents{
    NSMutableArray <MonthEventModel *>*sourceArrM = monthEvents.mutableCopy;
    // 时间升序
    [sourceArrM sortUsingComparator:^NSComparisonResult(MonthEventModel * _Nonnull obj1 , MonthEventModel * _Nonnull obj2) {
        return [obj1.date compare:obj2.date];
    }];
    // 设置单元格合并
    [sourceArrM enumerateObjectsUsingBlock:^(MonthEventModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx) {
            MonthEventModel *onModel = [sourceArrM objectAtIndex:idx - 1];
            if ([obj.date AxcTool_compareDaysWithDate:onModel.date]) { // 和上一个相等
                onModel.isMergeUnit = YES;
                obj.isHiddenDate = YES;
            }
        }
    }];
    _monthEvents = sourceArrM;
}

@end
