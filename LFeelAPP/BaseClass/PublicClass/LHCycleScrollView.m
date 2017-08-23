//
//  LHCycleScrollView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHCycleScrollView.h"

//首页轮播
@implementation LHHomeCycleView

- (instancetype)initWithFrame:(CGRect)frame imageFrame:(CGRect)imageFrame placeholderImage:(NSString *)placeholderImage buttonTitle:(NSArray *)buttonTitleArray buttonImage:(NSArray *)buttonImageArray {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.cycleView = [[SDCycleScrollView alloc] initWithFrame:imageFrame];
        self.cycleView.delegate = self;
        self.cycleView.placeholderImage = [UIImage imageNamed:placeholderImage];
        [self addSubview:self.cycleView];
        
        //专业搭配师
        self.professMatchBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self addSubview:self.professMatchBtn];
        [self.professMatchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.cycleView.mas_bottom).with.offset(0);
            make.left.mas_equalTo(self).with.offset(0);
            make.width.mas_equalTo(kScreenWidth/3);
            make.height.mas_equalTo(35*kRatio);
        }];
        [self.professMatchBtn setTitle:buttonTitleArray[0] forState:(UIControlStateNormal)];
        [self.professMatchBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [self.professMatchBtn setImage:[UIImage imageNamed:buttonImageArray[0]] forState:(UIControlStateNormal)];
        //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
        self.professMatchBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 70*kRatio);
        //button标题的偏移量，这个偏移量是相对于图片的
        self.professMatchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.professMatchBtn.titleLabel.font = kFont(12*kRatio);
        
        
        //不限次穿数
        self.exchangeWearBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self addSubview:self.exchangeWearBtn];
        [self.exchangeWearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.cycleView.mas_bottom).with.offset(0);
            make.left.mas_equalTo(self.professMatchBtn.mas_right).with.offset(0);
            make.width.mas_equalTo(kScreenWidth/3);
            make.height.mas_equalTo(35*kRatio);
        }];
        [self.exchangeWearBtn setTitle:buttonTitleArray[1] forState:(UIControlStateNormal)];
        [self.exchangeWearBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [self.exchangeWearBtn setImage:[UIImage imageNamed:buttonImageArray[1]] forState:(UIControlStateNormal)];
        //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
        self.exchangeWearBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 70*kRatio);
        //button标题的偏移量，这个偏移量是相对于图片的
        self.exchangeWearBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.exchangeWearBtn.titleLabel.font = kFont(12*kRatio);
        
        //五星级清洗
        self.cleanBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self addSubview:self.cleanBtn];
        [self.cleanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.cycleView.mas_bottom).with.offset(0);
            make.left.equalTo(self.exchangeWearBtn.mas_right);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(self.professMatchBtn);
        }];
        [self.cleanBtn setTitle:buttonTitleArray[2] forState:(UIControlStateNormal)];
        [self.cleanBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [self.cleanBtn setImage:[UIImage imageNamed:buttonImageArray[2]] forState:(UIControlStateNormal)];
        //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
        self.cleanBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 70*kRatio);
        //button标题的偏移量，这个偏移量是相对于图片的
        self.cleanBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.cleanBtn.titleLabel.font = kFont(12*kRatio);
        
    }
    return self;
}




- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if (self.clickCycleBlock) {
        self.clickCycleBlock(index);
    }
}


- (void)clickCycleBlock:(ClickCycleViewBlock)clickCycleBlock {
    self.clickCycleBlock = clickCycleBlock;
}

@end



#pragma mark  ------------------------   商品详情轮播  -----------------------------
//商品详情轮播
@implementation LHRentGoodsDetailCycleView



/*
 租赁详情
 */
- (instancetype)initWithFrame:(CGRect)frame
                   imageFrame:(CGRect)imageFrame
             placeHolderImage:(UIImage *)placeHolderImage {
    if (self = [super initWithFrame:frame]) {
        self.rentCycleView = [[SDCycleScrollView alloc] initWithFrame:imageFrame];
        self.rentCycleView.delegate = self;
        self.rentCycleView.placeholderImage = placeHolderImage;
        [self addSubview:self.rentCycleView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.font = kFont(17*kRatio);
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(kFit(5));
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.equalTo(self.rentCycleView.mas_bottom).offset(5);
            make.height.mas_equalTo(kFit(25));
        }];
        
        UIButton *addBox = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [addBox setTitle:@"加入我的盒子" forState:(UIControlStateNormal)];
        [addBox setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [self addSubview:addBox];
        [addBox mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(kFit(15));
            make.right.equalTo(self.mas_right).offset(kFit(-15));
            make.height.mas_equalTo(kFit(40));
            make.bottom.equalTo(self.mas_bottom).offset(kFit(-20));
        }];
        addBox.layer.masksToBounds = YES;
        addBox.layer.borderColor = [UIColor redColor].CGColor;
        addBox.layer.borderWidth = 1;
        addBox.layer.cornerRadius = 2;
        
        self.tagView = [[LHTagView alloc] initWithFrame:CGRectMake(10, kFit(30)+kScreenWidth*1.4, kScreenWidth-10, kFit(40))];
        [self addSubview:self.tagView];
    }
    return self;
}

