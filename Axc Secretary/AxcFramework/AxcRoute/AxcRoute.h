//
//  AxcRoute.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/12/4.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>

// 路由Key定义
extern const struct JLRouteParameters {
    /** 路由模式 */
    __unsafe_unretained NSString *RoutePattern;
    /** 路由操作 */
    __unsafe_unretained NSString *RouteScheme;
    /** 路由连接 */
    __unsafe_unretained NSString *RouteURL;
    /** 控制器 */
    __unsafe_unretained NSString *controller;
    /** 动画 */
    __unsafe_unretained NSString *animated;
    /** 选中 */
    __unsafe_unretained NSString *selectIndex;
    
    __unsafe_unretained NSString *seleteTabbarIndex;
    __unsafe_unretained NSString *pushController;
    __unsafe_unretained NSString *presentController;
    
} JLRP;

NS_ASSUME_NONNULL_BEGIN


@interface AxcRoute : NSObject

+ (void)openUrlStr:(NSString *)urlStr;
+ (void)openUrlStr:(NSString *)urlStr options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *)options;
+ (void)openUrlStr:(NSString *)urlStr options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *)options completionHandler:(void (^ __nullable)(BOOL success))completion;

+ (void)pushVCName:(NSString *)vcName;
+ (void)pushVCName:(NSString *)vcName selectIndex:(NSInteger )selectIndex;

+ (void)seleteTabBarIndex:(NSInteger )index;

@end

NS_ASSUME_NONNULL_END
