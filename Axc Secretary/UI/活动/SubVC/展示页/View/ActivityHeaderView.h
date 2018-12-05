//
//  ActivityHeaderView.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/12/4.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActivityHeaderView : UIView

@property(nonatomic , strong)NSDate *date;
// 日期展示Label
@property(nonatomic , strong)UILabel *dayLabel;
@property(nonatomic , strong)UILabel *yearsMonthLabel;
@property(nonatomic , strong)UILabel *weekLabel;
// 地理位置Label
@property(nonatomic , strong)UILabel *countriesLabel;
@property(nonatomic , strong)UILabel *latitudeLongitudeLabel;

- (void)loadLocation;

@end


NS_ASSUME_NONNULL_END
