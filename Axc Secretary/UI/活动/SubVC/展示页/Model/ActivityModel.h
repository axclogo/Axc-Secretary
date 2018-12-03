//
//  ActivityModel.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/12/3.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AxcBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActivityCellModel : AxcBaseModel

@property(nonatomic , strong)NSDate *date;

@end

@interface ActivityModel : AxcBaseModel

@property(nonatomic , strong)NSDate *hours;

@property(nonatomic , strong)NSArray <ActivityCellModel *>*hoursActivitys;

@end

NS_ASSUME_NONNULL_END
