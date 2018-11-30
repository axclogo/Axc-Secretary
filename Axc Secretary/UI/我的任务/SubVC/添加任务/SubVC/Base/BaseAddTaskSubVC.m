//
//  BaseAddTaskSubVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "BaseAddTaskSubVC.h"

@interface BaseAddTaskSubVC ()

@end

@implementation BaseAddTaskSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)createUI{
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
        if (self.view.safeAreaInsets.bottom) {
            make.bottom.mas_equalTo(-self.view.safeAreaInsets.bottom);
        }else{
            make.bottom.mas_equalTo(-40);
        }
    }];
}

#pragma mark - 触发事件
- (void)click_confirmBtn{
}

#pragma mark - 懒加载
- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [self AxcBase_createButtonWithImage:nil
                                                    title:@"添 加"
                                                     font:[UIFont systemFontOfSize:14]
                                                   action:@selector(click_confirmBtn)];
        _confirmBtn.backgroundColor = kSelectedColor;
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_confirmBtn AxcTool_cornerWithRadius:5];
        [self.view addSubview:_confirmBtn];
    }
    return _confirmBtn;
}

@end
