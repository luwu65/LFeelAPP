//
//  LHAccountCenterHeaderFooterView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/31.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHAccountCenterHeaderFooterView.h"

@implementation LHAccountCenterHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self CreateNoAddressView];

    }
    return self;
}

- (void)setIsUpdateFrame:(BOOL)isUpdateFrame {
    _isUpdateFrame = isUpdateFrame;
    if (isUpdateFrame) {
        [self.noAddressBgView removeFromSuperview];
        [self CreateAddressView];
        
    }
}

- (void)CreateNoAddressView {
    self.noAddressBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height)];
    [self addSubview:self.noAddressBgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAddressViewAction)];
    [self.noAddressBgView addGestureRecognizer:tap];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, self.frame.size.height)];
    titleLabel.text = @"收货地址";
    titleLabel.font = kFont(15);
    [self.noAddressBgView addSubview:titleLabel];
    
    UIImageView *openImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 40, self.frame.size.height - 10, 20, 20)];
    openImageView.image = kImage(@"");
    [self.noAddressBgView addSubview:openImageView];
}

- (void)CreateAddressView {
    self.addressBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height)];
    self.addressBgView.backgroundColor = [UIColor greenColor];
    [self addSubview:self.addressBgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAddressViewAction)];
    [self.noAddressBgView addGestureRecognizer:tap];
    
    UIImageView *addressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kFit(10), (self.frame.size.height-kFit(15))/2, kFit(15), kFit(15))];
    addressImageView.image = kImage(@"MyCenter_CardBox_OpenCell");
    [self.addressBgView addSubview:addressImageView];
    
    UIImageView *openImageView = [[UIImageView alloc] init];//WithFrame:CGRectMake(kScreenWidth - kFit(25), (self.frame.size.height-kFit(15))/2, kFit(8), kFit(15))
//    openImageView.size = CGSizeMake(kFit(8), kFit(15));
//    openImageView.centerY = self.addressBgView.centerY;
    openImageView.image = kImage(@"MyCenter_CardBox_OpenCell");
    [self.addressBgView addSubview:openImageView];
    [openImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.addressBgView.mas_right).offset(-10);
        make.width.mas_equalTo(kFit(8));
        make.height.mas_equalTo(kFit(15));
        make.centerY.mas_equalTo(self.addressBgView.mas_centerY);
    }];
    
    //姓名
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kFit(30), kFit(10), (kScreenWidth-kFit(60))/2, kFit(20))];
    self.nameLabel.font = kFont(15);
    [self.addressBgView addSubview:self.nameLabel];
    
    //电话
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.maxX, kFit(10), (kScreenWidth-kFit(60))/2, kFit(20))];
    self.phoneLabel.textAlignment = NSTextAlignmentRight;
    [self.addressBgView addSubview:self.phoneLabel];
    
    //地址
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(kFit(30), kFit(35), kScreenWidth-kFit(60), kFit(50))];
    self.addressLabel.font = kFont(14);
    [self.addressBgView addSubview:self.addressLabel];
    
}

- (void)tapAddressViewAction {
    if (self.clickHeaderViewBlock) {
        self.clickHeaderViewBlock();
    }
}
- (void)clickHeaderViewBlock:(ClickHeaderViewBlock)block {
    self.clickHeaderViewBlock = block;
}

@end


#pragma mark  -----------------------------------------------------
@implementation LHAccountCenterFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self rm_fitAllConstraint];
}

+ (instancetype)creatView {
    return [self creatViewFromNibName:@"LHAccountCenterHeaderFooterView" atIndex:0];
}

- (void)selectedPayTypeBlock:(SelectedBlock)block {
    self.payTypeBlock = block;
}
- (void)selectedCheaperCardBlock:(SelectedBlock)block {
    self.cheaperCardBlock = block;
}
- (void)handleAgreeBlock:(HandleBlock)block {
    self.agreeBlock = block;
}


//优惠券
- (IBAction)cheaperCardBtn:(UIButton *)sender {
    if (self.cheaperCardBlock) {
        self.cheaperCardBlock(self.cheaperCardLabal);
    }
}

//支付方式
- (IBAction)payType:(UIButton *)sender {
    if (self.payTypeBlock) {
        self.payTypeBlock(self.payTypeLabel);
    }
}

//同意协议
- (IBAction)agreeBtn:(UIButton *)sender {
    if (self.agreeBlock) {
        self.agreeBlock();
    }
}



@end




#pragma mark  -----------------------------------------------------
@implementation LHAccountSectionHeaderView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColor(245, 245, 245);
        self.storeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, kFit(10), kFit(20), kFit(20))];
        self.storeImageView.backgroundColor = [UIColor redColor];
        [self addSubview:self.storeImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, kFit(10), kScreenWidth - 50, kFit(20))];
        self.titleLabel.font = kFont(kFit(15));
        [self addSubview:self.titleLabel];
    }
    return self;
}





@end
















