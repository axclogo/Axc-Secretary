//
//  AxcThemeStruct.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/12/7.
//  Copyright © 2018 AxcLogo. All rights reserved.
//


struct BaseVCTheme {
    UIColor *backgroundColor;
};
typedef struct CG_BOXABLE BaseVCTheme BaseVCTheme;

struct FirstTabTheme {
    UIColor *TVSectionBackgroundColor;
    UIColor *TVSectionThisMonthBackgroundColor;
    UIColor *TVSectionTitleColor;
    
    UIColor *TVEmptyViewBackgroundColor;
    UIColor *TVEmptyImageTintColor;
    UIColor *TVEmptyTitleColor;
    
    UIColor *CellLeftBackGroundViewColor;
    UIColor *CellDayLabelTextColor;
    UIColor *CellDayLabelSelectBackgroundTextColor;
    UIColor *CellDayLabelSelectTodayBackgroundTextColor;
    UIColor *CellWeekLabelTextColor;
    UIColor *CellWeekLabelSelectBackgroundColor;
    UIColor *CellTimeLabelTextColor;
    UIColor *CellTransactionLabelTextColor;
    
    UIColor *CellTitleLabelTextColor;
    UIColor *CellIntroductionLabelTextColor;
    UIColor *CellExecutionTimeLabelTextColor;
    UIColor *CellAddDateLabelTextColor;
    UIColor *CellUnfoldBtnColor;

};
typedef struct CG_BOXABLE BaseVCTheme FirstTabTheme;

struct SecondTabTheme {
    UIColor *NavColor;
};
typedef struct CG_BOXABLE BaseVCTheme SecondTabTheme;

struct ThirdTabTheme {
    UIColor *NavColor;
};
typedef struct CG_BOXABLE BaseVCTheme ThirdTabTheme;

struct FourthTabTheme {
    UIColor *NavColor;
};
typedef struct CG_BOXABLE BaseVCTheme FourthTabTheme;

struct FifthTabTheme {
    UIColor *NavColor;
};
typedef struct CG_BOXABLE BaseVCTheme FifthTabTheme;

struct NavTabTheme {
    UIColor *navColor;                      // 导航条颜色
    UIColor *navTitleTintColor;             // 导航条标题以及按钮颜色
    
    UIColor *tabColor;                      // tab栏颜色
    UIColor *tabSelectTintColor;            // tab选中颜色
    UIColor *tabSelectBackgroundColor;      // tab选中背景颜色
};
typedef struct CG_BOXABLE NavTabTheme NavTabTheme;


struct AxcThemeStruct {
    FirstTabTheme   firstTabTheme;
    SecondTabTheme  secondTabTheme;
    ThirdTabTheme   thirdTabTheme;
    FourthTabTheme  fourthTabTheme;
    FifthTabTheme   fifthTabTheme;
    NavTabTheme     tabTheme;
};
typedef struct CG_BOXABLE AxcThemeStruct AxcThemeStruct;
