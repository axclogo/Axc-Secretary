//
//  TaskCell.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/12.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;
@property (weak, nonatomic) IBOutlet UIButton *unfoldBtn;


@property(nonatomic , strong)MonthEventModel *monthEvent;

// Cell之前的分割线尺寸
@property(nonatomic, assign)UIEdgeInsets mergeUnitInset;
@property(nonatomic, assign)UIEdgeInsets noMergeUnitInset;


@end

NS_ASSUME_NONNULL_END
