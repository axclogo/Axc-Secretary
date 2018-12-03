//
//  AddTaskVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/23.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AddTaskVC.h"
#import "TaskTypeModel.h"

@interface AddTaskVC ()<
WMPageControllerDataSource,
WMPageControllerDelegate
>
// 任务类型分页控制器
@property(nonatomic, strong)WMPageController *taskTypeVC;
// 任务类型数组
@property(nonatomic , strong)NSMutableArray <TaskTypeModel *>*taskTypeArray;

@end

@implementation AddTaskVC

#define kMenuHeight 40

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}
- (void)createUI{
    self.title = @"添加新任务";
    [self.taskTypeVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}
- (void)loadData{
    [self.taskTypeArray addObject:[TaskTypeModel title:@"普通任务" vcName:@"OrdinaryTaskVC"]];
    [self.taskTypeArray addObject:[TaskTypeModel title:@"每日活动" vcName:@"AddActivityVC"]];
    
    [self.taskTypeArray addObject:[TaskTypeModel title:@"添加记录" vcName:@"HistoricalRecordTaskVC"]];
    [self.taskTypeVC reloadData];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.taskTypeVC forceLayoutSubviews];
    _taskTypeVC.view.backgroundColor =
    _taskTypeVC.scrollView.backgroundColor =
    self.view.backgroundColor;
}
#pragma mark - 触发事件


#pragma mark - PageViewDelegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.taskTypeArray.count;
}
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    TaskTypeModel *model = [self.taskTypeArray objectAtIndex:index];
    return model.vc;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    TaskTypeModel *model = [self.taskTypeArray objectAtIndex:index];
    return model.title;
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{
    CGFloat Y = kMenuHeight;
    return CGRectMake(0, Y, self.isHorizontal ? kScreenHeight : kScreenWidth,
                      pageController.view.axcTool_height - Y);
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    menuView.backgroundColor = kNavColor;
    return CGRectMake(0, 0, self.isHorizontal ? kScreenHeight : kScreenWidth, kMenuHeight);
}

#pragma mark - 懒加载
- (NSMutableArray<TaskTypeModel *> *)taskTypeArray{
    if (!_taskTypeArray)  _taskTypeArray = @[].mutableCopy;
    return _taskTypeArray;
}
- (WMPageController *)taskTypeVC{
    if (!_taskTypeVC) {
        _taskTypeVC = [[WMPageController alloc] init];
        _taskTypeVC.dataSource = self;
        _taskTypeVC.menuViewStyle = WMMenuViewStyleLine;
        _taskTypeVC.progressViewCornerRadius = 0.1;
        _taskTypeVC.menuViewLayoutMode = WMMenuViewLayoutModeLeft;
        _taskTypeVC.progressViewIsNaughty = YES;
        _taskTypeVC.titleColorSelected = kSelectedColor;
        _taskTypeVC.titleColorNormal = kUncheckColor;
        _taskTypeVC.progressColor = kSelectedColor;
        _taskTypeVC.titleSizeSelected = 15.0;
        _taskTypeVC.titleSizeNormal = 12.0;
        _taskTypeVC.progressHeight = 2;
        _taskTypeVC.menuViewContentMargin = 10;
        _taskTypeVC.itemMargin = 5;
        [self addChildViewController:_taskTypeVC];
        [self.view addSubview:_taskTypeVC.view];
    }
    return _taskTypeVC;
}

@end
