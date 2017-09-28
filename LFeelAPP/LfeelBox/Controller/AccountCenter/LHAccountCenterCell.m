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
//    self.goodsImageView.backgroundColor = [UIColor redColor];
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




- (void)reloadDataWithModel:(LHAccountGoodsModel *)goodsModel {
    if (![goodsModel.url isKindOfClass:[NSNull class]]) {
        [self.goodsImageView sd_setImageWithURL:kURL(goodsModel.url) placeholderImage:kImage(@"")];
    } else {
        self.goodsImageView.image = [UIImage imageNamed:@""];
    }
    self.titleLabel.text = goodsModel.product_name;
    if (goodsModel.property_value.count == 1) {
        self.sizeLabel.text = [NSString stringWithFormat:@"%@", goodsModel.property_value.firstObject];
    } else {
        self.sizeLabel.text = [NSString stringWithFormat:@"%@,%@", goodsModel.property_value.firstObject, goodsModel.property_value.lastObject];
    }
    //¥%@元/件 X %@
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@元/件", goodsModel.price_lfeel];
    self.numLabel.text = [NSString stringWithFormat:@"x %@", goodsModel.count];
}


- (void)reloadDataWithLHOrderProductModel:(LHOrderProductModel *)orderModel {
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@/件", orderModel.price];
    self.numLabel.text = [NSString stringWithFormat:@"x %@", orderModel.count];
    if (![orderModel.url isKindOfClass:[NSNull class]]) {
        [self.goodsImageView sd_setImageWithURL:kURL(orderModel.url) placeholderImage:kImage(@"")];
    } else {
        self.goodsImageView.image = [UIImage imageNamed:@""];
    }
    self.titleLabel.text = orderModel.product_name;
    if (orderModel.property_value.count == 1) {
        self.sizeLabel.text = [NSString stringWithFormat:@"%@", orderModel.property_value.firstObject];
    } else {
        self.sizeLabel.text = [NSString stringWithFormat:@"%@,%@", orderModel.property_value.firstObject, orderModel.property_value.lastObject];
    }
}

















@end



