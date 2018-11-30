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
    [self AxcBase_addBarButtonItem:AxcBaseBarButtonItemLocationLeft
                             image:@"back_white"
                           handler:^(UIButton *barItemBtn) {
                               [self.navigationController popViewControllerAnimated:YES];
                           }];
}




#pragma mark - 懒加载
- (AxcTemporarilyDataView *)emptyDataView{
    if (!_emptyDataView) {
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"AxcTemporarilyDataView" owner:nil options:nil];
        _emptyDataView = [nibView firstObject];
        _emptyDataView.axcTool_size = kScreenSize;
        _emptyDataView.backgroundColor = self.view.backgroundColor;
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
}

@end
