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
/** 空值View */
@property(nonatomic , strong)AxcTemporarilyDataView *emptyDataView;

// 设置返回按钮
- (void)AxcBase_settingBackBtn;

// tableView
- (void)tableView_headerAction;
- (void)tableView_footerAction;
- (void)AxcBase_tableEndRefreshing;
- (void)AxcBase_tableEndRefreshingWithDataCount:(NSInteger )count;
- (void)AxcBase_tableEndRefreshingWithDataCount:(NSInteger )count pageSize:(NSInteger )pageSize;
- (void)AxcBase_settingTableType:(UITableViewStyle)tableType
                         nibName:(NSString *)nibName
                          cellID:(NSString *)cellID
                      refreshing:(BOOL)refreshing
                         loading:(BOOL)loading;

// collectionView
- (void)collectionView_headerAction;
- (void)collectionView_footerAction;
- (void)AxcBase_collectionEndRefreshing;
- (void)AxcBase_collectionEndRefreshingWithDataCount:(NSInteger )count;
- (void)AxcBase_collectionEndRefreshingWithDataCount:(NSInteger )count pageSize:(NSInteger )pageSize;
- (void)AxcBase_settingCollectionLayout:(UICollectionViewLayout* )flowLayout
                                nibName:(NSString *)nibName
                                 cellID:(NSString *)cellID
                             refreshing:(BOOL)refreshing
                                loading:(BOOL)loading;
// 数据库操作对象
@property(nonatomic , strong)AxcDBManager *db;

@end

NS_ASSUME_NONNULL_END
