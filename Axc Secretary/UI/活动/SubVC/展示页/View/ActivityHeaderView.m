//
//  ActivityHeaderView.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/12/4.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "ActivityHeaderView.h"

@implementation ActivityHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setDate:(NSDate *)date{
    _date = date;
    self.dayLabel.text = [NSString stringWithFormat:@"%ld",_date.day];
    CGFloat dayLabelHeight = 35.f;
    [self.dayLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
        make.height.mas_equalTo(dayLabelHeight);
        make.width.mas_equalTo([self.dayLabel.text AxcTool_getWidthFont:self.dayLabel.font maxHeight:dayLabelHeight] + 5);
    }];
    
    self.yearsMonthLabel.text = [_date AxcTool_getDateWithFomant:@"yyyy/MM"];
    CGFloat yearsMonthLabelHeight = dayLabelHeight*(2.f/3.f);
    [self.yearsMonthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dayLabel.mas_top).offset(0);
        make.left.mas_equalTo(self.dayLabel.mas_right).offset(0);
        make.height.mas_equalTo(yearsMonthLabelHeight-5);
        make.width.mas_equalTo([self.yearsMonthLabel.text AxcTool_getWidthFont:self.yearsMonthLabel.font maxHeight:yearsMonthLabelHeight] + 10);
    }];
    
    self.weekLabel.text = WEEK_DAY_STRINGS[_date.week];
    [self.weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yearsMonthLabel.mas_bottom).offset(5.f/2.f);
        make.left.mas_equalTo(self.yearsMonthLabel.mas_left).offset(0);
        make.bottom.mas_equalTo(self.dayLabel.mas_bottom).offset(0);
        make.right.mas_equalTo(self.yearsMonthLabel.mas_right).offset(0);
    }];
    
}

- (void)createUI{
}


#pragma mark - 懒加载
- (UILabel *)dayLabel{
    if (!_dayLabel) {
        _dayLabel = [UILabel new];
        _dayLabel.textColor = kUncheckColor;
        _dayLabel.font = [UIFont systemFontOfSize:45];
        [self addSubview:_dayLabel];
    }
    return _dayLabel;
}
- (UILabel *)yearsMonthLabel{
    if (!_yearsMonthLabel) {
        _yearsMonthLabel = [UILabel new];
        _yearsMonthLabel.textColor = kUncheckColor;
        _yearsMonthLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_yearsMonthLabel];
    }
    return _yearsMonthLabel;
}
- (UILabel *)weekLabel{
    if (!_weekLabel) {
        _weekLabel = [UILabel new];
        _weekLabel.textColor = kUncheckColor;
        _weekLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_weekLabel];
    }
    return _weekLabel;
}

@end
