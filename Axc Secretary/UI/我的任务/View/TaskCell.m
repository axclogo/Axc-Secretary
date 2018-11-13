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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMonthEvent:(MonthEventModel *)monthEvent{
    _monthEvent = monthEvent;
    
    self.dayLabel.text = [_monthEvent.date AxcTool_getDateWithFomant:@"dd"];
    self.weekLabel.text = WEEK_DAY_STRINGS[_monthEvent.date.week];
    self.timeLabel.text = [_monthEvent.date AxcTool_getDateWithFomant:@"HH:mm"];
    self.titleLabel.text = _monthEvent.title;
    self.introductionLabel.text = _monthEvent.Introduction;
    // 如果天数相同显示时分秒即可
    self.timeLabel.hidden = !_monthEvent.isHiddenDate;
    // 合并单元格
    self.separatorInset = _monthEvent.isMergeUnit ? self.mergeUnitInset : self.noMergeUnitInset;
    self.layoutMargins = _monthEvent.isMergeUnit ? self.mergeUnitInset : self.noMergeUnitInset;
    self.dayLabel.hidden = self.weekLabel.hidden = _monthEvent.isHiddenDate;
    // 合并后需要圆圈标注
    self.dayLabel.layer.masksToBounds = _monthEvent.isMergeUnit;
    self.dayLabel.layer.cornerRadius = _monthEvent.isMergeUnit ? self.dayLabel.axcTool_width/2 : 0;
    self.dayLabel.backgroundColor = _monthEvent.isMergeUnit ? kVCBackColor : [UIColor clearColor];
    self.dayLabel.textColor = _monthEvent.isMergeUnit ? [UIColor whiteColor] : [UIColor blackColor];
}

#pragma mark - 懒加载
- (UIEdgeInsets)mergeUnitInset{
    return UIEdgeInsetsMake(self.axcTool_height, self.lineView.axcTool_x, self.axcTool_height, 10);
}
- (UIEdgeInsets)noMergeUnitInset{
    return UIEdgeInsetsMake(self.axcTool_height, 10, self.axcTool_height,  0);
}


@end
