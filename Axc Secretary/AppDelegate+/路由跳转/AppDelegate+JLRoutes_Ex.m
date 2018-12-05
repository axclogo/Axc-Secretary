//
//  AppDelegate+JLRoutes_Ex.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/12/4.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AppDelegate+JLRoutes_Ex.h"
#import <objc/runtime.h>

#import "JLRoutes.h"
#import "BaseTabbarVC.h"

#define StrIsTrue(str) ([str isEqualToString:@"true"] ||\
[str isEqualToString:@"TRUE"] ||\
[str isEqualToString:@"yes"]  ||\
[str isEqualToString:@"YES"]  ||\
[str isEqualToString:@"1"])

@implementation AppDelegate (JLRoutes_Ex)

- (void)registerRoute{
    
    // AxcRoute://push/ViewController
    // 推出
    [[JLRoutes routesForScheme:kRouteScheme] addRoute:JLRP.pushController handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        Class class = NSClassFromString(parameters[JLRP.controller]);
        UIViewController *nextVC = [[class alloc] init];
        [self paramToVc:nextVC param:parameters];
        // 获取推出动画
        NSString *animationStr = [parameters objectForKey:JLRP.animated];
        BOOL animation = NO;
        if (animationStr.length) {
            animation = StrIsTrue(animationStr);
        }else{  // 默认也是YES
            animation = YES;
        }
        // 获取tabbar
        [self seleteTabBarParameters:parameters];
        // 然后获取VC
        UIViewController *currentVc = [self currentViewController];
        // 选择推出模式
        if ([parameters[JLRP.RoutePattern] isEqualToString:JLRP.pushController]) {
            nextVC.hidesBottomBarWhenPushed = YES;
            [currentVc.navigationController pushViewController:nextVC animated:animation];
        }else if([parameters[JLRP.RoutePattern] isEqualToString:JLRP.presentController]){
            [currentVc presentViewController:nextVC animated:animation completion:nil];
        }
        return YES;
    }];
    // 选择tabbar
    [[JLRoutes routesForScheme:kRouteScheme] addRoute:JLRP.seleteTabbarIndex handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        [self seleteTabBarParameters:parameters];
        return YES;
    }];
}

- (void)seleteTabBarParameters:(NSDictionary *)parameters{
    // 获取tabbar
    NSString *selectStr = [parameters objectForKey:JLRP.selectIndex];
    if (selectStr.length) {
        BaseTabbarVC * vc = (BaseTabbarVC *)self.window.rootViewController;
        vc.axcTabBar.selectIndex = [selectStr integerValue];
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    return [[JLRoutes routesForScheme:kRouteScheme]routeURL:url];
}

//确定是哪个viewcontroller
-(UIViewController *)currentViewController{
    UIViewController * currVC = nil;
    UIViewController * Rootvc = self.window.rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}
//传参数
-(void)paramToVc:(UIViewController *) v param:(NSDictionary<NSString *,NSString *> *)parameters{
    //        runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(v.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) { // 防止空参闪退
            [v setValue:param forKey:key];
        }
    }
}

@end
