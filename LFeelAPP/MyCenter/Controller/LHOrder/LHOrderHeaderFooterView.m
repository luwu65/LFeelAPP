//
//  LHOrderHeaderFooterView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/21.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHOrderHeaderFooterView.h"

@implementation LHOrderHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];

        [self setUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}



- (void)setUI {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = kColor(245, 245, 245);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.height.mas_equalTo(kFit(15));
    }];
    
    UIView *bgView = [[UIView alloc] init];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(lineView.mas_bottom).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
    self.shopImageview = [[UIImageView alloc] init];
    [bgView addSubview:self.shopImageview];
    [self.shopImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.centerY.mas_equalTo(bgView.mas_centerY);
        make.height.width.mas_equalTo(kFit(20));
    }];

    self.statusLabel = [[UILabel alloc] init];
    self.statusLabel.font = kFont(14);
    self.statusLabel.textColor = [UIColor redColor];
    self.statusLabel.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.mas_equalTo(bgView.mas_centerY);
        make.height.mas_equalTo(kFit(20));
        make.width.mas_equalTo(kFit(80));
    }];
    
    self.shopLabel = [[UILabel alloc] init];
    self.shopLabel.font = kFont(15);
    [bgView addSubview:self.shopLabel];
    [self.shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopImageview.mas_right).offset(10);
        make.right.equalTo(self.statusLabel.mas_left).offset(-10);
        make.centerY.mas_equalTo(bgView.mas_centerY);
        make.height.mas_equalTo(kFit(20));
    }];
}





@end





@implementation LHOrderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setUI];
        
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}


- (void)setUI {
    self.allLabel = [[UILabel alloc] init];
    self.allLabel.textAlignment = NSTextAlignmentRight;
    self.allLabel.font = kFont(kFit(15));
    [self.contentView addSubview:self.allLabel];
    [self.allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.height.mas_equalTo(kFit(45));
        make.left.equalTo(self.contentView.mas_left).offset(10);
    }];
    
    LHDevider *devider = [[LHDevider alloc] init];
    [self.contentView addSubview:devider];
    [devider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(self.allLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.contentView.mas_left).offset(0);
    }];
    
    
    self.bottomView = [[UIView alloc] init];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(devider.mas_bottom).offset(0);
        make.height.mas_equalTo(kFit(45));
    }];
    
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.rightBtn addTarget:self action:@selector(handleRightBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    self.rightBtn.titleLabel.font = kFont(kFit(13));
    [self.bottomView addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(devider.mas_bottom).offset(kFit(10));
        make.height.mas_equalTo(kFit(25));
        make.width.mas_equalTo(kFit(80));
    }];
    self.rightBtn.layer.cornerRadius = kFit(25)/2;
    self.rightBtn.layer.masksToBounds = YES;
    
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(handleLeftBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.titleLabel.font = kFont(kFit(13));
    [self.bottomView addSubview:self.leftBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightBtn.mas_left).offset(-10);
        make.top.equalTo(devider.mas_bottom).offset(kFit(10));
        make.height.mas_equalTo(kFit(25));
        make.width.mas_equalTo(kFit(80));
    }];
    self.leftBtn.layer.cornerRadius = kFit(25)/2;
    self.leftBtn.layer.masksToBounds = YES;
}

- (void)handleRightBtn:(UIButton *)rightBtn {
    if (self.ClickBtnBlock) {
        self.ClickBtnBlock(rightBtn);
    }
    
}

- (void)handleLeftBtn:(UIButton *)leftBtn {
    if (self.ClickBtnBlock) {
        self.ClickBtnBlock(leftBtn);
    }
}

@end



































