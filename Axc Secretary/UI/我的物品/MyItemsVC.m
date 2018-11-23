//
//  MyItemsVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/10/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "MyItemsVC.h"
#import <objc/runtime.h>

@interface MyItemsVC ()

@property(nonatomic , strong)UISearchController *searchController;

@end

@implementation MyItemsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.collectionView reloadData];
}

- (void)createUI{
    self.navigationItem.searchController = self.searchController; // 搜索栏
    self.navigationController.navigationBar.prefersLargeTitles = YES; // 滑动大标题
    self.navigationController.navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName: kUncheckColor};
    self.axcNavBarTextColor = kUncheckColor;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(50, 50);
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
    return 50;
    return self.dataListArray.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - 懒加载
- (UISearchController *)searchController{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:[UIViewController new]];
        _searchController.searchBar.placeholder = @"搜索你有的物品";
        _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchController.searchBar.axcSearchTextField.font = [UIFont systemFontOfSize:12];

    }
    return _searchController;
}

@end
