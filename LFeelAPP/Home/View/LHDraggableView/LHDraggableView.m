//
//  LHDraggableView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/27.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHDraggableView.h"

@implementation LHDraggableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupCardView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCardView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupCardView];
    }
    return self;
}

- (void)setupCardView {
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.layer.borderWidth = 0.4f;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    self.layer.cornerRadius = 7.0;
}






@end
