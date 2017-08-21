//
//  LHMyBoxCell.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/14.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHMyBoxCell.h"

@implementation LHMyBoxCell

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
    [self addSubview:self.goodsImageView];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left).offset(5*kRatio);
        make.top.equalTo(weakself.mas_top).offset(5*kRatio);
        make.bottom.equalTo(weakself.mas_bottom).offset(-5*kRatio);
        make.centerY.equalTo(weakself.mas_centerY);
        make.width.equalTo(weakself.goodsImageView.mas_height).multipliedBy(1.0f);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = kFont(14*kRatio);
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20*kRatio);
        make.left.equalTo(weakself.goodsImageView.mas_right).offset(5*kRatio);
        make.right.equalTo(weakself.mas_right).offset(-5*kRatio);
        make.top.equalTo(weakself.mas_top).offset(5*kRatio);
    }];

    self.brandLabel = [[UILabel alloc] init];
    self.brandLabel.textColor = [UIColor lightGrayColor];
    self.brandLabel.font = kFont(14*kRatio);
    [self addSubview:self.brandLabel];
    [self.brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20*kRatio);
        make.top.equalTo(weakself.titleLabel.mas_bottom).offset(5*kRatio);
        make.left.equalTo(weakself.goodsImageView.mas_right).offset(5*kRatio);
        make.right.equalTo(weakself.mas_right).offset(-5*kRatio);
        
    }];
    
    self.sizeLabel = [[UILabel alloc] init];
    self.sizeLabel.font = kFont(14*kRatio);
    [self addSubview:self.sizeLabel];
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20*kRatio);
        make.left.equalTo(weakself.goodsImageView.mas_right).offset(5*kRatio);
        make.right.equalTo(weakself.mas_right).offset(-5*kRatio);
        make.bottom.equalTo(weakself.mas_bottom).offset(-5*kRatio);
    }];

    
}

- (void)setCollectModel:(LHCollectModel *)collectModel {
    if (![collectModel.product_url isKindOfClass:[NSNull class]]) {
        [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:collectModel.product_url] placeholderImage:kImage(@"")];
    } else {
        self.goodsImageView.image = kImage(@"");
    }
    
    self.titleLabel.text = collectModel.product_name;
    self.brandLabel.text = collectModel.brand_name;   
}



@end
