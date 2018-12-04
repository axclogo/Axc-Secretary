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



#import "AxcTemporarilyDataView.h"

#import "AxcDBManager.h"


NS_ASSUME_NONNULL_BEGIN

@interface AxcBaseAppVC : AxcBaseVC
// 设置返回按钮
- (void)AxcBase_settingBackBtn;
/** 空值View */
@property(nonatomic , strong)AxcTemporarilyDataView *emptyDataView;
// 数据库操作对象
@property(nonatomic , strong)AxcDBManager *db;
// 日期选择
- (void)AxcBase_showDateSelectCompleteBlock:(void(^)(NSDate *))completeBlock;

@end

NS_ASSUME_NONNULL_END
