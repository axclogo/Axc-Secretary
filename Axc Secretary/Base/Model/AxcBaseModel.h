//
//  AxcBaseModel.h
//  xiezhi-iOS
//
//  Created by Axc on 2017/11/28.
//  Copyright © 2017年 Axc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+WHC_Model.h"

@interface AxcBaseModel : NSObject



// 实例函数
- (instancetype)initWithDictionary:(NSDictionary *)dict;

// 数据函数
+ (instancetype)provinceWithDictionary:(NSDictionary *)dict;


@property(nonatomic, strong)NSString *_id;
@property(nonatomic, strong)NSString *_description;
@property(nonatomic , strong)NSString *_default;
// 预留cell高度参
@property(nonatomic, assign)CGFloat cellHeight;
// 预留数据修改记录参
@property(nonatomic, strong)id value;


@end
