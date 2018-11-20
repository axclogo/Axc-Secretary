//
//  MyTaskVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/10/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "MyTaskVC.h"
#import "TaskCell.h"

#define kStartingCellHeight 60

@interface MyTaskVC ()

@end

@implementation MyTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)createUI{
    [self AxcBase_addBarButtonItem:AxcBaseBarButtonItemLocationRight image:@"add_white"];
    [self AxcBase_settingTableType:UITableViewStylePlain nibName:@"TaskCell" cellID:@"axc"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
}
- (void)requestData{
    for (int i = 0; i < 3; i ++) {
        TaskModel *model_0 = [TaskModel new];
        NSInteger month = i + 10;
        model_0.date = [NSDate AxcTool_getDateString:[NSString stringWithFormat:@"2018 年 %ld 月",month] withFomant:MonthFormat];
        
        NSMutableArray *arr = @[].mutableCopy;
        for (int j = 0; j < arc4random()%10+10; j ++) {
            MonthEventModel *monthEventModel = [MonthEventModel new];
            monthEventModel.cellHeight = kStartingCellHeight;
            monthEventModel.level = arc4random()%11;
            monthEventModel.title = @"洗衣服";
            monthEventModel.date = [NSDate AxcTool_getDateString:[NSString stringWithFormat:@"2018-%ld-%d",month,j+arc4random()%10+10] withFomant:@"yyyy-MM-dd"];
            monthEventModel.Introduction = @"我将去楼下将衣服交给洗衣机处理我将去楼下将衣服交给洗衣机处理我将去楼下将衣服交给洗衣机处理";
            [arr addObject:monthEventModel];
        }
        model_0.monthEvents = arr;
        [self.dataListArray addObject:model_0];
    }
    [self.tableView reloadData];
}
- (void )click_moreBtn:(UIButton *)sender {
    MonthEventModel *monthEventModel = [self getDataSourceWithIndexPath:sender.axcIndexPath];
    monthEventModel.cellHeight = sender.selected ? kStartingCellHeight : 200;
    monthEventModel.isSelect = !sender.selected;        // 已选中展开
    [self.tableView beginUpdates];
    sender.transform = CGAffineTransformMakeRotation(AxcDraw_Angle(monthEventModel.isSelect ? 180 : 0));
    [self.tableView reloadRowsAtIndexPaths:@[sender.axcIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    sender.selected = !sender.selected;
}
#pragma mark - 复用
- (void)deleteDataWithIndexPath:(NSIndexPath *)indexPath{
    TaskModel *model = self.dataListArray[indexPath.section];
    NSMutableArray *arr_M = model.monthEvents.mutableCopy;
    [arr_M removeObjectAtIndex:indexPath.row];
    model.monthEvents = arr_M;
    [self.dataListArray replaceObjectAtIndex:indexPath.section withObject:model];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.3];    // 数据对齐
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
    return [model.date AxcTool_getDateWithFomant:MonthFormat];
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
    cell.rightExpansion.buttonIndex = cell.leftExpansion.buttonIndex = 0;
    cell.swipeBackgroundColor = [UIColor AxcTool_colorHex:@"f6f6f6"];
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

    }];
    return @[completeBtn];
}
- (NSArray <MGSwipeButton *>*)rightButtons{
    WeakSelf;
    MGSwipeButton *deleteBtn = [self swipeBtnWithImg:@"delete" callBack:^(TaskCell * _Nonnull cell) {
        [weakSelf deleteDataWithIndexPath:cell.unfoldBtn.axcIndexPath];
    }];
    return @[deleteBtn];
}
- (MGSwipeButton *)swipeBtnWithImg:(NSString *)imgName callBack:(void (^)(TaskCell * _Nonnull cell))callBack{
    MGSwipeButton *swipeBtn = [MGSwipeButton buttonWithTitle:@""
                              icon:[UIImage imageNamed:imgName]
                   backgroundColor:[UIColor AxcTool_colorHex:@"f6f6f6"]
                          callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
                              TaskCell *cell_ = (TaskCell *)cell;
                              callBack(cell_);
                              return YES;
                          }];
    swipeBtn.buttonWidth = SwipeButtonWidth;
    swipeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    return swipeBtn;
}
@end
