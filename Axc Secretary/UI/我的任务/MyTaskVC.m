//
//  MyTaskVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/10/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "MyTaskVC.h"
#import "TaskCell.h"
#import "DZNSegmentedControl.h"
#import "AddTaskVC.h"

@interface MyTaskVC ()<
UIViewControllerPreviewingDelegate
>

@property(nonatomic , strong)DZNSegmentedControl *titleSegmentedControl;
// 防止反复取值造成的性能浪费，保存快速滑动处理的开关
@property(nonatomic , assign)BOOL isSwipeSettings;
// 上滑隐藏导航的开关
@property(nonatomic , assign)BOOL isHideNavigation;
@end

@implementation MyTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataBaseData];
}
- (void)createUI{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = kNavColor;
    }
    self.navigationItem.titleView = self.titleSegmentedControl;
    WeakSelf;
    [self AxcBase_addBarButtonItem:AxcBaseBarButtonItemLocationRight image:@"add_white" handler:^(UIButton *barItemBtn) {
        [weakSelf insertTask];
    }];
    [self AxcBase_settingTableType:UITableViewStylePlain nibName:@"TaskCell" cellID:@"axc" refreshing:YES loading:NO];
    MJRefreshNormalHeader *refreshHeader = (MJRefreshNormalHeader *)self.tableView.mj_header;
    refreshHeader.lastUpdatedTimeLabel.textColor = refreshHeader.stateLabel.textColor = kUncheckColor;
    self.emptyDataView.disLable.text = @"目前暂无事项";
    self.tableView.axcPlaceHolderView = self.emptyDataView;
    self.tableView.backgroundColor = kMainBackColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    // 当设置中心的滑动方式改变，需要进行刷新
    [self.notificationCenter addObserver:self selector:@selector(loadDataBaseData)
                                    name:kNotification_TaskQuickOperationChange
                                  object:nil];
}
// 加载数据库内数据
- (void)loadDataBaseData{
    NSDictionary *settingKeys = [self.userDefaults objectForKey:kSettingKeys];
    self.isSwipeSettings = [[settingKeys objectForKey:kSetting_TaskQuickOperation] integerValue];
    NSInteger index = self.titleSegmentedControl.selectedSegmentIndex;
    // 数据库查询开辟分线程操作，否则会卡主主线程，使动画不够流畅
    kDISPATCH_GLOBAL_QUEUE_DEFAULT(^{
        [SVProgressHUD show];
        switch (index) {
            case 0:{    // 待处理
                self.dataListArray = [self.db getAllTaskMatters].mutableCopy;
            }break;
            case 1:{    // 每日任务
                //            self.dataListArray = [self.db getAllTaskMatters].mutableCopy;
            }break;
            case 2:{    // 已完成
                //            self.dataListArray = [self.db getAllTaskMatters].mutableCopy;
            }break;
                
            default: break;
        }
        // 回调主线程刷新
        kDISPATCH_MAIN_THREAD(^{
            [self.tableView reloadData];
            [self AxcBase_tableEndRefreshing];
            [SVProgressHUD dismiss];
        });
    });
}

