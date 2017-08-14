//
//  LHCartHeaderView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/24.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHCartHeaderView.h"

@implementation LHCartHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//
//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        self.contentView.backgroundColor = [UIColor whiteColor];
//        [self setUI];
//        
//        
//    }
//    return self;
//}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];

        [self setUI];
    }
    return self;
}


- (void)setUI {
//    __weak typeof(self) weakSelf = self;
    //选中按钮
    self.clickBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.clickBtn.frame = CGRectMake(15*kRatio, 2.5*kRatio, 30*kRatio, 30*kRatio);
    [self.contentView addSubview:self.clickBtn];
    [_clickBtn setBackgroundImage:[UIImage imageNamed:@"MyBox_click_default"] forState:(UIControlStateNormal)];
    [_clickBtn setBackgroundImage:[UIImage imageNamed:@"MyBox_clicked"] forState:(UIControlStateSelected)];
    [_clickBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    [_clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(30*kRatio);
//        make.height.mas_equalTo(30*kRatio);
//        make.left.mas_equalTo(15*kRatio);
//        make.centerY.equalTo(self.mas_centerY);
//    }];
    
    //图片
    self.storeImageView = [[UIImageView alloc] init];
    self.storeImageView.frame = CGRectMake(55*kRatio, 5*kRatio, 25*kRatio, 25*kRatio);
    self.storeImageView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.storeImageView];
//    [self.storeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_clickBtn.mas_right).offset(10*kRatio);
//        make.centerY.equalTo(self.mas_centerY);
//        make.top.equalTo(self.mas_top).offset(5*kRatio);
//        make.bottom.equalTo(self.mas_bottom).offset(-5*kRatio);
//        make.width.equalTo(self.storeImageView.mas_height).multipliedBy(1.0f);
//    }];

    //title
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(90*kRatio, 5*kRatio, kScreenWidth-90*kRatio, 25*kRatio);
    [self.contentView addSubview:_titleLabel];
    self.titleLabel.font = kFont(14*kRatio);
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(5*kRatio);
//        make.bottom.equalTo(self.mas_bottom).offset(-5*kRatio);
//        make.left.equalTo(self.storeImageView.mas_right).offset(8*kRatio);
//        make.right.equalTo(self.mas_right).offset(-8*kRatio);
//    }];
}

//选中按钮
- (void)clickBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.clickBlock) {
        self.clickBlock(sender.selected);
    }
}


- (void)clickWithHeaderViewBlock:(ClickedBlock)block {
    self.clickBlock = block;
}


- (void)setIsSelect:(BOOL)isSelect {
    self.clickBtn.selected = isSelect;
    _isSelect = isSelect;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    _title = title;
}









@end
