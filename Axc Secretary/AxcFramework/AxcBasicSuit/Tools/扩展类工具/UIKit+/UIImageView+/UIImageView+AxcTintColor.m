//
//  UIImageView+AxcTintColor.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/12/6.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "UIImageView+AxcTintColor.h"

#import <objc/runtime.h>

static NSString * const kaxcTintColor = @"kaxcTintColor";

@implementation UIImageView (AxcTintColor)

//////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setAxcTintColor:(UIColor *)axcTintColor{
    [self willChangeValueForKey:kaxcTintColor];
    objc_setAssociatedObject(self, &kaxcTintColor,
                             axcTintColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kaxcTintColor];
    self.image = [self.image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
    [self setTintColor:axcTintColor];
}
- (UIColor *)axcTintColor{
    return objc_getAssociatedObject(self, &kaxcTintColor);
}
@end
