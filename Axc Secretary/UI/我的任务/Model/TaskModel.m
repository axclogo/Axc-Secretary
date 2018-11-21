//
//  TaskModel.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/12.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "TaskModel.h"

@implementation MonthEventModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = kStartingCellHeight;
    }
    return self;
}
- (NSString *)levelStr{
    switch (self.level) {
        case 0:  return @"普通";  break;
        case 1:
        case 2:
        case 3:  return @"正常";  break;
        case 4:
        case 5:
        case 6:  return @"一般";  break;
        case 7:
        case 8:
        case 9:  return @"重要";  break;
        case 10: return @"紧急";  break;
            break;
        default: return @"未知";  break;
    }
}
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
                onModel.isMergeUnit = YES;  // 合并
                obj.isHiddenDate = YES;         // 隐藏日期显示时间标记
            }else{
                onModel.isMergeUnit = NO;
                obj.isHiddenDate = NO;
            }
        }else{
            obj.isMergeUnit = NO;
            obj.isHiddenDate = NO;
        }
    }];
    _monthEvents = sourceArrM;
}

@end
