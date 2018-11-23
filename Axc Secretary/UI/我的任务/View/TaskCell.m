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
    self.layer.masksToBounds = YES;
    self.lineView.axcTool_width = 0.5;
    self.disLineView.axcTool_height = 0.3;
    self.disLineView.hidden = YES;
    self.backgroundColor =  kMainBackColor;
    self.leftBackGroundView.backgroundColor =  kNavColor ;
    
    self.unfoldBtn.imageView.image = [self.unfoldBtn.imageView.image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
    [self.unfoldBtn.imageView setTintColor:kUncheckColor];
    
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
    self.weekLabel.backgroundColor = isToday ? kSelectedGreenColor : [UIColor clearColor];
    self.weekLabel.textColor = isToday ? [UIColor whiteColor] : [UIColor lightGrayColor];
    self.weekLabel.layer.masksToBounds = YES;
    self.weekLabel.layer.cornerRadius = self.weekLabel.axcTool_height/2;
    self.timeLabel.text = [_monthEvent.date AxcTool_getDateWithFomant:@"HH:mm"];
    self.transactionLabel.text = _monthEvent.levelStr;
    self.titleLabel.text = _monthEvent.title;
    self.introductionLabel.text = _monthEvent.Introduction;
    
    self.titleLabel.textColor = [UIColor whiteColor];
    self.introductionLabel.textColor = kUncheckColor;
    
    // 如果天数相同显示时分秒即可
    self.timeLabel.hidden = !_monthEvent.isHiddenDate;
    // 合并单元格
    self.separatorInset = _monthEvent.isMergeUnit ? self.mergeUnitInset : self.noMergeUnitInset;
    self.layoutMargins = _monthEvent.isMergeUnit ? self.mergeUnitInset : self.noMergeUnitInset;
    self.transactionLabel.hidden = !_monthEvent.isSelect; // 展开并且合并情况
    self.dayLabel.hidden = self.weekLabel.hidden = _monthEvent.isHiddenDate;
    // 合并后需要圆圈标注
    self.dayLabel.layer.masksToBounds = YES;
    self.dayLabel.layer.cornerRadius = self.dayLabel.axcTool_width/2;
    self.dayLabel.backgroundColor = _monthEvent.isMergeUnit ? kUncheckColor : [UIColor clearColor];
    if (isToday && _monthEvent.isMergeUnit) self.dayLabel.backgroundColor = kSelectedGreenColor;
    self.dayLabel.textColor = _monthEvent.isMergeUnit ? [UIColor whiteColor] : [UIColor whiteColor];
    // 展开控制
    self.unfoldBtn_.selected = self.unfoldBtn.selected = _monthEvent.isSelect;
    self.unfoldBtn_.transform = self.unfoldBtn.transform = CGAffineTransformMakeRotation(AxcDraw_Angle(_monthEvent.isSelect ? 180 : 0));
    // 添加时间
    self.addDateLabel.text = [NSString stringWithFormat:@"于%@添加",[AxcCalculateTool AxcTool_timeIntervalFromLastTime:_monthEvent.addDate ToCurrentTime:[NSDate date]]];
    self.addDateLabel.textColor = kUncheckColor;
    // 执行时间
    self.executionTimeLabel.text = [AxcCalculateTool AxcTool_timeFromTime:_monthEvent.date ToCurrentTime:[NSDate date]];
    self.executionTimeLabel.textColor = kUncheckColor;
}

#pragma mark - 懒加载
- (UIEdgeInsets)mergeUnitInset{
    return UIEdgeInsetsMake(self.axcTool_height, self.lineView.axcTool_x, self.axcTool_height, 0);
}
- (UIEdgeInsets)noMergeUnitInset{
    return UIEdgeInsetsMake(self.axcTool_height, 0, self.axcTool_height,  0);
}


@end
