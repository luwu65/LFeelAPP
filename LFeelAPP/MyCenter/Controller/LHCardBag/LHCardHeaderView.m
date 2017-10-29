
//
//  LHCardHeaderView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/19.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHCardHeaderView.h"

@implementation LHCardHeaderView {
    ClickCardHeaderBlock _clickBlock;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    return self;
}


- (void)setUI {
    self.isClick = YES;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleHeaderViewAction:)];
    [self addGestureRecognizer:tap];
    self.titleImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.titleImageView];
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(12);
        make.bottom.equalTo(self.mas_bottom).offset(-12);
        make.width.equalTo(self.titleImageView.mas_height).multipliedBy(1.0f);
    }];
    
    self.openImageView = [[UIImageView alloc] init];
    self.openImageView.image = kImage(@"MyCenter_MyCard_open");
    [self.contentView addSubview:self.openImageView];
    [self.openImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(8);
        make.width.mas_equalTo(15);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = kFont(kFit(15));
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImageView.mas_right).offset(10);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.right.equalTo(self.openImageView.mas_left).offset(-10);
    }];
}



- (void)handleHeaderViewAction:(UITapGestureRecognizer *)tap {
    self.isClick = !self.isClick;
    if (_clickBlock) {
        _clickBlock(self.isClick);
    }
}


- (void)clickCardHeaderBlock:(ClickCardHeaderBlock)block {
    _clickBlock = block;
}


















@end
