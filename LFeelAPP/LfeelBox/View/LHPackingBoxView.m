//
//  LHPackingBoxView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/14.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHPackingBoxView.h"

@implementation LHPackingBoxView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame packingStatusString:(NSString *)packingLabelStr packingButtonTitle:(NSString *)packingButtonTitle {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.7)];
        lineView.backgroundColor = kColor(245, 245, 245);
        [self addSubview:lineView];
        
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, kScreenWidth/3*2, kAllBarHeight*kRatio-4)];
        if (packingLabelStr) {
            self.statusLabel.text = packingLabelStr;
        }
        self.statusLabel.font = kFont(kFit(16));
        self.statusLabel.textAlignment = NSTextAlignmentCenter;
        self.statusLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:self.statusLabel];
        
        self.packingBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.packingBtn.frame = CGRectMake(kScreenWidth/3*2, 0, kScreenWidth/3, kAllBarHeight*kRatio);
        self.packingBtn.backgroundColor = [UIColor redColor];
        self.packingBtn.titleLabel.font = kFont(kFit(16));
        [self.packingBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self.packingBtn addTarget:self action:@selector(handldPacking:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.packingBtn];
    }
    return self;
}

- (void)handldPacking:(UIButton *)sender {
    if (self.clickPackingBtnBlock) {
        self.clickPackingBtnBlock(sender.titleLabel.text);
    }
}


- (void)clickPackingButtonBlock:(ClickPackingButtonBlock)block {
    self.clickPackingBtnBlock = block;
}

#pragma  mark ------------------------- 结算 --------------------------
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.7)];
        lineView.backgroundColor = kColor(245, 245, 245);
        [self addSubview:lineView];
        
        self.allSelectBtn = [[CustomButton alloc] initWithFrame:CGRectMake(10, 0, kAllBarHeight*kRatio, kAllBarHeight*kRatio) imageFrame:CGRectMake(5, 0, kAllBarHeight*kRatio-10, kAllBarHeight*kRatio-10) imageName:@"MyBox_click_default" titleLabelFrame:CGRectMake(5, kAllBarHeight*kRatio-15, kAllBarHeight*kRatio-10, 14*kRatio) title:@"全部" titleColor:[UIColor lightGrayColor] titleFont:12*kRatio];
//        [self.allSelectBtn addTarget:self action:@selector(allBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.allSelectBtn];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAllBarHeight*kRatio+20, 5, kScreenWidth/3*2-kAllBarHeight*kRatio-5, kAllBarHeight*kRatio-10)];
        self.priceLabel.text = @"总价:";
        self.priceLabel.font = kFont(kFit(14));
        self.priceLabel.textColor = [UIColor redColor];
        [self addSubview:self.priceLabel];
        
        UIButton *accountButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [accountButton setTitle:@"去结算" forState:(UIControlStateNormal)];
        [accountButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        accountButton.titleLabel.font = kFont(kFit(16));
        accountButton.backgroundColor = [UIColor redColor];
        accountButton.frame = CGRectMake(kScreenWidth/3*2, 0, kScreenWidth/3, kAllBarHeight*kRatio);
        [accountButton addTarget:self action:@selector(accrountBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:accountButton];
        
    }
    return self;
}


//- (void)allBtnAction:(CustomButton *)sender {
//    sender.selected = !sender.selected;
//    if (sender.selected == YES) {
//        sender.titleImageView.image = [UIImage imageNamed:@"MyBox_clicked"];
//    } else {
//        sender.titleImageView.image = [UIImage imageNamed:@"MyBox_click_default"];
//    }
//    if (self.allClickGoodsBlock) {
//        self.allClickGoodsBlock(sender.selected);
//    }
//    
//}
//
//- (void)allClickGoodsBlock:(AllClickGoodsBlock)block {
//    self.allClickGoodsBlock = block;
//}

- (void)accrountBtnAction:(UIButton *)sender {
    if (self.goAccrountBlock) {
        self.goAccrountBlock();
    }
}

- (void)goAccrountGoodsBlock:(GoAccrountBlock)block {
    self.goAccrountBlock = block;
}

@end




#pragma mark  ------------------------------------------------这是一条淫荡的分隔线------------------------------------------------------------
//-------------------------------------> 下面是申请发票的结算栏 <---------------------------------------


@implementation LHApplyBillBottomView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.7)];
        lineView.backgroundColor = kColor(245, 245, 245);
        [self addSubview:lineView];
        
        CustomButton *allBtn = [[CustomButton alloc] initWithFrame:CGRectMake(15, 0, kAllBarHeight*kRatio, kAllBarHeight*kRatio) imageFrame:CGRectMake(5, 0, kAllBarHeight*kRatio-10, kAllBarHeight*kRatio-10) imageName:@"MyBox_click_default" titleLabelFrame:CGRectMake(5, kAllBarHeight*kRatio-15, kAllBarHeight*kRatio-10, 14*kRatio) title:@"全部" titleColor:[UIColor lightGrayColor] titleFont:12*kRatio];
        
        [allBtn addTarget:self action:@selector(allBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:allBtn];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAllBarHeight*kRatio+20, 5, kScreenWidth/3*2-kAllBarHeight*kRatio-5, kAllBarHeight*kRatio-10)];
        self.priceLabel.text = @"总价:";
        self.priceLabel.font = kFont(14);
        [self addSubview:self.priceLabel];
        
        UIButton *accountButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [accountButton setTitle:@"申请发票" forState:(UIControlStateNormal)];
        [accountButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        accountButton.titleLabel.font = kFont(16*kRatio);
        accountButton.backgroundColor = [UIColor redColor];
        accountButton.frame = CGRectMake(kScreenWidth/3*2, 0, kScreenWidth/3, kAllBarHeight*kRatio);
        [accountButton addTarget:self action:@selector(applyBillAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:accountButton];
        
        
        
    }
    return self;
}

- (void)allBtnAction:(CustomButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        sender.titleImageView.image = [UIImage imageNamed:@"MyBox_clicked"];
    } else {
        sender.titleImageView.image = [UIImage imageNamed:@"MyBox_click_default"];
    }
    if (self.allClickGoodsBlock) {
        self.allClickGoodsBlock(sender.selected);
    }
    
}

- (void)allClickGoodsBlock:(AllClickGoodsBlock)block {
    self.allClickGoodsBlock = block;
}

- (void)applyBillAction:(UIButton *)sender {
    if (self.applyBillBlock) {
        self.applyBillBlock();
    }
}

- (void)applyBillBlock:(ApplyBillBlock)block {
    self.applyBillBlock = block;
}

@end



















