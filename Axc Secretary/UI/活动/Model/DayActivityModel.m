//
//  DayActivityModel.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "DayActivityModel.h"

@implementation DayActivityModel
+ (DayActivityModel *)title:(NSString *)title date:(NSDate *)date{
    DayActivityModel *model = [DayActivityModel new];
    model.title = title;
    model.vc.date = date;
    return model;
}

- (ActivityDisplayPageVC *)vc{
    if (!_vc) {
        _vc = [ActivityDisplayPageVC new];
    }
    return _vc;
}

@end
