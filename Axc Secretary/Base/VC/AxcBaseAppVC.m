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


- (void)tableView_headerAction{
    [self AxcBase_tableEndRefreshing];
}
- (void)tableView_footerAction{
    [self AxcBase_tableEndRefreshing];
}
- (void)AxcBase_tableEndRefreshing{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}
- (void)AxcBase_tableEndRefreshingWithDataCount:(NSInteger )count{
    [self AxcBase_tableEndRefreshingWithDataCount:count pageSize:9];
}
- (void)AxcBase_tableEndRefreshingWithDataCount:(NSInteger )count pageSize:(NSInteger )pageSize{
    if (count <= pageSize) { // 没有更多数据了
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self AxcBase_tableEndRefreshing];
    }
}
- (void)AxcBase_settingTableType:(UITableViewStyle)tableType
                         nibName:(NSString *)nibName
                          cellID:(NSString *)cellID
                      refreshing:(BOOL)refreshing
                         loading:(BOOL)loading{
    [self AxcBase_settingTableType:tableType nibName:nibName cellID:cellID];
    if (refreshing) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                    refreshingAction:@selector(tableView_headerAction)];
        self.tableView.mj_header.automaticallyChangeAlpha = YES;
    }
    if (loading) {
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                        refreshingAction:@selector(tableView_footerAction)];
    }
}


// collectionView
- (void)collectionView_headerAction{
    [self AxcBase_collectionEndRefreshing];
}
- (void)collectionView_footerAction{
    [self AxcBase_collectionEndRefreshing];
}
- (void)AxcBase_collectionEndRefreshing{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}
- (void)AxcBase_collectionEndRefreshingWithDataCount:(NSInteger )count{
    [self AxcBase_collectionEndRefreshingWithDataCount:count pageSize:9];
}
- (void)AxcBase_collectionEndRefreshingWithDataCount:(NSInteger )count pageSize:(NSInteger )pageSize{
    if (count <= pageSize) { // 没有更多数据了
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self AxcBase_collectionEndRefreshing];
    }
}
- (void)AxcBase_settingCollectionLayout:(UICollectionViewLayout* )flowLayout
                                nibName:(NSString *)nibName
                                 cellID:(NSString *)cellID
                             refreshing:(BOOL)refreshing
                                loading:(BOOL)loading{
    [self AxcBase_settingCollectionLayout:flowLayout nibName:nibName cellID:cellID];
    if (refreshing) {
        self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                         refreshingAction:@selector(collectionView_headerAction)];
        self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    }
    if (loading) {
        self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                             refreshingAction:@selector(collectionView_footerAction)];
    }
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
