//
//  AxcBaseModel.m
//  xiezhi-iOS
//
//  Created by Axc on 2017/11/28.
//  Copyright © 2017年 Axc. All rights reserved.
//

#import "AxcBaseModel.h"

@implementation AxcBaseModel
- (instancetype)init{
    self = [super init];
    if (self) {
        self.value = @"";
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        NSMutableDictionary *dic_M = [NSMutableDictionary dictionaryWithDictionary:dict];
        NSArray *allKeys = [dic_M allKeys];
        for (int i = 0  ;i < allKeys.count ;i ++) {
            NSString *key = allKeys[i];
            id obj = [dict objectForKey:key];
            if ([obj isKindOfClass:[NSNull class]]) {
                obj = @"";
                [dic_M setObject:obj forKey:key];
            }
        }
        dict = [NSDictionary dictionaryWithDictionary:dic_M];
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)provinceWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

// 防止崩溃
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        __id = value;
    }else if([key isEqualToString:@"description"]){
        __description = value;
    }else if([key isEqualToString:@"default"]){
        __default = value;
    }
}

/// 模型类可自定义属性名称
+ (NSDictionary <NSString *, NSString *> *)whc_ModelReplacePropertyMapper {
    return @{@"id": @"_id",
             @"description": @"_description",
             @"default":@"_default"
             };
}


@end
