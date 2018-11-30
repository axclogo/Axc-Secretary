//
//  TaskTypeModel.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AxcBaseModel.h"
#import "AxcBaseAppVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskTypeModel : AxcBaseModel

+ (TaskTypeModel *)title:(NSString *)title vcName:(NSString *)vcName;
// 标题
@property(nonatomic , strong)NSString *title;
// VC
@property(nonatomic , strong)AxcBaseAppVC *vc;

@end

NS_ASSUME_NONNULL_END
