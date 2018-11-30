//
//  ActivityPageFrameworkVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "ActivityPageFrameworkVC.h"

@interface ActivityPageFrameworkVC ()
// 今日
@property(nonatomic , strong , readonly)NSDate *today;
// 每周数组
@property(nonatomic , strong)NSMutableArray <DayActivityModel *>*weekAcitvityArray;
// 今日的角标Label
@property(nonatomic , strong)UILabel *todayBadge;
@end

@implementation ActivityPageFrameworkVC

#define kMenuHeight 35
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
    
    [self loadData];
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
        [self.weekAcitvityArray addObject:[DayActivityModel title:weekTitle[idx] date:obj]];
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
        self.todayBadge.frame = CGRectMake(initialMenuItem.axcTool_width - 20, 0, 25, 13);
        [initialMenuItem addSubview:self.todayBadge];
        [_todayBadge AxcTool_cornerWithRadius:self.todayBadge.axcTool_height/2];
    }
    return initialMenuItem;
}

#pragma mark - 懒加载
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
