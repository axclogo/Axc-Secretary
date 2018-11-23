//
//  TaskCell.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/12.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "MGSwipeTableCell.h"
#import "TaskModel.h"
#import "AxcDrawDefine.h"


NS_ASSUME_NONNULL_BEGIN

@interface TaskCell : MGSwipeTableCell

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;
@property (weak, nonatomic) IBOutlet UIButton *unfoldBtn;
@property (weak, nonatomic) IBOutlet UIButton *unfoldBtn_;

@property (weak, nonatomic) IBOutlet UILabel *transactionLabel;
@property (weak, nonatomic) IBOutlet UILabel *addDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *executionTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *disLineView;
@property (weak, nonatomic) IBOutlet UIView *leftBackGroundView;

@property(nonatomic , strong)MonthEventModel *monthEvent;

// Cell之前的分割线尺寸
@property(nonatomic, assign)UIEdgeInsets mergeUnitInset;
@property(nonatomic, assign)UIEdgeInsets noMergeUnitInset;


@end

NS_ASSUME_NONNULL_END