- (void)setSizeArray:(NSArray *)sizeArray {
    _sizeArray = sizeArray;
    self.tagView.contentArray = sizeArray;
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if (self.clickCycleBlock) {
        self.clickCycleBlock(index);
    }
}

- (void)clickCycleBlock:(ClickCycleViewBlock)clickCycleBlock {
    self.clickCycleBlock = clickCycleBlock;
}


@end


#pragma mark  ------------------------  新品 商品详情轮播  -----------------------------
//商品详情轮播
@implementation LHNewGoodsDetailCycleView

/*
 租赁详情
 */
- (instancetype)initWithFrame:(CGRect)frame
                   imageFrame:(CGRect)imageFrame
             placeHolderImage:(UIImage *)placeHolderImage {
    if (self = [super initWithFrame:frame]) {
        self.rentCycleView = [[SDCycleScrollView alloc] initWithFrame:imageFrame];
        self.rentCycleView.delegate = self;
        self.rentCycleView.placeholderImage = placeHolderImage;
        [self addSubview:self.rentCycleView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kFit(15), self.rentCycleView.maxY+5, kScreenWidth-kFit(30), kFit(25))];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.font = kFont(17*kRatio);
        [self addSubview:self.titleLabel];

        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kFit(15), self.titleLabel.maxY+5, kScreenWidth-kFit(30), kFit(30))];
        self.priceLabel.backgroundColor = [UIColor whiteColor];
        self.priceLabel.textColor = [UIColor redColor];
        self.priceLabel.font = kFont(kFit(18));
        [self addSubview:self.priceLabel];
        
        
        self.sizeTagView = [[LHTagView alloc] initWithFrame:CGRectMake(10, self.priceLabel.maxY, kScreenWidth-10, kFit(40))];
        [self addSubview:self.sizeTagView];
        self.colorTagView = [[LHTagView alloc] initWithFrame:CGRectMake(10, self.sizeTagView.maxY, kScreenWidth-10, kFit(40))];
        [self addSubview:self.colorTagView];
        
        
        UIButton *addCart = [UIButton buttonWithType:(UIButtonTypeCustom)];
        addCart.frame = CGRectMake(kFit(15), self.maxY-kFit(50), (kScreenWidth-kFit(45))/2, kFit(45));
        [addCart setTitle:@"加入购物车" forState:(UIControlStateNormal)];
        [addCart setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [addCart addTarget:self action:@selector(addShoppingCart) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:addCart];
        addCart.layer.masksToBounds = YES;
        addCart.layer.borderColor = [UIColor redColor].CGColor;
        addCart.layer.borderWidth = 1;
        addCart.layer.cornerRadius = 2;
        
        
        UIButton *bugNowBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        bugNowBtn.frame = CGRectMake(addCart.maxX + kFit(15), self.maxY-kFit(50), (kScreenWidth-kFit(45))/2, kFit(45));
        [bugNowBtn setTitle:@"立即购买" forState:(UIControlStateNormal)];
        [bugNowBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [bugNowBtn addTarget:self action:@selector(bugNowAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:bugNowBtn];
        bugNowBtn.backgroundColor = [UIColor redColor];
        bugNowBtn.layer.masksToBounds = YES;
        bugNowBtn.layer.cornerRadius = 2;
        

        
    }
    return self;
}

- (void)setSizeArray:(NSArray *)sizeArray {
    _sizeArray = sizeArray;
    self.sizeTagView.contentArray = sizeArray;
}

- (void)setColorArray:(NSArray *)colorArray {
    _colorArray = colorArray;
    self.colorTagView.contentArray = colorArray;
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if (self.clickCycleBlock) {
        self.clickCycleBlock(index);
    }
}

- (void)clickCycleBlock:(ClickCycleViewBlock)clickCycleBlock {
    self.clickCycleBlock = clickCycleBlock;
}


- (void)addShoppingCart {
    
}

- (void)bugNowAction {
    
}







@end



















