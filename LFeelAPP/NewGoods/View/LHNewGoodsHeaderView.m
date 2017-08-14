//
//  LHNewGoodsHeaderView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHNewGoodsHeaderView.h"

@implementation LHNewGoodsHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width-40, frame.size.height)];
        rightLabel.text = @"查看更多";
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.textColor = [UIColor redColor];
        rightLabel.font = kFont(14);
        rightLabel.userInteractionEnabled = YES;
        [self addSubview:rightLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightLabelAction)];
        [rightLabel addGestureRecognizer:tap];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 20, (frame.size.height-16)/2, 10, 16)];
        imageView.image = [UIImage imageNamed:@"NewGoods_More"];
        [self addSubview:imageView];
        
        
    }
    return self;
}

- (void)handleRightLabelAction {
    if (self.clickLabelBlock) {
        self.clickLabelBlock();
    }
}

- (void)clickRightLabelBlock:(ClickRightLabelBlock)block {
    self.clickLabelBlock = block;
}


- (instancetype)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl title:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, frame.size.width-20, (frame.size.width-20)/3)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
        [self addSubview:imageView];
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(10, frame.size.height/3*2+15/2+10, (frame.size.width-20)/3, 1)];
        leftView.backgroundColor = [UIColor blackColor];
        [self addSubview:leftView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width-20)/3+10, frame.size.height/3*2+10, (frame.size.width-20)/3, 15)];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = kFont(12*kRatio);
        [self addSubview:titleLabel];
        
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width-20)/3*2+10, frame.size.height/3*2+15/2+10, (frame.size.width-20)/3, 1)];
        rightView.backgroundColor = [UIColor blackColor];
        [self addSubview:rightView];
        
    }
    return self;
}


























@end
