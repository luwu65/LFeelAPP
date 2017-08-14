//
//  LHDevider.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/14.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHDevider.h"

@implementation LHDevider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
    [super awakeFromNib];
}

- (void)setup {
    self.deviderColor = kColor(222, 223, 224);
    self.deviderHeigth = 0.5;
    self.backgroundColor = [UIColor clearColor];
    self.alpha = 1.0f;
}

- (void)setDeviderColor:(UIColor *)deviderColor {
    _deviderColor = deviderColor;
    [self setNeedsDisplay];
}

- (void)setDeviderHeigth:(CGFloat)deviderHeigth {
    if (deviderHeigth > 1) {
        deviderHeigth = 1;
    }
    _deviderHeigth = deviderHeigth;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (rect.size.height < 2.0 && rect.size.width > 1.0) {
        CGFloat h = self.deviderHeigth;
        CALayer * layer = [CALayer layer];
        layer.frame = CGRectMake(0, 1 - h, rect.size.width, h);
        layer.backgroundColor = self.deviderColor.CGColor;
        [self.layer addSublayer:layer];
    } else {
        CGFloat w = 0.5;
        CALayer * layer = [CALayer layer];
        layer.frame = CGRectMake(1 - w , 0, w, rect.size.height);
        layer.backgroundColor = self.deviderColor.CGColor;
        [self.layer addSublayer:layer];
    }
}

@end
