//
//  ActivityVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/23.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "ActivityVC.h"
#import "ActivityPageFrameworkVC.h"


@interface ActivityVC ()
// 周分页控制器
@property(nonatomic, strong)ActivityPageFrameworkVC *weekAcitvityVC;
@end

@implementation ActivityVC


- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)createUI{
    WeakSelf;
    [self AxcBase_addBarButtonItem:AxcBaseBarButtonItemLocationRight image:@"today" handler:^(UIButton *barItemBtn) {
        [weakSelf.weekAcitvityVC goToday];  // 回到今日
    }];
    [self.weekAcitvityVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.weekAcitvityVC forceLayoutSubviews];
    self.weekAcitvityVC.view.backgroundColor =
    self.weekAcitvityVC.scrollView.backgroundColor =
    self.view.backgroundColor;
}



- (ActivityPageFrameworkVC *)weekAcitvityVC{
    if (!_weekAcitvityVC) {
        _weekAcitvityVC = [[ActivityPageFrameworkVC alloc] init];
        [self addChildViewController:_weekAcitvityVC];
        [self.view addSubview:_weekAcitvityVC.view];
    }
    return _weekAcitvityVC;
}



@end
