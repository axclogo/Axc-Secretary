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
    
    
}
- (void)AxcBase_settingBackBtn{
    [self AxcBase_addBarButtonItem:AxcBaseBarButtonItemLocationLeft
                             image:@"back_white"
                           handler:^(UIButton *barItemBtn) {
                               [self.navigationController popViewControllerAnimated:YES];
                           }];
}



#pragma mark - QMUI
#if QMUI_Exist
- (void)AxcBase_popPromptQMUIAlertWithTitle:(NSString *)title
                                    message:(NSString *)message
                                    handler:(void (^)(__kindof QMUIAlertController *alertController,  QMUIAlertAction *action))handler{
    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:NULL];
    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDestructive handler:handler];
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:title message:message preferredStyle:QMUIAlertControllerStyleAlert];
    
    NSMutableDictionary *titleAttributs = [[NSMutableDictionary alloc] initWithDictionary:alertController.alertTitleAttributes];
    titleAttributs[NSForegroundColorAttributeName] = kMainTitleColor;
    alertController.alertTitleAttributes = titleAttributs;
    NSMutableDictionary *messageAttributs = [[NSMutableDictionary alloc] initWithDictionary:alertController.alertMessageAttributes];
    messageAttributs[NSForegroundColorAttributeName] = kViceTitleColor;
    alertController.alertHeaderBackgroundColor = kNavDarkColor;
    alertController.alertSeparatorColor = kUncheckColor;

    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController showWithAnimated:YES];
}

#endif

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
