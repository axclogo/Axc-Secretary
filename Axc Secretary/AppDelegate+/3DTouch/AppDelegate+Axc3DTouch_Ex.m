//
//  AppDelegate+Axc3DTouch_Ex.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/26.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AppDelegate+Axc3DTouch_Ex.h"

@implementation AppDelegate (Axc3DTouch_Ex)

- (void)setting3DTouch{
    if(self.window.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable){
        [self settingItem];
    }else{
        LLog(@"设备不支持3DTouch！");
    }
}
- (void)settingItem{
    // 自定义图标
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"add_white"];
    
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"pic2"];
    
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"pic3"];
    
    UIApplicationShortcutIcon *icon4 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"pic4"];
    
    
    UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"0"
                                                                                     localizedTitle:@"添加新事项"
                                                                                  localizedSubtitle:@"快速打开添加功能"
                                                                                               icon:icon1
                                                                                           userInfo:nil];
    
    UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"1"
                                                                                     localizedTitle:@"进入pic4"
                                                                                  localizedSubtitle:@"自定义图标pic4"
                                                                                               icon:icon2
                                                                                           userInfo:nil];
    
    UIMutableApplicationShortcutItem *item3 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"2"
                                                                                     localizedTitle:@"进入pic4"
                                                                                  localizedSubtitle:@"自定义图标pic4"
                                                                                               icon:icon3
                                                                                           userInfo:nil];
    
    UIMutableApplicationShortcutItem *item4 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"3"
                                                                                     localizedTitle:@"进入pic4"
                                                                                  localizedSubtitle:@"自定义图标pic4"
                                                                                               icon:icon4
                                                                                           userInfo:nil];
    
    [[UIApplication sharedApplication] setShortcutItems:@[item1,item2,item3,item4]];

}
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    // 1.获得shortcutItem的type type就是初始化shortcutItem的时候传入的唯一标识符
    NSString *type = shortcutItem.type;
    // 自下向上
    //2.可以通过type来判断点击的是哪一个快捷按钮 并进行每个按钮相应的点击事件
    if ([type isEqualToString:@"pic1"]) {
        // do something
    }else if ([type isEqualToString:@"pic2"]){
        // do something
    }else if ([type isEqualToString:@"pic3"]){
        // do something
    }else if ([type isEqualToString:@"pic4"]){
        // do something
    }
}



@end
