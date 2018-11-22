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

@interface MyTaskVC ()

@property(nonatomic , strong)DZNSegmentedControl *titleSegmentedControl;

@end

@implementation MyTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)createUI{
    self.navigationItem.titleView = self.titleSegmentedControl;
    self.navigationController.navigationBar.prefersLargeTitles = YES; // 滑动大标题
    WeakSelf;
    [self AxcBase_addBarButtonItem:AxcBaseBarButtonItemLocationRight image:@"add_white" handler:^(UIButton *barItemBtn) {
        [weakSelf insertTask];
    }];
    [self AxcBase_settingTableType:UITableViewStylePlain nibName:@"TaskCell" cellID:@"axc"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
}
- (void)insertTask{
    MonthEventModel *monthEventModel = [MonthEventModel new];
    monthEventModel.cellHeight = kStartingCellHeight;
    monthEventModel.level = arc4random()%11;
    monthEventModel.title = @"洗衣服";
    monthEventModel.date = [NSDate AxcTool_getDateString:[NSString stringWithFormat:@"2019-%d-%d",arc4random()%12+1,arc4random()%10+10] withFomant:@"yyyy-MM-dd"];
    monthEventModel.Introduction = @"我将去楼下将衣服交给洗衣机处理";
    monthEventModel.addDate = [NSDate date];
    [self.db addTaskMatter:monthEventModel];
    [self requestData];
}
- (void)requestData{
    self.dataListArray = [self.db getAllTaskMatters].mutableCopy;
    
    [self.tableView reloadData];
}


- (void )click_moreBtn:(UIButton *)sender {
    MonthEventModel *monthEventModel = [self getDataSourceWithIndexPath:sender.axcIndexPath];
    monthEventModel.cellHeight = sender.selected ? kStartingCellHeight : 200;
    monthEventModel.isSelect = !sender.selected;        // 已选中展开
    [self.tableView beginUpdates];
    sender.transform = CGAffineTransformMakeRotation(AxcDraw_Angle(monthEventModel.isSelect ? 180 : 0));
    [self.tableView reloadRowsAtIndexPaths:@[sender.axcIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    sender.selected = !sender.selected;
}
#pragma mark - 事项操作函数复用
- (void)completeDataWithIndexPath:(NSIndexPath *)indexPath{
    // 数据库标记该事项已完成
    TaskModel *model = self.dataListArray[indexPath.section];
    MonthEventModel *monthModel = model.monthEvents[indexPath.row];
    [self.db completeTaskMatter:monthModel];
    // 动画删除
    [self removeRowWithIndexPath:indexPath animation:UITableViewRowAnimationRight];
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@\n已完成！",monthModel.title]];
}
- (void)deleteDataWithIndexPath:(NSIndexPath *)indexPath animation:(UITableViewRowAnimation )animation{
    // 数据库删除
    [self.db deleteTaskMatter:[self getDataSourceWithIndexPath:indexPath]];
    // 动画删除
    [self removeRowWithIndexPath:indexPath animation:animation];
}
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

#pragma mark - Table|Delegate
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
    header.backgroundView.backgroundColor = ([model.date AxcTool_isThisMonth] && [model.date AxcTool_isThisYear]) ? KScienceTechnologyBlue : kBackColor;
    header.textLabel.textColor = [UIColor whiteColor];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"axc"];
    cell.monthEvent = [self getDataSourceWithIndexPath:indexPath];
    cell.unfoldBtn_.axcIndexPath = cell.unfoldBtn.axcIndexPath = indexPath;
    [cell.unfoldBtn addTarget:self action:@selector(click_moreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.unfoldBtn_ addTarget:self action:@selector(click_moreBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.leftButtons = [self leftButtons];
    cell.rightButtons = [self rightButtons];
    cell.rightSwipeSettings.transition = MGSwipeTransitionStatic;
    cell.leftSwipeSettings.transition = MGSwipeTransitionDrag;
//    cell.leftExpansion.buttonIndex = 0;
    cell.swipeBackgroundColor = [UIColor groupTableViewBackgroundColor];
    return cell;
}
- (MonthEventModel *)getDataSourceWithIndexPath:(NSIndexPath *)indexPath{
    TaskModel *model = self.dataListArray[indexPath.section];
    return model.monthEvents[indexPath.row];
}
#define SwipeButtonWidth 60
- (NSArray <MGSwipeButton *>*)leftButtons{
    WeakSelf;
    MGSwipeButton *completeBtn = [self swipeBtnWithImg:@"complete" callBack:^(TaskCell * _Nonnull cell) {
        [weakSelf completeDataWithIndexPath:cell.unfoldBtn.axcIndexPath];
    }];
    return @[completeBtn];
}
- (NSArray <MGSwipeButton *>*)rightButtons{
    WeakSelf;
    MGSwipeButton *deleteBtn = [self swipeBtnWithImg:@"delete" callBack:^(TaskCell * _Nonnull cell) {
        [weakSelf deleteDataWithIndexPath:cell.unfoldBtn.axcIndexPath animation:UITableViewRowAnimationLeft];
    }];
    return @[deleteBtn];
}
- (MGSwipeButton *)swipeBtnWithImg:(NSString *)imgName callBack:(void (^)(TaskCell * _Nonnull cell))callBack{
    MGSwipeButton *swipeBtn = [MGSwipeButton buttonWithTitle:@""
                              icon:[UIImage imageNamed:imgName]
                   backgroundColor:[UIColor groupTableViewBackgroundColor]
                          callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
                              TaskCell *cell_ = (TaskCell *)cell;
                              callBack(cell_);
                              return YES;
                          }];
    swipeBtn.buttonWidth = SwipeButtonWidth;
    swipeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    return swipeBtn;
}

- (DZNSegmentedControl *)titleSegmentedControl{
    if (!_titleSegmentedControl) {
        _titleSegmentedControl = [[DZNSegmentedControl alloc] initWithItems:@[@"待处理",@"打卡任务",@"已完成"]];
        _titleSegmentedControl.backgroundColor = [UIColor clearColor];
        _titleSegmentedControl.frame = CGRectMake(0, 0, 200, 28);
        _titleSegmentedControl.tintColor = KScienceTechnologyBlue;
        _titleSegmentedControl.showsCount = NO;
        _titleSegmentedControl.hairlineColor = [UIColor clearColor];
        [_titleSegmentedControl setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_titleSegmentedControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    }
    return _titleSegmentedControl;
}
@end
