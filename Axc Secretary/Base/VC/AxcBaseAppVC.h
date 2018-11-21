//
//  AxcBaseAppVC.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/10/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AxcBaseVC.h"
#import "AxcDBManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface AxcBaseAppVC : AxcBaseVC

@property(nonatomic , strong)AxcDBManager *db;

@end

NS_ASSUME_NONNULL_END
