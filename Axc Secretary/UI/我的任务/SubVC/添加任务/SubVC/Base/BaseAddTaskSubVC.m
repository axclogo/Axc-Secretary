//
//  BaseAddTaskSubVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "BaseAddTaskSubVC.h"

@interface BaseAddTaskSubVC ()<RSKGrowingTextViewDelegate,UITextViewDelegate>


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
#define LRMargin 15
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGFloat stateMargin = LRMargin;
    if (!UIEdgeInsetsEqualToEdgeInsets(self.view.safeAreaInsets, UIEdgeInsetsZero)) {   // 全面屏手机
        UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
        if (orientation == UIDeviceOrientationLandscapeLeft) {
            stateMargin = self.axcStatusBarHeight + LRMargin;
        }
    }
    CGFloat maxWidth = (self.isHorizontal ? kScreenHeight  : kScreenWidth) - 2*stateMargin;
    // 任务名称布局
    self.taskNameTextFiled.frame = CGRectMake(stateMargin, 10, maxWidth, 50);
    self.taskNameTextFiled.bounds = self.taskNameTextFiled.bounds;
    // 描述输入框布局
    self.taskInstructionsTextView.frame  = CGRectMake(stateMargin,
                           self.taskNameTextFiled.axcTool_y + self.taskNameTextFiled.axcTool_height + 10,
                           maxWidth, self.taskInstructionsTextView.axcTool_height);
    [self.taskInstructionsTextView layoutIfNeeded];
    // 时间按钮布局
    [self layoutDateBtnFrame:NO];
}
- (void)layoutDateBtnFrame:(BOOL )animation{
    [UIView animateWithDuration:animation ? self.taskInstructionsTextView.heightChangeAnimationDuration : 0 animations:^{
        self.taskTimeBtn.frame = CGRectMake(self.taskInstructionsTextView.axcTool_x,
                                            self.taskInstructionsTextView.axcTool_y + self.taskInstructionsTextView.axcTool_height + 10,
                                            self.taskInstructionsTextView.axcTool_width, 40);
    }];
}
- (void)textViewDidChange:(UITextView *)textView{
    [self layoutDateBtnFrame:YES];
}

#pragma mark - 触发事件
- (void)click_selectDate{
    WeakSelf
    NSDate *btnDate = (NSDate *)self.taskTimeBtn.saveValueObj;
    [self AxcBase_showDate:btnDate selectCompleteBlock:^(NSDate * _Nonnull date) {
        weakSelf.taskTimeBtn.saveValueObj =
        weakSelf.selectDate = date;
        [weakSelf.taskTimeBtn setTitle:[date AxcTool_getDateWithFomant:MonthDayFormat] forState:UIControlStateNormal];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.taskNameTextFiled endEditing:YES];
    [self.taskInstructionsTextView endEditing:YES];
}
// 添加
- (void)click_confirmBtn{
}

#pragma mark - 懒加载
- (NSDate *)selectDate{
    if (!_selectDate) {
        _selectDate = [NSDate date];
    }
    return _selectDate;
}
- (UIButton *)taskTimeBtn{
    if (!_taskTimeBtn) {
        _taskTimeBtn = [UIButton new];
        _taskTimeBtn.backgroundColor = kUncheckColor;
        NSDate *today = [NSDate date];
        _taskTimeBtn.saveValueObj = today;
        [_taskTimeBtn setTitle:[today AxcTool_getDateWithFomant:MonthDayFormat] forState:UIControlStateNormal];
        [_taskTimeBtn setTitleColor:kViceTitleColor forState:UIControlStateNormal];
        [_taskTimeBtn AxcTool_cornerWithRadius:5];
        [_taskTimeBtn addTarget:self action:@selector(click_selectDate) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_taskTimeBtn];
    }
    return _taskTimeBtn;
}
- (RSKGrowingTextView *)taskInstructionsTextView{
    if (!_taskInstructionsTextView) {
        _taskInstructionsTextView = [[RSKGrowingTextView alloc] init];
        _taskInstructionsTextView.placeholder = @"任务描述";
        _taskInstructionsTextView.font = [UIFont systemFontOfSize:12];
        _taskInstructionsTextView.backgroundColor = [UIColor clearColor];
        _taskInstructionsTextView.textColor =
        _taskInstructionsTextView.placeholderColor = kUncheckColor;
        _taskInstructionsTextView.maximumNumberOfLines = 10;
        [_taskInstructionsTextView AxcTool_cornerWithRadius:5];
        [_taskInstructionsTextView AxcTool_borderWithWidth:1 color:kUncheckColor];
        _taskInstructionsTextView.delegate = self;
        [self.view addSubview:_taskInstructionsTextView];
    }
    return _taskInstructionsTextView;
}
- (HoshiTextField *)taskNameTextFiled{
    if (!_taskNameTextFiled) {
        _taskNameTextFiled = [[HoshiTextField alloc] init];
        _taskNameTextFiled.borderInactiveColor = kUncheckColor;
        _taskNameTextFiled.borderActiveColor = kSelectedColor;
        _taskNameTextFiled.placeholderColor = kUncheckColor;
        _taskNameTextFiled.placeholder = @"任务名称";
        _taskNameTextFiled.placeholderFontScale = 0.75;
        _taskNameTextFiled.textColor = kUncheckColor;
        [self.view addSubview:_taskNameTextFiled];
    }
    return _taskNameTextFiled;
}
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
