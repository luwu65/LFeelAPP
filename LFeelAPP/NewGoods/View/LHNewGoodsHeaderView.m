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




@end



@implementation LHNewGoodsCategoryHeaderView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.categoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width-10, frame.size.height-25)];
        self.categoryImageView.backgroundColor = [UIColor redColor];
        [self addSubview:self.categoryImageView];
        
        
        self.categoryNameLabel = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width-20)/3+10, frame.size.height-25+5, (frame.size.width-20)/3, 15)];
        self.categoryNameLabel.textAlignment = NSTextAlignmentCenter;
        self.categoryNameLabel.font = kFont(12*kRatio);
        [self addSubview:self.categoryNameLabel];
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(5, self.categoryNameLabel.centerY, (frame.size.width-20)/3, 0.5)];
        leftView.backgroundColor = [UIColor blackColor];
        [self addSubview:leftView];
        
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width-20)/3*2+15, self.categoryNameLabel.centerY, (frame.size.width-20)/3, 0.5)];
        rightView.backgroundColor = [UIColor blackColor];
        [self addSubview:rightView];
        
    }
    return self;
}

- (void)setModel:(LHCategoryListModel *)model {
    if (model.url) {
        [self.categoryImageView sd_setImageWithURL:kURL(model.url) placeholderImage:kImage(@"")];
    } else {
        self.categoryImageView.image = kImage(@"");
    }
    if (model.category_name) {
        self.categoryNameLabel.text = [NSString stringWithFormat:@"%@", model.category_name];
    }
}

@end





















