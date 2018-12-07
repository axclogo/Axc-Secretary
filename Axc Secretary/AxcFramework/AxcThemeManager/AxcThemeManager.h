//
//  AxcThemeManager.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/26.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AxcThemeStruct.h"

typedef NS_ENUM(NSInteger, AxcTheme) {
    AxcThemeNone,           // 无
    AxcThemeLight,          // 亮色
    AxcThemeDark,           // 黑色
    AxcThemeHehe,           // 贺贺色
};

NS_ASSUME_NONNULL_BEGIN

@interface AxcThemeManager : NSObject

+ (AxcThemeManager *)shareManager;

@property(nonatomic , assign)AxcTheme theme;

@property(nonatomic , assign)AxcThemeStruct themeStruct;


#pragma mark - 主题获取口

/**
 导航色
 */
@property(nonatomic , strong)UIColor *navColor;

/**
 深导航色
 */
@property(nonatomic , strong)UIColor *navDarkColor;

/**
 主背景色
 */
@property(nonatomic , strong)UIColor *mainBackColor;

/**
 未选中色
 */
@property(nonatomic , strong)UIColor *uncheckColor;

/**
 选中色
 */
@property(nonatomic , strong)UIColor *selectedColor;

/**
 警告色
 */
@property(nonatomic , strong)UIColor *warningColor;

/**
 主标题色
 */
@property(nonatomic , strong)UIColor *mainTitleColor;

/**
 副标题色
 */
@property(nonatomic , strong)UIColor *viceTitleColor;

/**
 标注色
 */
@property(nonatomic , strong)UIColor *markColor;

/**
 副色
 */
@property(nonatomic , strong)UIColor *viceColor;


@end

NS_ASSUME_NONNULL_END
