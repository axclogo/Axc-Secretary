//
//  AxcTemporarilyDataView.m
//  xiezhi-iOS
//
//  Created by Axc on 2017/12/21.
//  Copyright © 2017年 Axc. All rights reserved.
//

#import "AxcTemporarilyDataView.h"

@implementation AxcTemporarilyDataView


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super initWithCoder:aDecoder]) {
        self.axcTool_size = [UIScreen mainScreen].bounds.size;
        self.axcTool_width = kScreenWidth;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
  
}

@end
