//
//  ActivityHeaderView.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/12/4.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "ActivityHeaderView.h"
#import "AxcLocation.h"

@implementation ActivityHeaderView


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
    
    
    [self.countriesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yearsMonthLabel.mas_top).offset(0);
        make.left.mas_equalTo(self.yearsMonthLabel.mas_right).offset(10);
        make.bottom.mas_equalTo(self.yearsMonthLabel.mas_bottom).offset(0);
        make.right.mas_equalTo(-10);
    }];
    [self.latitudeLongitudeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.weekLabel.mas_top).offset(0);
        make.left.mas_equalTo(self.weekLabel.mas_right).offset(10);
        make.bottom.mas_equalTo(self.weekLabel.mas_bottom).offset(0);
        make.right.mas_equalTo(-10);
    }];
    [self loadLocation];
}

- (void)loadLocation{
    NSDate *today = [NSDate date];
    // 当天
    if (_date.month == today.month &&
        _date.day == today.day) {
        self.countriesLabel.hidden =
        self.latitudeLongitudeLabel.hidden = NO;
        
        [[AxcLocation sharedGpsManager] getMoLocationWithSuccess:^(double lat, double lng, CLPlacemark * _Nonnull place) {
            self.countriesLabel.text = [NSString stringWithFormat:@"%@-%@ %@ %@ %@",
                                        place.country,
                                        place.administrativeArea,
                                        place.locality,
                                        place.subLocality,
                                        place.thoroughfare];
            self.latitudeLongitudeLabel.text = [NSString stringWithFormat:@"经度：%f | 纬度：%f",lat,lng];
        } Failure:^(NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"获取定位失败！"];
        }];
    }else{
        self.countriesLabel.hidden =
        self.latitudeLongitudeLabel.hidden = YES;
        
    }
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
- (UILabel *)countriesLabel{
    if (!_countriesLabel) {
        _countriesLabel = [UILabel new];
        _countriesLabel.textColor = kUncheckColor;
        _countriesLabel.adjustsFontSizeToFitWidth = YES;
        _countriesLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_countriesLabel];
    }
    return _countriesLabel;
}
- (UILabel *)latitudeLongitudeLabel{
    if (!_latitudeLongitudeLabel) {
        _latitudeLongitudeLabel = [UILabel new];
        _latitudeLongitudeLabel.textColor = kUncheckColor;
        _latitudeLongitudeLabel.font = [UIFont systemFontOfSize:12];
        _latitudeLongitudeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_latitudeLongitudeLabel];
    }
    return _latitudeLongitudeLabel;
}


@end
