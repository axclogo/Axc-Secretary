//
//  ActivityVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/23.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "ActivityVC.h"
#import "ActivityPageFrameworkVC.h"
#import "EditorActivityVC.h"

#import "WMDragView.h"
//#import "NumberMorphView-Swift.h"

@interface ActivityVC ()
// 周分页控制器
@property(nonatomic, strong)ActivityPageFrameworkVC *weekAcitvityVC;
// 编辑拖动气泡
@property(nonatomic , strong)WMDragView *dragView;
// 编辑图片
@property(nonatomic , strong)UIImageView *editorImageView;

@end

@implementation ActivityVC


- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)createUI{
    WeakSelf;
    [self AxcBase_addBarButtonItem:AxcBaseBarButtonItemLocationRight image:@"today" handler:^(UIButton *barItemBtn) {
        [weakSelf.weekAcitvityVC goToday];  // 回到今日
    }];
    [self.weekAcitvityVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    // 设置编辑按钮
    [self.view addSubview:self.dragView];
}
- (void)settingDragBtn{
    
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.weekAcitvityVC.view.backgroundColor =
    self.weekAcitvityVC.scrollView.backgroundColor =
    self.view.backgroundColor;
    [self layoutDragView];
}
- (void)layoutDragView{
    CGFloat freeHeight = self.view.axcTool_height - kMenuHeight;
    CGFloat dragViewSize = 50;
    CGFloat margin = 20;
    self.dragView.frame = CGRectMake(self.view.axcTool_width - (dragViewSize + margin),
                                     freeHeight - (dragViewSize + margin),
                                     dragViewSize, dragViewSize);
    self.dragView.freeRect = CGRectMake(margin, margin + kMenuHeight,
                                        self.view.axcTool_width - 2*margin,
                                        freeHeight - 3*margin);
    [self.dragView AxcTool_cornerWithRadius:dragViewSize/2];
    CGFloat editorImageViewSize = dragViewSize*(3.f/5.f);
    self.editorImageView.axcTool_size = CGSizeMake(editorImageViewSize, editorImageViewSize);
    self.editorImageView.axcTool_y = dragViewSize/2.f - self.editorImageView.axcTool_size.height/2.f;
    self.editorImageView.axcTool_x = dragViewSize/2.f - self.editorImageView.axcTool_size.width/2.f;
    [self.dragView addSubview:self.editorImageView];
    
}

#pragma mark - 懒加载
- (UIImageView *)editorImageView{
    if (!_editorImageView) {
        _editorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"editor"]];
        _editorImageView.image = [_editorImageView.image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
        _editorImageView.tintColor = [UIColor whiteColor];
    }
    return _editorImageView;
}
- (WMDragView *)dragView{
    if (!_dragView) {
        _dragView = [[WMDragView alloc] initWithFrame:CGRectZero];
        _dragView.isKeepBounds = YES;
        _dragView.backgroundColor = kSelectedColor;
        WeakSelf;
        _dragView.clickDragViewBlock = ^(WMDragView *dragView) {
            [weakSelf AxcTool_pushVCName:@"EditorActivityVC"];
        };
    }
    return _dragView;
}
- (ActivityPageFrameworkVC *)weekAcitvityVC{
    if (!_weekAcitvityVC) {
        _weekAcitvityVC = [[ActivityPageFrameworkVC alloc] init];
        
        [self addChildViewController:_weekAcitvityVC];
        [self.view addSubview:_weekAcitvityVC.view];
    }
    return _weekAcitvityVC;
}



@end
