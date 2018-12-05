//
//  SettingModel.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/23.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "SettingModel.h"

@implementation SettingModel
- (instancetype)init{
    self = [super init];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}
+ (SettingModel *)title:(NSString *)title disTitle:(NSString *)disTitle{
    SettingModel *model = [SettingModel new];
    model.title = title;
    model.disTitle = disTitle;
    return model;
}
+ (SettingModel *)title:(NSString *)title disTitle:(NSString *)disTitle settingKey:(NSString *)settingKey{
    SettingModel *model = [SettingModel title:title disTitle:disTitle];
    model.settingKey = settingKey;
    return model;
}
+ (SettingModel *)title:(NSString *)title settingKey:(NSString *)settingKey{
    return [SettingModel title:title disTitle:@"" settingKey:settingKey];
}
- (void)trigger{
    WeakSelf;
    __block id obj_ = nil;
    switch (self.settingType) {
        case SettingTypeSwitch:{    // 开关类型的直接取反
            [self getValueForKey:^id(id obj) {
                obj_ = obj;
                return @(![obj integerValue]);
            }];
        } break;
        case SettingTypeDisTitleIQDropDownTextField:{
            [self getValueForKey:^id(id obj) {
                return @(weakSelf.selectRow);
            }];
        } break;
            
        default:
            break;
    }
    if (self.tiggerBlock) {
        self.tiggerBlock(obj_);
    }
}

- (void )getValueForKey:(id (^)(id obj))block{
    NSMutableDictionary *settingKeys = [NSMutableDictionary dictionaryWithDictionary:[self.userDefaults objectForKey:kSettingKeys]];
    id obj = [settingKeys objectForKey:self.settingKey];
    id save_obj = block(obj);
    [settingKeys setObject:save_obj forKey:self.settingKey];
    [self.userDefaults setObject:settingKeys forKey:kSettingKeys];
}
- (BOOL)switch_on{
    [self getValueForKey:^id(id obj) {
        self->_switch_on = [obj integerValue];
        return @([obj integerValue]);
    }];
    return _switch_on;
}


@end

@implementation SettingGroupModel
+ (SettingGroupModel *)title:(NSString *)title subModels:(NSArray <SettingModel *>*)subModels{
    SettingGroupModel *model = [SettingGroupModel new];
    model.title = title;
    model.subModels = subModels;
    return model;
}
@end

