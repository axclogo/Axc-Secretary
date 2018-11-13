//
//  BaseTabbarVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/10/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "BaseTabbarVC.h"
#import "AxcNavVC.h"

@interface BaseTabbarVC ()<AxcAE_TabBarDelegate>

@end

@implementation BaseTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.axcTabBar.frame = self.tabBar.bounds;
    [self.axcTabBar viewDidLayoutItems];
}
- (void)createUI{
    
    NSArray <NSDictionary *>*tabBarItems =
    @[@{@"VCName":@"MyTaskVC",@"itemTitle":@"任务",@"VCTitle":@"我的任务",@"nomalImageName":@"tabbar_task"},
      @{@"VCName":@"MyItemsVC",@"itemTitle":@"物品",@"VCTitle":@"我的物品",@"nomalImageName":@"tabbat_items"},
      @{@"VCName":@"TrendChartVC",@"itemTitle":@"趋势",@"VCTitle":@"趋势图表",@"nomalImageName":@"tabbar_trend"},
      @{@"VCName":@"AlbumSafeVC",@"itemTitle":@"相册",@"VCTitle":@"相册保险柜",@"nomalImageName":@"tabbar_photo"},
      @{@"VCName":@"SettingVC",@"itemTitle":@"设置",@"VCTitle":@"设置",@"nomalImageName":@"tabbar_setting"}];
    NSMutableArray *VCs = @[].mutableCopy;
    NSMutableArray *configs = @[].mutableCopy;
    [tabBarItems enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AxcAE_TabBarConfigModel *model = [AxcAE_TabBarConfigModel new];
        model.itemTitle = [obj objectForKey:@"itemTitle"];
        // 未点击状态
        model.normalImageName = [obj objectForKey:@"nomalImageName"];
        model.normalColor = [UIColor lightGrayColor];
        model.normalTintColor = [UIColor lightGrayColor];
        model.normalBackgroundColor = [UIColor clearColor];
        // 点击状态
        model.selectImageName = [obj objectForKey:@"nomalImageName"];
        model.selectColor = KScienceTechnologyBlue;
        model.selectTintColor = KScienceTechnologyBlue; // 直接渲染颜色即可
        model.selectBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        // 设置所有点击动画
        model.interactionEffectStyle = AxcAE_TabBarInteractionEffectStyleSpring;
        // 实例化
        NSString *VCName = [obj objectForKey:@"VCName"];
        Class VC_Class = NSClassFromString(VCName);
        UIViewController *viewController = [[VC_Class alloc]init];
        viewController.title = [obj objectForKey:@"VCTitle"];
        [VCs addObject:[[AxcNavVC alloc] initWithRootViewController:viewController]];
        [configs addObject:model];
    }];
    self.viewControllers = VCs;
    
    // 将自定义的覆盖到原来的tabBar上面
    self.axcTabBar = [[AxcAE_TabBar alloc] initWithTabBarConfig:configs];
    /// 设置委托
    self.axcTabBar.delegate = self;
    //    self.axcTabBar.backgroundImageView.image = [UIImage imageNamed:@"tabBarBackGround"];
    self.axcTabBar.backgroundColor = kBackColor;
    //    self.axcTabBar.translucent = YES;
    [self.tabBar addSubview:self.axcTabBar];
}

- (void)axcAE_TabBar:(AxcAE_TabBar *)tabbar selectIndex:(NSInteger)index{
    // 通知 切换视图控制器
    [self setSelectedIndex:index];
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    if(self.axcTabBar){
        self.axcTabBar.selectIndex = selectedIndex;
    }
}


@end
