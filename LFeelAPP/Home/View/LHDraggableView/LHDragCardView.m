//
//  LHDragCardView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/27.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHDragCardView.h"

@implementation LHDragCardView

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
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _goodsImageView = [[UIImageView alloc]init];
    _goodsImageView.backgroundColor = kRandomColor;
    _goodsImageView.layer.masksToBounds = YES;
    _goodsImageView.layer.cornerRadius = 5;
    _goodsImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:_goodsImageView];
    
    _unlikeImageView = [[UIImageView alloc] initWithImage:kImage(@"Home_ChooseGoods_unLike")];
    _unlikeImageView.frame = CGRectMake(15, 10, kFit(50), kFit(50));
    _unlikeImageView.layer.masksToBounds = YES;
    _unlikeImageView.layer.cornerRadius = kFit(50/2);
    _unlikeImageView.backgroundColor = [UIColor whiteColor];
    _unlikeImageView.alpha = 0;
    [_goodsImageView addSubview:_unlikeImageView];
    
    _likeImageView = [[UIImageView alloc] initWithImage:kImage(@"Home_ChooseGoods_Like")];
    _likeImageView.frame = CGRectMake(self.frame.size.width-15-kFit(50), 10, kFit(50), kFit(50));
    _likeImageView.backgroundColor = [UIColor whiteColor];
    _likeImageView.layer.masksToBounds = YES;
    _likeImageView.layer.cornerRadius = kFit(50/2);
    _likeImageView.alpha = 0;
    [_goodsImageView addSubview:_likeImageView];
    
}

- (void)setGoodsModel:(LHThemeGoodsModel *)goodsModel {
    if (![goodsModel.product_url isKindOfClass:[NSNull class]]) {
        [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.product_url] placeholderImage:kImage(@"")];
    } else {
        self.goodsImageView.image = kImage(@"");
    }
}


@end
