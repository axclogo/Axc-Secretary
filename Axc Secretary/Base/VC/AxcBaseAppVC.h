//
//  AxcBaseAppVC.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/10/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AxcBaseVC.h"
#import <MJRefresh.h>                   // 下拉上拉
#import <JWCacheURLProtocol.h>          // webView内存


#define QMUI_Exist __has_include("QMUIAlertController.h")
#if QMUI_Exist
#import <QMUIAlertController.h>
#endif


#import "AxcTemporarilyDataView.h"

#import "AxcDBManager.h"


NS_ASSUME_NONNULL_BEGIN

@interface AxcBaseAppVC : AxcBaseVC
/** 空值View */
@property(nonatomic , strong)AxcTemporarilyDataView *emptyDataView;

// 设置返回按钮
- (void)AxcBase_settingBackBtn;

// 数据库操作对象
@property(nonatomic , strong)AxcDBManager *db;

#if QMUI_Exist

- (void)AxcBase_popPromptQMUIAlertWithTitle:(NSString *)title
                                    message:(NSString *)message
                                    handler:(void (^)(__kindof QMUIAlertController *alertController,  QMUIAlertAction *action))handler;
#endif

@end

NS_ASSUME_NONNULL_END
