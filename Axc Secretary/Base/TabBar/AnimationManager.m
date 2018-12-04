//
//  AnimationManager.m
//  demo
//
//  Created by 啾 on 2017/3/10.
//  Copyright © 2017年 qweewq. All rights reserved.
//

#import "AnimationManager.h"

#import "AxcNavVC.h"

@interface AnimationManager ()
@end

@implementation AnimationManager


- (instancetype)initWithType:(KAnimationType)type {
    
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // 获取fromVc和toVc
    AxcNavVC *fromVc = (AxcNavVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    AxcNavVC *toVc = (AxcNavVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromV = fromVc.view;
    UIView *toV = toVc.view;
    // 转场环境
    UIView *containView = [transitionContext containerView];
    containView.backgroundColor = kMainBackColor;
    
    fromV.alpha = 1;
    toV.alpha = 0;
    
    [containView addSubview:toV];
    [UIView animateWithDuration:0.3 animations:^{
        fromV.alpha = 0;
        toV.alpha = 1;
    } completion:^(BOOL finished) {
        [fromV removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}
@end
