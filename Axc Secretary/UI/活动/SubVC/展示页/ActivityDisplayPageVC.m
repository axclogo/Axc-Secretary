//
//  ActivityDisplayPageVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "ActivityDisplayPageVC.h"
#import "ActivityHeaderView.h"

@interface ActivityDisplayPageVC ()
@property(nonatomic , strong)ActivityHeaderView *tableHeaderView;
@end

@implementation ActivityDisplayPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)createUI{
    [self AxcBase_settingTableType:UITableViewStylePlain nibName:@"ActivityDisplayPageCell" cellID:@"axc"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = kMainBackColor;
    self.tableView.tableHeaderView = self.tableHeaderView;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#define DurationTime 0.5
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.alpha = 0;
    [UIView animateWithDuration:DurationTime animations:^{
        self.view.alpha = 1;
    }];
}


- (void)setDataListArray:(NSMutableArray *)dataListArray{
    [super setDataListArray:dataListArray];
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableHeaderView.frame = CGRectMake(0, 0, self.isHorizontal ? kScreenHeight : kScreenWidth, 65);
    self.tableView.tableHeaderView = self.tableHeaderView;
}

#pragma mark - delegate
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ActivityModel *model = self.dataListArray[section];
    return model.hoursActivitys.count;
}
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataListArray.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"aa";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityDisplayPageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"axc"];
    cell.axcIndexPath = indexPath;
    BOOL isStart = indexPath.row == 0 && indexPath.section == 0;
    cell.startPointLayer.hidden = !isStart;
    ActivityModel *model = self.dataListArray[indexPath.section];
    BOOL isEnd = indexPath.section == self.dataListArray.count-1 && indexPath.row == model.hoursActivitys.count-1;
    cell.endPointLayer.hidden = !isEnd;
    return cell;
}


#pragma mark - 懒加载
- (ActivityHeaderView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [ActivityHeaderView new];
        _tableHeaderView.backgroundColor = self.tableView.backgroundColor;
        _tableHeaderView.date = self.date;
    }
    return _tableHeaderView;
}




@end
