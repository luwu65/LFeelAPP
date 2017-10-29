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
        make.left.equalTo(weakself.mas_left).offset(kFit(5));
        make.top.equalTo(weakself.mas_top).offset(kFit(5));
        make.bottom.equalTo(weakself.mas_bottom).offset(-kFit(5));
        make.centerY.equalTo(weakself.mas_centerY);
        make.width.equalTo(weakself.goodsImageView.mas_height).multipliedBy(1.0f);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = kFont(kFit(14));
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kFit(20));
        make.left.equalTo(weakself.goodsImageView.mas_right).offset(kFit(5));
        make.right.equalTo(weakself.mas_right).offset(-kFit(5));
        make.top.equalTo(weakself.mas_top).offset(kFit(5));
    }];

    self.brandLabel = [[UILabel alloc] init];
    self.brandLabel.textColor = [UIColor lightGrayColor];
    self.brandLabel.font = kFont(kFit(14));
    [self addSubview:self.brandLabel];
    [self.brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kFit(20));
        make.top.equalTo(weakself.titleLabel.mas_bottom).offset(kFit(5));
        make.left.equalTo(weakself.goodsImageView.mas_right).offset(kFit(5));
        make.right.equalTo(weakself.mas_right).offset(-kFit(5));
        
    }];
    
    self.sizeLabel = [[UILabel alloc] init];
    self.sizeLabel.font = kFont(kFit(14));
    [self addSubview:self.sizeLabel];
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kFit(20));
        make.left.equalTo(weakself.goodsImageView.mas_right).offset(kFit(5));
        make.right.equalTo(weakself.mas_right).offset(-kFit(5));
        make.bottom.equalTo(weakself.mas_bottom).offset(-kFit(5));
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
