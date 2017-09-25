//
//  LHOrderGoodsCell.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/20.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHOrderGoodsCell.h"

@implementation LHOrderGoodsCell

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
    
    
    self.brandLabel = [[UILabel alloc] init];
    self.brandLabel.textColor = [UIColor lightGrayColor];
    self.brandLabel.font = kFont(14*kRatio);
    [self.contentView addSubview:self.brandLabel];
    [self.brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.goodsImageView.centerY);
        make.height.mas_equalTo(17*kRatio);
        //        make.top.equalTo(weakself.titleLabel.mas_bottom).offset(5*kRatio);
        make.left.equalTo(weakself.goodsImageView.mas_right).offset(5*kRatio);
        make.right.equalTo(weakself.mas_right).offset(-5*kRatio);
        
    }];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = kFont(14*kRatio);
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15*kRatio);
        make.left.equalTo(weakself.goodsImageView.mas_right).offset(5*kRatio);
        make.right.equalTo(weakself.mas_right).offset(-5*kRatio);
        make.bottom.equalTo(weakself.brandLabel.mas_top).offset(-5*kRatio);
    }];


    
    self.countLabel = [[UILabel alloc] init];
    self.countLabel.font = kFont(14*kRatio);
    self.countLabel.textAlignment = NSTextAlignmentRight;
    self.countLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20*kRatio);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5*kRatio);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15*kRatio);
    }];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.font = kFont(14*kRatio);
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15*kRatio);
        make.left.equalTo(weakself.goodsImageView.mas_right).offset(5*kRatio);
        make.right.equalTo(weakself.countLabel.mas_left).offset(-10*kRatio);
        make.top.equalTo(weakself.brandLabel.mas_bottom).offset(5*kRatio);
    }];
    
}




























@end
