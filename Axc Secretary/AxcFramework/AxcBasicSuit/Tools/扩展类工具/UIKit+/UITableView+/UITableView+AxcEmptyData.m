//
//  UITableView+AxcEmptyData.m
//  AxcUIKit
//
//  Created by Axc on 2017/7/11.
//  Copyright © 2017年 Axc_5324. All rights reserved.
//

#import "UITableView+AxcEmptyData.h"
#import <objc/runtime.h>



static NSString * const kplaceHolderViewAnimations = @"axcPlaceHolderViewAnimations";


@implementation UITableView (AxcEmptyData)

-(void)setAxcPlaceHolderViewAnimations:(BOOL)axcUI_placeHolderViewAnimations{
    [self willChangeValueForKey:kplaceHolderViewAnimations];
    objc_setAssociatedObject(self, &kplaceHolderViewAnimations,
                             @(axcUI_placeHolderViewAnimations),
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:kplaceHolderViewAnimations];
}
- (BOOL)axcPlaceHolderViewAnimations{
    if (!objc_getAssociatedObject(self, &kplaceHolderViewAnimations)) {
        return YES;
    }else{
        BOOL bol = [objc_getAssociatedObject(self, &kplaceHolderViewAnimations) boolValue];
        return bol;
    }
}

-(void)setAxcPlaceHolderView:(UIView *)axcUI_placeHolderView{
    objc_setAssociatedObject(self, @selector(axcPlaceHolderView),axcUI_placeHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (objc_getAssociatedObject(self, @selector(axcPlaceHolderView))) {
        //防止手动调用load出现多次调用的情况：
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [UITableView swizzleOriginMethod:@selector(reloadData)
                                      Method:@selector(customReloadData)];
        });
    }
}

-(UIView *)axcPlaceHolderView{
    UIView *view = objc_getAssociatedObject(self, @selector(axcPlaceHolderView));
    return view;
}


#pragma mark 自定义刷新方法：
// 实现改为只对继承TableView的对象有用，并不会对系统原有的TableView造成影响
-(void)customReloadData{
    [self checkIsEmpty];
    [self customReloadData];
}
//替换方法：
+ (void)swizzleOriginMethod:(SEL)oriSel Method:(SEL)newSel{
    Method oriMethod = class_getInstanceMethod(self, oriSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    BOOL methodIsAdd = class_addMethod(self, oriSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (methodIsAdd) {
        class_replaceMethod(self, newSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    }else{
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

- (void)checkIsEmpty{
    BOOL isEmpty = YES;
    id<UITableViewDataSource> src = self.dataSource;
    if ([src respondsToSelector:@selector(numberOfSectionsInTableView:)]) {//group
        NSInteger sections = [src numberOfSectionsInTableView:self];
        if (sections > 1) {
            isEmpty = NO;
        }else if (sections == 1){
            NSInteger rows = [src tableView:self numberOfRowsInSection:0];//plain
            if (rows > 0) {
                isEmpty = NO;
            }
        }
    }else{
        NSInteger rows = [src tableView:self numberOfRowsInSection:0];//plain
        if (rows > 0) {
            isEmpty = NO;
        }
    }
    
    
    if (isEmpty) {
        [self.axcPlaceHolderView removeFromSuperview];
        
        self.axcPlaceHolderView.axcTool_y = self.tableHeaderView.axcTool_height;
        [self addSubview:self.axcPlaceHolderView];
        if (self.axcPlaceHolderViewAnimations) {
            WeakSelf;
            self.axcPlaceHolderView.alpha = 0;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 weakSelf.axcPlaceHolderView.alpha = 1;
                             }];
        }
    }else{
        if (self.axcPlaceHolderViewAnimations) {
            WeakSelf;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 weakSelf.axcPlaceHolderView.alpha = 0;
                             } completion:^(BOOL finished) {
                                 [weakSelf.axcPlaceHolderView removeFromSuperview];
                             }];
        }else{
            [self.axcPlaceHolderView removeFromSuperview];
        }
    }
}



@end
