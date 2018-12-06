//
//  ActivityPageFrameworkVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "ActivityPageFrameworkVC.h"

@interface ActivityPageFrameworkVC ()
// 今日的角标Label
@property(nonatomic , strong)UILabel *todayBadge;
// 左右的渐变
@property(nonatomic , strong)CAGradientLayer *leftGradientLayer;
@property(nonatomic , strong)CAGradientLayer *rightGradientLayer;

@end

@implementation ActivityPageFrameworkVC

#define isHorizontal (([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) || ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight))

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuViewStyle = WMMenuViewStyleFlood;
    self.progressViewCornerRadius = 0.1;
    self.menuViewLayoutMode = WMMenuViewLayoutModeScatter;
    self.progressViewIsNaughty = YES;
    self.titleColorSelected = [UIColor whiteColor];
    self.titleColorNormal = kUncheckColor;
    self.titleSizeSelected = 14.0;
    self.titleSizeNormal = 11.0;
    self.menuViewContentMargin = 10;
    self.itemMargin = 5;
    self.progressColor = kSelectedColor;
    self.progressHeight = kMenuHeight - 5;
    self.progressWidth = 50;
    self.progressViewCornerRadius = kMenuHeight/2;
    self.pageAnimatable = YES;
    
    [self loadData];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGFloat gradientLayerWidth = 40;
    self.leftGradientLayer.frame = CGRectMake(0, 0, gradientLayerWidth, kMenuHeight);
    self.rightGradientLayer.frame = CGRectMake(self.menuView.axcTool_width - gradientLayerWidth, 0, gradientLayerWidth, kMenuHeight);
}


- (void)loadData{
    // 计算这周的所有日期
    NSMutableArray <NSDate *>*dates = @[].mutableCopy;
    NSDate *today = [NSDate date];
    NSArray *weekTitle = WEEK_DAY_STRINGS;
    for (int i = (int )today.week; i > 0; i --) {
        [dates addObject:[today AxcTool_dateByAddingDays:-i]];
    }
    for (int i = 0; i < weekTitle.count - today.week; i ++) {
        [dates addObject:[today AxcTool_dateByAddingDays:i]];
    }
    // 设置数列
    [dates enumerateObjectsUsingBlock:^(NSDate * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DayActivityModel *model = [DayActivityModel title:weekTitle[idx] date:obj];
        // 设置内容二维
        NSMutableArray <ActivityModel *>*activitys = @[].mutableCopy;
        for (int i = 0; i < 3; i ++) {
            ActivityModel *activityModel = [ActivityModel new];
            NSMutableArray *cells = @[].mutableCopy;
            for (int j = 0; j < 4; j ++) {
                ActivityCellModel *cellModel = [ActivityCellModel new];
                cellModel.date = [[NSDate date] AxcTool_dateByAddingDays:-4 + j];
                [cells addObject:cellModel];
            }
            activityModel.hoursActivitys = cells;
            [activitys addObject:activityModel];
        }
        
        model.vc.dataListArray = activitys;
        [self.weekAcitvityArray addObject:model];
    }];
    [self reloadData];
    // 自动选中今日周
    [self goToday];
}
- (void)goToday{
    self.selectIndex = (int )self.today.week;
}

#pragma mark - PageViewDelegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.weekAcitvityArray.count;
}
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    DayActivityModel *model = [self.weekAcitvityArray objectAtIndex:index];
    return model.vc;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    DayActivityModel *model = [self.weekAcitvityArray objectAtIndex:index];
    return model.title;
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{
    CGFloat Y = kMenuHeight;
    return CGRectMake(0, Y, isHorizontal ? kScreenHeight : kScreenWidth,
                      pageController.view.axcTool_height - Y);
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    menuView.backgroundColor = kNavColor;
    return CGRectMake(0, 0, isHorizontal ? kScreenHeight : kScreenWidth, kMenuHeight);
}
- (WMMenuItem *)menuView:(WMMenuView *)menu initialMenuItem:(WMMenuItem *)initialMenuItem atIndex:(NSInteger)index{
    if (index == self.today.week) {
        self.todayBadge.frame = CGRectMake(initialMenuItem.axcTool_width - 17, 2, 25, 13);
        [initialMenuItem addSubview:self.todayBadge];
        [_todayBadge AxcTool_cornerWithRadius:self.todayBadge.axcTool_height/2];
    }
    return initialMenuItem;
}

#pragma mark - 懒加载
// 渐变色
- (CAGradientLayer *)leftGradientLayer{
    if (!_leftGradientLayer) {
        _leftGradientLayer = [CAGradientLayer new];
        _leftGradientLayer.colors = @[(id)[kNavColor colorWithAlphaComponent:1].CGColor ,
                                      (id)[kNavColor colorWithAlphaComponent:0].CGColor ];
        _leftGradientLayer.locations = @[[NSNumber numberWithFloat:0.3],
                                         [NSNumber numberWithFloat:0.7]];
        _leftGradientLayer.startPoint = CGPointMake(0, 0);
        _leftGradientLayer.endPoint = CGPointMake(1, 0);
        [self.menuView.layer addSublayer:_leftGradientLayer];
    }
    return _leftGradientLayer;
}
- (CAGradientLayer *)rightGradientLayer{
    if (!_rightGradientLayer) {
        _rightGradientLayer = [CAGradientLayer new];
        _rightGradientLayer.colors = self.leftGradientLayer.colors;
        _rightGradientLayer.locations = self.leftGradientLayer.locations;
        _rightGradientLayer.startPoint = self.leftGradientLayer.endPoint;
        _rightGradientLayer.endPoint = self.leftGradientLayer.startPoint;
        [self.menuView.layer addSublayer:_rightGradientLayer];
    }
    return _rightGradientLayer;
}
- (UILabel *)todayBadge{
    if (!_todayBadge) {
        _todayBadge = [[UILabel alloc] init];
        _todayBadge.text = @"今日";
        _todayBadge.textColor = [UIColor whiteColor];
        _todayBadge.backgroundColor = kWarningColor;
        _todayBadge.font = [UIFont systemFontOfSize:8];
        _todayBadge.textAlignment = NSTextAlignmentCenter;
    }
    return _todayBadge;
}
- (NSDate *)today{
    return [NSDate date];
}
- (NSMutableArray<DayActivityModel *> *)weekAcitvityArray{
    if (!_weekAcitvityArray)  _weekAcitvityArray = @[].mutableCopy;
    return _weekAcitvityArray;
}

@end
