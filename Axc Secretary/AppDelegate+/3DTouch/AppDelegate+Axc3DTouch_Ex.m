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
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@""];
    
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"pic2"];
    
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"tabbar_activity"];
    
    UIApplicationShortcutIcon *icon4 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"add_white"];
    
    
    UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"0"
                                                                                     localizedTitle:@"更换图标"
                                                                                  localizedSubtitle:@"选择其他App图标"
                                                                                               icon:icon1
                                                                                           userInfo:nil];
    
    UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"1"
                                                                                     localizedTitle:@"1"
                                                                                  localizedSubtitle:@"1"
                                                                                               icon:icon2
                                                                                           userInfo:nil];
    
    UIMutableApplicationShortcutItem *item3 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"2"
                                                                                     localizedTitle:@"本周活动"
                                                                                  localizedSubtitle:@"本周活动项目列表"
                                                                                               icon:icon3
                                                                                           userInfo:nil];
    
    UIMutableApplicationShortcutItem *item4 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"3"
                                                                                     localizedTitle:@"新任务"
                                                                                  localizedSubtitle:@"快速添加任务"
                                                                                               icon:icon4
                                                                                           userInfo:nil];
    
    [[UIApplication sharedApplication] setShortcutItems:@[item1,item2,item3,item4]];

}
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    // 1.获得shortcutItem的type type就是初始化shortcutItem的时候传入的唯一标识符
    NSInteger type = shortcutItem.type.integerValue;
    switch (type) {
        case 0:{
            [AxcRoute pushVCName:@"SwitchIconVC" selectIndex:4];
        } break;
        case 1:{
            
        } break;
        case 2:{
            [AxcRoute seleteTabBarIndex:1];
        } break;
        case 3:{
            [AxcRoute pushVCName:@"AddTaskVC" selectIndex:0];
        } break;
        default: break;
    }
}



@end
