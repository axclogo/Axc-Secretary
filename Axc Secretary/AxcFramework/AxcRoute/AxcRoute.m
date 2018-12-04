//
//  AxcRoute.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/12/4.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AxcRoute.h"

const struct JLRouteParameters JLRP = {
    .RoutePattern       = @"JLRoutePattern",
    .RouteScheme        = @"JLRouteScheme",
    .RouteURL           = @"JLRouteURL",
    .controller         = @"controller",
    .animated           = @"animation",
    .selectIndex        = @"selectIndex",
    
    .seleteTabbarIndex  = @"/seleteTabbarIndex",
    .pushController     = @"/push/:controller",
    .presentController  = @"/present/:controller"
};

@implementation AxcRoute

+ (void)openUrlStr:(NSString *)urlStr{
    [self openUrlStr:urlStr options:@{}];
//    [self openUrlStr:urlStr options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @YES}];
}

+ (void)openUrlStr:(NSString *)urlStr options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *)options{
    [self openUrlStr:urlStr options:options completionHandler:nil];
}
+ (void)openUrlStr:(NSString *)urlStr options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *)options completionHandler:(void (^ __nullable)(BOOL success))completion{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]
                                       options:options
                             completionHandler:completion];
}

+ (void)pushVCName:(NSString *)vcName{
    NSString *url = [NSString stringWithFormat:@"%@://push/%@",kRouteScheme,vcName];
    [self openUrlStr:url];
}
+ (void)pushVCName:(NSString *)vcName selectIndex:(NSInteger )selectIndex{
    NSString *url = [NSString stringWithFormat:@"%@://push/%@?%@=%ld",kRouteScheme,vcName,JLRP.selectIndex,selectIndex];
    [self openUrlStr:url];
}

+ (void)seleteTabBarIndex:(NSInteger )index{
    NSString *url = [NSString stringWithFormat:@"%@://seleteTabbarIndex?%@=%ld",kRouteScheme,JLRP.selectIndex,index];
    [self openUrlStr:url];
}


@end

