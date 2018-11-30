//
//  DayActivityModel.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AxcBaseModel.h"
#import "ActivityDisplayPageVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DayActivityModel : AxcBaseModel

+ (DayActivityModel *)title:(NSString *)title date:(NSDate *)date;
// 标题
@property(nonatomic , strong)NSString *title;
// VC
@property(nonatomic , strong)ActivityDisplayPageVC *vc;
// 时间轴
@property(nonatomic , strong)NSArray *timeLineArray;

@end

NS_ASSUME_NONNULL_END
