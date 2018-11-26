//
//  SwitchThemeVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/26.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "SwitchThemeVC.h"

@interface SwitchThemeVC ()

@end

@implementation SwitchThemeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)createUI{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(100, 150);
    layout.sectionInset=  UIEdgeInsetsMake(10, 10, 10, 10);
    [self AxcBase_settingCollectionLayout:layout nibName:@"" cellID:@""];
    self.collectionView.alwaysBounceVertical = YES;  // 允许不占满垂直滑动
    UIView *plas = [[UIView alloc] initWithFrame:self.view.bounds];
    plas.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.axcPlaceHolderView = plas;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [AxcThemeManager shareManager].theme = indexPath.row + 1;
}

@end
