//
//  ActivityDisplayPageCell.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/12/3.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActivityDisplayPageCell : UITableViewCell

// 开始点
@property(nonatomic , strong)CAShapeLayer *startPointLayer;
// 结束点
@property(nonatomic , strong)CAShapeLayer *endPointLayer;

// 中线时间轴 上
@property(nonatomic , strong)CAShapeLayer *centerTimeLayer_top;
// 中线时间轴 下
@property(nonatomic , strong)CAShapeLayer *centerTimeLayer_bottom;

@property(nonatomic , strong)ActivityCellModel *model;

@end

NS_ASSUME_NONNULL_END
