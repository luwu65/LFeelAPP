//
//  LHBrondCollectionCell.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBrondCollectionCell.h"

@implementation LHBrondCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}





- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.mas_width);
            make.height.equalTo(self.goodsImageView.mas_width).multipliedBy(1.0f);
            make.left.equalTo(self.mas_left).offset(0);
            make.top.equalTo(self.mas_top).offset(0);
        }];
        
        [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.mas_width);
            make.height.mas_equalTo(20*kRatio);
            make.top.equalTo(self.goodsImageView).offset(0);
            make.left.equalTo(self.mas_left).offset(0);
        }];
        
    }
    return self;
}

- (void)setListModel:(LHCategoryDetailListModel *)listModel {
    if (listModel.url) {
        [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:listModel.url] placeholderImage:kImage(@"")];
    } else {
        self.goodsImageView.image = kImage(@"");
    }
    
    if (listModel.category_name) {
        self.goodsTitleLabel.text = [NSString stringWithFormat:@"%@", listModel.category_name];
    }
}
















@end
