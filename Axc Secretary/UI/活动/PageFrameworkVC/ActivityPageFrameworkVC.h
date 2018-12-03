//
//  ActivityPageFrameworkVC.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "WMPageController.h"
#import "DayActivityModel.h"

#define kMenuHeight 35


NS_ASSUME_NONNULL_BEGIN

@interface ActivityPageFrameworkVC : WMPageController

// 每周数组
@property(nonatomic , strong)NSMutableArray <DayActivityModel *>*weekAcitvityArray;
// 回到今日
- (void)goToday;

@end

NS_ASSUME_NONNULL_END