// 插入事件
- (void)insertTask{
    AddTaskVC *vc = [AddTaskVC new];
    [vc AxcBase_settingBackBtn];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
// 下拉刷新数据
- (void)tableView_headerAction{
    [self loadDataBaseData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isHideNavigation = [[[self.userDefaults objectForKey:kSettingKeys] objectForKey:kSetting_HideNavigation] integerValue];
}
#pragma mark - 事项操作函数复用
// 完成某个事项索引
- (void)completeDataWithIndexPath:(NSIndexPath *)indexPath{
    // 数据库标记该事项已完成
    TaskModel *model = self.dataListArray[indexPath.section];
    MonthEventModel *monthModel = model.monthEvents[indexPath.row];
    [self.db completeTaskMatter:monthModel];
    // 动画删除
    [self removeRowWithIndexPath:indexPath animation:UITableViewRowAnimationRight];
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@\n已完成！",monthModel.title]];
}
// 从数据上删除某个索引
- (void)deleteDataWithIndexPath:(NSIndexPath *)indexPath animation:(UITableViewRowAnimation )animation{
    // 数据库删除
    [self.db deleteTaskMatter:[self getDataSourceWithIndexPath:indexPath]];
    // 动画删除
    [self removeRowWithIndexPath:indexPath animation:animation];
}
// 移除某个cell
- (void)removeRowWithIndexPath:(NSIndexPath *)indexPath animation:(UITableViewRowAnimation )animation{
    TaskModel *model = self.dataListArray[indexPath.section];
    // 数据源删除
    NSMutableArray *arr_M = model.monthEvents.mutableCopy;
    [arr_M removeObjectAtIndex:indexPath.row];
    if (arr_M.count) {  // 还有数据
        model.monthEvents = arr_M;
        [self.dataListArray replaceObjectAtIndex:indexPath.section withObject:model];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
    }else{  // 无数据，表头也可以删了
        [self.dataListArray removeObjectAtIndex:indexPath.section];
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:animation];
    }
    // 数据对齐
    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.3];
}
// 控制Cell展开
- (void )click_moreBtn:(UIButton *)sender {
    MonthEventModel *monthEventModel = [self getDataSourceWithIndexPath:sender.axcIndexPath];
    monthEventModel.cellHeight = sender.selected ? kStartingCellHeight : 200;
    monthEventModel.isSelect = !sender.selected;        // 已选中展开
    [self.tableView beginUpdates];
    [UIView animateWithDuration:0.3 animations:^{
        sender.transform = CGAffineTransformMakeRotation(AxcDraw_Angle(monthEventModel.isSelect ? 180 : 0));
    }];
    [self.tableView reloadRowsAtIndexPaths:@[sender.axcIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    sender.selected = !sender.selected;
}
#pragma mark - Table|Delegate
// 上滑隐藏Nav
static CGFloat onOffsetY = 0;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.isHideNavigation) {
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY > self.axcTopBarAllHeight) {
            [self.navigationController setNavigationBarHidden:(onOffsetY < offsetY) animated:YES];
        }
        onOffsetY = offsetY;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
}
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataListArray.count;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    TaskModel *model = self.dataListArray[section];
    return model.monthEvents.count;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self getDataSourceWithIndexPath:indexPath].cellHeight;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    TaskModel *model = self.dataListArray[section];
    if ([model.date AxcTool_isThisMonth] && [model.date AxcTool_isThisYear] ) return @"今月";
    return [model.date AxcTool_getDateWithFomant:MonthFormat];
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    TaskModel *model = self.dataListArray[section];
    BOOL isToday = ([model.date AxcTool_isThisMonth] && [model.date AxcTool_isThisYear]);
    header.backgroundView.backgroundColor = isToday ? kSelectedColor : kNavDarkColor;
    header.textLabel.textColor = [UIColor whiteColor] ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"axc"];
    cell.monthEvent = [self getDataSourceWithIndexPath:indexPath];
    cell.unfoldBtn_.axcIndexPath = cell.unfoldBtn.axcIndexPath = indexPath;
    [cell.unfoldBtn addTarget:self action:@selector(click_moreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.unfoldBtn_ addTarget:self action:@selector(click_moreBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.leftButtons = [self leftButtonsColor:kViceColor];
    cell.rightButtons = [self rightButtonsColor:kViceColor];
    cell.rightSwipeSettings.transition = MGSwipeTransitionStatic;
    cell.leftSwipeSettings.transition = MGSwipeTransitionDrag;
    // 设置中心的快速滑动处理
    cell.rightExpansion.buttonIndex = cell.leftExpansion.buttonIndex = self.isSwipeSettings ? 0 : -1;
    cell.swipeBackgroundColor = kViceColor;
    // 注册3DTouch
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        //给cell注册3DTouch的peek（预览）和pop功能 ，注册(在哪个页面上使用该功能就注册在哪个页面上)
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }
    return cell;
}
- (MonthEventModel *)getDataSourceWithIndexPath:(NSIndexPath *)indexPath{
    TaskModel *model = self.dataListArray[indexPath.section];
    return model.monthEvents[indexPath.row];
}
#define SwipeButtonWidth 50
- (NSArray <MGSwipeButton *>*)leftButtonsColor:(UIColor *)itemColor{
    WeakSelf;
    MGSwipeButton *completeBtn = [self swipeBtnWithImg:@"complete" color:itemColor callBack:^(TaskCell * _Nonnull cell) {
        [weakSelf completeDataWithIndexPath:cell.unfoldBtn.axcIndexPath];
    }];
    return @[completeBtn];
}
- (NSArray <MGSwipeButton *>*)rightButtonsColor:(UIColor *)itemColor{
    WeakSelf;
    MGSwipeButton *deleteBtn = [self swipeBtnWithImg:@"delete" color:itemColor callBack:^(TaskCell * _Nonnull cell) {
        [weakSelf deleteDataWithIndexPath:cell.unfoldBtn.axcIndexPath animation:UITableViewRowAnimationLeft];
    }];
    return @[deleteBtn];
}
- (MGSwipeButton *)swipeBtnWithImg:(NSString *)imgName color:(UIColor *)itemColor callBack:(void (^)(TaskCell * _Nonnull cell))callBack{
    MGSwipeButton *swipeBtn = [MGSwipeButton buttonWithTitle:@""
                              icon:[UIImage imageNamed:imgName]
                   backgroundColor:itemColor
                          callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
                              TaskCell *cell_ = (TaskCell *)cell;
                              callBack(cell_);
                              return YES;
                          }];
    swipeBtn.buttonWidth = SwipeButtonWidth;
    swipeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    return swipeBtn;
}

#pragma mark - 懒加载
- (DZNSegmentedControl *)titleSegmentedControl{
    if (!_titleSegmentedControl) {
        _titleSegmentedControl = [[DZNSegmentedControl alloc] initWithItems:@[@"待处理",@"已完成"]];
        _titleSegmentedControl.backgroundColor = [UIColor clearColor];
        _titleSegmentedControl.frame = CGRectMake(0, 0, 130, 28);
        _titleSegmentedControl.tintColor = kSelectedColor;
        _titleSegmentedControl.showsCount = NO;
        _titleSegmentedControl.hairlineColor = [UIColor clearColor];
        [_titleSegmentedControl setTitleColor:kUncheckColor forState:UIControlStateNormal];
        [_titleSegmentedControl addTarget:self action:@selector(loadDataBaseData) forControlEvents:UIControlEventValueChanged];
    }
    return _titleSegmentedControl;
}
#pragma mark - 3DTouch
#pragma mark UIViewControllerPreviewingDelegate（实现代理的方法）
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = kMainBackColor;
    //获取按压的cell所在行，[previewingContext sourceView]就是按压的那个视图
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    //设定预览的界面
    //调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面）
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width,kStartingCellHeight);
    previewingContext.sourceRect = rect;
    
    return vc;
}
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self.navigationController pushViewController:viewControllerToCommit animated:YES];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kNotification_TaskQuickOperationChange object:nil];
}
@end
