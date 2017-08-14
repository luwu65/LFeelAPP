//
//  LHAccountCenterCell.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/31.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHAccountCenterCell.h"


@implementation LHAccountGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}


- (void)setUI {
    __weak typeof(self) weakself = self;
    
    self.goodsImageView = [[UIImageView alloc] init];
    self.goodsImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.goodsImageView];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left).offset(5*kRatio);
        make.top.equalTo(weakself.mas_top).offset(5*kRatio);
        make.bottom.equalTo(weakself.mas_bottom).offset(-5*kRatio);
        make.centerY.equalTo(weakself.mas_centerY);
        make.width.equalTo(weakself.goodsImageView.mas_height).multipliedBy(1.0f);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = kFont(14*kRatio);
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20*kRatio);
        make.left.equalTo(weakself.goodsImageView.mas_right).offset(5*kRatio);
        make.right.equalTo(weakself.mas_right).offset(-5*kRatio);
        make.top.equalTo(weakself.mas_top).offset(5*kRatio);
    }];
    
    self.sizeLabel = [[UILabel alloc] init];
    self.sizeLabel.textColor = [UIColor lightGrayColor];
    self.sizeLabel.font = kFont(14*kRatio);
    [self.contentView addSubview:self.sizeLabel];
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20*kRatio);
        make.top.equalTo(weakself.titleLabel.mas_bottom).offset(5*kRatio);
        make.left.equalTo(weakself.goodsImageView.mas_right).offset(5*kRatio);
        make.right.equalTo(weakself.mas_right).offset(-5*kRatio);
        
    }];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.font = kFont(14*kRatio);
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20*kRatio);
        make.left.equalTo(weakself.goodsImageView.mas_right).offset(5*kRatio);
        make.right.equalTo(weakself.mas_right).offset(kFit(-100));
        make.bottom.equalTo(weakself.mas_bottom).offset(-5*kRatio);
    }];
    
    self.numLabel = [[UILabel alloc] init];
    self.numLabel.font = kFont(kFit(14));
    self.numLabel.textAlignment = NSTextAlignmentRight;
    self.numLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.numLabel];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.mas_right).offset(kFit(-10));
        make.bottom.equalTo(weakself.mas_bottom).offset(kFit(-10));
        make.height.mas_equalTo(kFit(15));
        make.width.mas_equalTo(kFit(50));
    }];
}

























@end



