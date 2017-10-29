//
//  LHBillHeaderFooterView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/20.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBillHeaderFooterView.h"

@implementation LHBillHeaderView {
    SelectBtnBlock _selectBlock;
}

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
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setUI {
    self.selectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.selectBtn setBackgroundImage:kImage(@"MyBox_click_default") forState:(UIControlStateNormal)];
    [self.selectBtn addTarget:self action:@selector(handleSelectBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.width.equalTo(self.selectBtn.mas_height).multipliedBy(1.0f);
    }];
    
    self.orderNumLabel = [[UILabel alloc] init];
    self.orderNumLabel.font = kFont(15);
    [self.contentView addSubview:self.orderNumLabel];
    [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectBtn.mas_right).offset(10);
        make.top.equalTo(self.mas_top).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.right.equalTo(self.mas_right).offset(-kFit(80));
    }];
    
//    UIView *lineView = [[UIView alloc] init];
//    lineView.backgroundColor = kColor(245, 245, 245);
//    [self.contentView addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(0);
//        make.bottom.equalTo(self.mas_bottom).offset(-2);
//        make.right.equalTo(self.mas_right).offset(0);
//        make.height.mas_equalTo(1);
//    }];
    
    self.statusLabel = [[UILabel alloc] init];
    self.statusLabel.font = kFont(kFit(14));
    [self.contentView addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-kFit(10));
        make.top.equalTo(self.mas_top).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.width.mas_equalTo(kFit(60));
    }];
    
}


- (void)handleSelectBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [sender setBackgroundImage:kImage(@"MyBox_clicked") forState:(UIControlStateNormal)];
    } else {
        [sender setBackgroundImage:kImage(@"MyBox_click_default") forState:(UIControlStateNormal)];
    }

    if (_selectBlock) {
        _selectBlock();
    }
}

- (void)selectAllBtnBlock:(SelectBtnBlock)block {
    _selectBlock = block;
}


@end




@implementation LHBillFooterView

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
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setUI {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = kColor(245, 245, 245);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    
    //        NSMutableAttributedString * attr = [[NSMutableAttributedString alloc] initWithString:txt];
    //        NSRange range = NSMakeRange(0, 5);
    //        [attr addAttribute:NSForegroundColorAttributeName value:HexColorInt32_t(999999) range:range];
    //        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Fit(14)] range:range];
    //        _totalPrice.attributedText = attr;
    UIView *lineBotView = [[UIView alloc] init];
    lineBotView.backgroundColor = kColor(245, 245, 245);
    [self addSubview:lineBotView];
    [lineBotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(10);
    }];
    
    self.allPriceLabel = [[UILabel alloc] init];
    self.allPriceLabel.font = kFont(15);
    [self addSubview:self.allPriceLabel];
    [self.allPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(lineView.mas_bottom).offset(5);
        make.bottom.equalTo(lineBotView.mas_top).offset(-5);
        make.width.mas_equalTo((kScreenWidth-20)/2);
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = kFont(kFit(15));
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(lineView.mas_bottom).offset(5);
        make.bottom.equalTo(lineBotView.mas_top).offset(-5);
        make.width.mas_equalTo((kScreenWidth-20)/2);
    }];
}



















@end
