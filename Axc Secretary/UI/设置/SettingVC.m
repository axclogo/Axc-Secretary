//
//  SettingVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/10/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "SettingVC.h"
#import "SettingCell.h"

#import <LLDebug.h>

@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)createUI{
    [self AxcBase_settingTableType:UITableViewStyleGrouped nibName:@"SettingCell" cellID:@"axc"];
    self.tableView.backgroundColor = kMainBackColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}
- (void)requestData{
    WeakSelf;
    SettingModel *taskSwipeSettings = [SettingModel title:@"滑动快速处理"
                                               settingKey:kSetting_TaskQuickOperation];
    taskSwipeSettings.settingType = SettingTypeSwitch;
    taskSwipeSettings.tiggerBlock = ^(id  _Nonnull obj) {
        [weakSelf.notificationCenter postNotificationName:kNotification_TaskQuickOperationChange object:nil];
    };
    
    SettingGroupModel *groupModel = [SettingGroupModel title:@"操作类"
                                                   subModels:@[taskSwipeSettings]];
    [self.dataListArray addObject:groupModel];

    SettingModel *debugAirBubblesSetting = [SettingModel title:@"开启调试气泡"
                                                    settingKey:kSetting_DebugAirBubbles];
    debugAirBubblesSetting.settingType = SettingTypeSwitch;
    debugAirBubblesSetting.tiggerBlock = ^(id  _Nonnull obj) {
        if (![obj integerValue]) {
            [[LLDebugTool sharedTool] startWorking];
        }else{
            [[LLDebugTool sharedTool] stopWorking];
        }
    };
    SettingGroupModel *groupModel1 = [SettingGroupModel title:@"其他"
                                                   subModels:@[debugAirBubblesSetting]];
    [self.dataListArray addObject:groupModel1];
}
#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingGroupModel *groupModel = self.dataListArray[indexPath.section];
    SettingModel *rowModel = groupModel.subModels[indexPath.row];
    [rowModel trigger];
    [tableView reloadData];
}
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataListArray.count;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SettingGroupModel *groupModel = self.dataListArray[section];
    return groupModel.subModels.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    SettingGroupModel *groupModel = self.dataListArray[section];
    return groupModel.title;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = kUncheckColor ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"axc"];
    SettingGroupModel *groupModel = self.dataListArray[indexPath.section];
    cell.model = groupModel.subModels[indexPath.row];
    return cell;
}


@end
