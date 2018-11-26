//
//  SettingModel.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/23.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AxcBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SettingType) {
    SettingTypeNone,
    SettingTypeSwitch,
    SettingTypeDisTitle,
};

typedef void (^SettingModelTiggerBlock )(id obj);

@interface SettingModel : AxcBaseModel

+ (SettingModel *)title:(NSString *)title disTitle:(NSString *)disTitle;
+ (SettingModel *)title:(NSString *)title disTitle:(NSString *)disTitle settingKey:(NSString *)settingKey;
+ (SettingModel *)title:(NSString *)title settingKey:(NSString *)settingKey;


@property(nonatomic , strong)NSString *title;
@property(nonatomic , strong)NSString *disTitle;
@property(nonatomic , strong)NSString *settingKey;
// 设置类型
@property(nonatomic , assign)SettingType settingType;
// cell的后缀类型，默认none
@property(nonatomic , assign)UITableViewCellAccessoryType accessoryType;
// 获取Key后开关的状态
@property(nonatomic , assign)BOOL switch_on;
// 进行改变设置
- (void)trigger;
@property(nonatomic , copy)SettingModelTiggerBlock tiggerBlock;
@end

@interface SettingGroupModel : AxcBaseModel

+ (SettingGroupModel *)title:(NSString *)title subModels:(NSArray <SettingModel *>*)subModels;

@property(nonatomic , strong)NSString *title;
@property(nonatomic , strong)NSArray <SettingModel *>*subModels;

@end


NS_ASSUME_NONNULL_END
