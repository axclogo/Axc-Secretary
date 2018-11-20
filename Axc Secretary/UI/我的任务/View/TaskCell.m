//
//  TaskCell.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/12.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "TaskCell.h"


@implementation TaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMonthEvent:(MonthEventModel *)monthEvent{
    _monthEvent = monthEvent;
    
    self.dayLabel.text = [_monthEvent.date AxcTool_getDateWithFomant:@"dd"];
    BOOL isToday =
    _monthEvent.date.AxcTool_isThisYear &&
    _monthEvent.date.AxcTool_isThisMonth &&
    _monthEvent.date.AxcTool_isToday; // 是否是今天
    self.weekLabel.text = isToday ? @"今天" : WEEK_DAY_STRINGS[_monthEvent.date.week];
    self.weekLabel.backgroundColor = isToday ? KScienceTechnologyBlue : [UIColor clearColor];
    self.weekLabel.textColor = isToday ? [UIColor whiteColor] : [UIColor lightGrayColor];
    self.timeLabel.text = [_monthEvent.date AxcTool_getDateWithFomant:@"HH:mm"];
    self.transactionLabel.text = _monthEvent.levelStr;
    self.titleLabel.text = _monthEvent.title;
    self.introductionLabel.text = _monthEvent.Introduction;
    
    
    // 如果天数相同显示时分秒即可
    self.timeLabel.hidden = !_monthEvent.isHiddenDate;
    // 合并单元格
    self.separatorInset = _monthEvent.isMergeUnit ? self.mergeUnitInset : self.noMergeUnitInset;
    self.layoutMargins = _monthEvent.isMergeUnit ? self.mergeUnitInset : self.noMergeUnitInset;
    self.transactionLabel.hidden = !_monthEvent.isSelect; // 展开并且合并情况
    self.dayLabel.hidden = self.weekLabel.hidden = _monthEvent.isHiddenDate;
    // 合并后需要圆圈标注
    self.dayLabel.layer.masksToBounds = _monthEvent.isMergeUnit;
    self.dayLabel.layer.cornerRadius = _monthEvent.isMergeUnit ? self.dayLabel.axcTool_width/2 : 0;
    self.dayLabel.backgroundColor = _monthEvent.isMergeUnit ? kVCBackColor : [UIColor clearColor];
    self.dayLabel.textColor = _monthEvent.isMergeUnit ? [UIColor whiteColor] : [UIColor blackColor];
    // 展开控制
    self.unfoldBtn_.selected = self.unfoldBtn.selected = _monthEvent.isSelect;
    self.unfoldBtn_.transform = self.unfoldBtn.transform = CGAffineTransformMakeRotation(AxcDraw_Angle(_monthEvent.isSelect ? 180 : 0));
}

#pragma mark - 懒加载
- (UIEdgeInsets)mergeUnitInset{
    return UIEdgeInsetsMake(self.axcTool_height, self.lineView.axcTool_x, self.axcTool_height, 10);
}
- (UIEdgeInsets)noMergeUnitInset{
    return UIEdgeInsetsMake(self.axcTool_height, 10, self.axcTool_height,  10);
}


@end
