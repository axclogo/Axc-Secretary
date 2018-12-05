//
//  BaseTabbarVC.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/10/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AxcAE_TabBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTabbarVC : UITabBarController

@property(nonatomic , strong)AxcAE_TabBar *axcTabBar;

@end

NS_ASSUME_NONNULL_END
