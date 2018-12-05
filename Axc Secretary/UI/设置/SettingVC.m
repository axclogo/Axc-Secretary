//
//  SettingVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/10/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "SettingVC.h"
#import "SettingCell.h"

#import "LLDebug.h"

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}
- (void)requestData{
    // 移除所有数据
    [self.dataListArray removeAllObjects];
    WeakSelf;
    /** 事项左右滑动的设定 **************************************/
    SettingModel *taskSwipeSettings = [SettingModel title:@"滑动快速处理"
                                               settingKey:kSetting_TaskQuickOperation];
    taskSwipeSettings.settingType = SettingTypeSwitch;
    taskSwipeSettings.tiggerBlock = ^(id  _Nonnull obj) {
        [weakSelf.notificationCenter postNotificationName:kNotification_TaskQuickOperationChange object:nil];
    };
    /** 事项页自动隐藏导航条 **************************************/
    SettingModel *hideNavigationSetting = [SettingModel title:@"上滑时自动隐藏导航条"
                                                    settingKey:kSetting_HideNavigation];
    hideNavigationSetting.settingType = SettingTypeSwitch;
    
    /** 主题变更 **************************************/
    SettingModel *themeSettings = [SettingModel title:@"变更主题"
                                             disTitle:@"黑色"];
    themeSettings.settingType = SettingTypeDisTitle;
    themeSettings.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    themeSettings.tiggerBlock = ^(id  _Nonnull obj) {
        [self AxcTool_pushVCName:@"SwitchThemeVC"];
    };
    
    /** 图标变更 **************************************/
    SettingModel *iconSettings = [SettingModel title:@"变更App图标"
                                             disTitle:@""];
    iconSettings.settingType = SettingTypeDisTitle;
    iconSettings.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    iconSettings.tiggerBlock = ^(id  _Nonnull obj) {
        [self AxcTool_pushVCName:@"SwitchIconVC"];
    };
    ////////////////////////////////////////////////////////////
    SettingGroupModel *UIGroupModel = [SettingGroupModel title:@"界面"
                                                     subModels:@[taskSwipeSettings,hideNavigationSetting,themeSettings,iconSettings]];
    [self.dataListArray addObject:UIGroupModel];
    
    
    
    /** 清理缓存 **************************************/
    CGFloat cache = ([[SDImageCache sharedImageCache] getSize]/1000.f/1000.f);
    SettingModel *clearCache = [SettingModel title:@"清理缓存"
                                          disTitle:[NSString stringWithFormat:@"%.2fMB", cache]];
    clearCache.settingType = SettingTypeDisTitle;
    clearCache.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    clearCache.tiggerBlock = ^(id  _Nonnull obj) {
        kDISPATCH_GLOBAL_QUEUE_DEFAULT(^{   //   异步清缓存
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                [[SDImageCache sharedImageCache] clearMemory];
                [SVProgressHUD showSuccessWithStatus:@"清理完成!"];
                [weakSelf requestData];
            }];
        });
    };
    /** 定位精度 **************************************/
    SettingModel *positioningAccuracy = [SettingModel title:@"定位精度"
                                                   disTitle:[AxcLocation getCurrentPositioningAccuracy]
                                                 settingKey:kSetting_PositioningAccuracy];
    positioningAccuracy.settingType = SettingTypeDisTitleIQDropDownTextField;
    positioningAccuracy.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    positioningAccuracy.selectArray = POSITIONING_ACCURACYS;
    /** DeBug的气泡开关 **************************************/
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
    ////////////////////////////////////////////////////////////
    SettingGroupModel *otherGroupModel = [SettingGroupModel title:@"性能"
                                                        subModels:@[clearCache,positioningAccuracy,debugAirBubblesSetting]];
    [self.dataListArray addObject:otherGroupModel];
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

