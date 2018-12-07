//
//  AxcBaseAppVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/10/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AxcBaseAppVC.h"

@interface AxcBaseAppVC ()

@end

@implementation AxcBaseAppVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMainBackColor;
    self.axcNavBarTextColor = kUncheckColor;

}
- (void)AxcBase_settingBackBtn{
    WeakSelf;
    [self AxcBase_addBarButtonItem:AxcBaseBarButtonItemLocationLeft
                             image:@"back_white"
                           handler:^(UIButton *barItemBtn) {
                               [weakSelf.navigationController popViewControllerAnimated:YES];
                           }];
}

//- (void)AxcBase_popAlentTitle:(NSString *)title content:(NSString *)content clicked:(void (^)(void))clicked{
//    JCAlertController *alert = [JCAlertController alertWithTitle:title message:content];
//    [alert addButtonWithTitle:@"确定" type:JCButtonTypeNormal clicked:clicked];
//    [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:nil];
//}


- (void)AxcBase_showDate:(NSDate *)date selectCompleteBlock:(void(^)(NSDate *))completeBlock{
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute scrollToDate:date CompleteBlock:completeBlock];
    datepicker.dateLabelColor = kSelectedColor;
    datepicker.datePickerColor = kMarkColor;//滚轮日期颜色
    datepicker.doneButtonColor = kSelectedColor;//确定按钮的颜色
    datepicker.yearLabelColor = [kUncheckColor colorWithAlphaComponent:0.3]; // 年份
    datepicker.buttomView.backgroundColor = kMainBackColor;
    [datepicker show];
}


#pragma mark - 懒加载
- (AxcTemporarilyDataView *)emptyDataView{
    if (!_emptyDataView) {
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"AxcTemporarilyDataView" owner:nil options:nil];
        _emptyDataView = [nibView firstObject];
        _emptyDataView.axcTool_size = kScreenSize;
        _emptyDataView.backgroundColor = kMainBackColor;
        _emptyDataView.titleImageView.image = [_emptyDataView.titleImageView.image
                                               imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
        [_emptyDataView.titleImageView setTintColor:kUncheckColor];
        _emptyDataView.disLable.textColor = kUncheckColor;
    }
    return _emptyDataView;
}

- (AxcDBManager *)db{
    if (!_db) {
        _db = [AxcDBManager manager];
    }
    return _db;
}

#pragma mark - 重写
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.barTintColor = kNavColor;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;   //状态栏字体白色 UIStatusBarStyleDefault黑色
}
#pragma mark - 销毁
- (void)dealloc{
    [JWCacheURLProtocol cancelListeningNetWorking];
    LLog([NSString stringWithFormat:@"控制器：%@ 已销毁",self]);
}

@end
