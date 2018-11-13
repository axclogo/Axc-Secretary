//
//  MyTaskVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/10/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "MyTaskVC.h"
#import "TaskCell.h"



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
        model_0.date = [NSDate AxcTool_getDateString:[NSString stringWithFormat:@"2018 年 %d 月",i + 10] withFomant:MonthFormat];
        
        NSMutableArray *arr = @[].mutableCopy;
        for (int j = 0; j < arc4random()%10+10; j ++) {
            MonthEventModel *monthEventModel = [MonthEventModel new];
            monthEventModel.title = @"洗衣服";
            monthEventModel.date = [NSDate AxcTool_getDateString:[NSString stringWithFormat:@"2018-11-%d",j+arc4random()%10+1] withFomant:@"yyyy-MM-dd"];
            monthEventModel.Introduction = @"我将去楼下将衣服交给洗衣机处理";
            [arr addObject:monthEventModel];
        }
        model_0.monthEvents = arr;
        [self.dataListArray addObject:model_0];
    }
    [self.tableView reloadData];
}
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataListArray.count;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    TaskModel *model = self.dataListArray[section];
    return model.monthEvents.count;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    TaskModel *model = self.dataListArray[section];
    return [model.date AxcTool_getDateWithFomant:MonthFormat];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"axc"];
    TaskModel *model = self.dataListArray[indexPath.section];
    cell.monthEvent = model.monthEvents[indexPath.row];
    return cell;
}


@end
