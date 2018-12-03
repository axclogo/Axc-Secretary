//
//  ActivityDisplayPageVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "ActivityDisplayPageVC.h"

@interface ActivityDisplayPageVC ()
// 中线时间轴
@property(nonatomic , strong)CAShapeLayer *centerTimeLayer;
@end

@implementation ActivityDisplayPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)createUI{
    [self AxcBase_settingTableType:UITableViewStylePlain nibName:@"" cellID:@""];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 1;
    }];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.view.alpha = 1;
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0;
    }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGFloat radius = 2;
    CGFloat margin = 10;
    CGFloat x = (self.isHorizontal ? kScreenHeight : kScreenWidth)/2;
    CGPoint startPoint = CGPointMake(x, margin);
    CGPoint endPoint = CGPointMake(x, self.view.axcTool_height - margin);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:startPoint radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path appendPath:[AxcDrawPath AxcDrawLineArray:
                      @[[NSValue valueWithCGPoint:startPoint],
                        [NSValue valueWithCGPoint:endPoint]]]];
    [path appendPath:[UIBezierPath bezierPathWithArcCenter:endPoint radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES]];
    self.centerTimeLayer.path = path.CGPath;
}

#pragma mark - delegate
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 懒加载
- (CAShapeLayer *)centerTimeLayer{
    if (!_centerTimeLayer) {
        _centerTimeLayer = [CAShapeLayer new];
        _centerTimeLayer.fillColor =
        _centerTimeLayer.strokeColor = kSelectedColor.CGColor;
        _centerTimeLayer.lineWidth = 1;
        [self.view.layer addSublayer:_centerTimeLayer];
    }
    return _centerTimeLayer;
}


@end
