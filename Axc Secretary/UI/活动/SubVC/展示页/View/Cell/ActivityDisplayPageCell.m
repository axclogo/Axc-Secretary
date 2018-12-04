//
//  ActivityDisplayPageCell.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/12/3.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "ActivityDisplayPageCell.h"

@interface ActivityDisplayPageCell ()

@end

@implementation ActivityDisplayPageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self layoutStartPoint];
    [self layoutLine];
    [self layoutEndPoint];
    // 默认都是实线
    self.centerTimeLayer_top.lineDashPattern = nil;
    self.centerTimeLayer_bottom.lineDashPattern = nil;
    // 设置上半部分
    NSDate *today = [NSDate date];
    if (today.day < self.model.date.day ) { // 未来的天
        self.centerTimeLayer_bottom.lineDashPattern = @[@(2),@(1)];
        self.centerTimeLayer_top.lineDashPattern = @[@(2),@(1)];
    }
    NSLog(@"%@",self.model.date);
}

#define pointRadius 2
#define margin 2
#define centerX  ((self.isHorizontal ? kScreenHeight : kScreenWidth)/2)
#define startPoint CGPointMake(centerX, margin)
#define centerPoint CGPointMake(centerX, self.axcTool_height/2)
#define endPoint   CGPointMake(centerX, self.axcTool_height - margin)

- (void)layoutStartPoint{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:startPoint
                                                        radius:pointRadius
                                                    startAngle:0
                                                      endAngle:2*M_PI
                                                     clockwise:YES];
    self.startPointLayer.path = path.CGPath;
}
- (void)layoutEndPoint{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:endPoint
                                                        radius:pointRadius
                                                    startAngle:0
                                                      endAngle:2*M_PI
                                                     clockwise:YES];
    self.endPointLayer.path = path.CGPath;
}

- (void)layoutLine{
    UIBezierPath *path_top = [AxcDrawPath AxcDrawLineArray:
                              @[[NSValue valueWithCGPoint:CGPointMake(startPoint.x, 0)],
                                [NSValue valueWithCGPoint:centerPoint]]];
    self.centerTimeLayer_top.path = path_top.CGPath;
    UIBezierPath *path_bottom = [AxcDrawPath AxcDrawLineArray:
                                 @[[NSValue valueWithCGPoint:centerPoint],
                                   [NSValue valueWithCGPoint:CGPointMake(endPoint.x, self.axcTool_height)]]];
    self.centerTimeLayer_bottom.path = path_bottom.CGPath;
}

- (BOOL)isHorizontal{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    return (orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight);
}
#pragma mark - 懒加载
- (void)settingLayer:(CAShapeLayer *)layer{
    layer.fillColor =
    layer.strokeColor = kSelectedColor.CGColor;
    layer.lineWidth = 1;
}
- (CAShapeLayer *)centerTimeLayer_bottom{
    if (!_centerTimeLayer_bottom) {
        _centerTimeLayer_bottom = [CAShapeLayer new];
        [self settingLayer:_centerTimeLayer_bottom];
        [self.layer addSublayer:_centerTimeLayer_bottom];
    }
    return _centerTimeLayer_bottom;
}
- (CAShapeLayer *)centerTimeLayer_top{
    if (!_centerTimeLayer_top) {
        _centerTimeLayer_top = [CAShapeLayer new];
        [self settingLayer:_centerTimeLayer_top];
        [self.layer addSublayer:_centerTimeLayer_top];
    }
    return _centerTimeLayer_top;
}
- (CAShapeLayer *)endPointLayer{
    if (!_endPointLayer) {
        _endPointLayer = [CAShapeLayer new];
        [self settingLayer:_endPointLayer];
        [self.layer addSublayer:_endPointLayer];
    }
    return _endPointLayer;
}
- (CAShapeLayer *)startPointLayer{
    if (!_startPointLayer) {
        _startPointLayer = [CAShapeLayer new];
        [self settingLayer:_startPointLayer];
        [self.layer addSublayer:_startPointLayer];
    }
    return _startPointLayer;
}

@end
