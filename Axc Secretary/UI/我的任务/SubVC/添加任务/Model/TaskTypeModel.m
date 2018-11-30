//
//  TaskTypeModel.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "TaskTypeModel.h"

@implementation TaskTypeModel

+ (TaskTypeModel *)title:(NSString *)title vcName:(NSString *)vcName{
    TaskTypeModel *model = [TaskTypeModel new];
    model.title = title;
    Class class = NSClassFromString(vcName);
    AxcBaseAppVC *vc = [[class alloc] init];
    model.vc = vc;
    return model;
}


@end
