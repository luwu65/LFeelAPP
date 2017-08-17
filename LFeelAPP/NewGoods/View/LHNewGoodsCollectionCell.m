//
//  LHNewGoodsCollectionCell.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHNewGoodsCollectionCell.h"

@implementation LHNewGoodsCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)collectionButtonAciton:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"NewGoods_Like"] forState:(UIControlStateNormal)];
        
    } else {
        [sender setImage:[UIImage imageNamed:@"NewGoods_unLike"] forState:(UIControlStateNormal)];
        
    }
    if (self.collectionBtnBlock) {
        self.collectionBtnBlock(sender.selected);
    }
}

- (void)handleCollecitonBtnAction:(CollecitonButtonBlock)block {
    self.collectionBtnBlock = block;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self.picImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.mas_width);
            make.height.equalTo(self.picImageView.mas_width).multipliedBy(1.2f);
            make.left.equalTo(self.mas_left).offset(0);
            make.top.equalTo(self.mas_top).offset(0);
        }];
        
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.mas_width);
            make.height.mas_equalTo(20*kRatio);
            make.top.equalTo(self.picImageView).offset(0);
            make.left.equalTo(self.mas_left).offset(0);
        }];
        
        [self.lfeelPriceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.frame.size.width/2);
            make.height.mas_equalTo(20*kRatio);
            make.top.equalTo(self.titleLabel).offset(0);
            make.left.equalTo(self.mas_left).offset(0);
        }];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.picImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.mas_width);
            make.height.equalTo(self.picImageView.mas_width).multipliedBy(1.2f);
            make.left.equalTo(self.mas_left).offset(0);
            make.top.equalTo(self.mas_top).offset(0);
        }];
        
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.mas_width);
            make.height.mas_equalTo(20*kRatio);
            make.top.equalTo(self.picImageView).offset(0);
            make.left.equalTo(self.mas_left).offset(0);
        }];
        
        [self.lfeelPriceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.frame.size.width/2);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.top.equalTo(self.titleLabel).offset(0);
            make.left.equalTo(self.mas_left).offset(0);
        }];
        

    }
    return self;
}





- (void)setListModel:(LHGoodsListModel *)listModel {
    if (listModel.url) {
        [self.picImageView sd_setImageWithURL:[NSURL URLWithString:listModel.url] placeholderImage:kImage(@"")];
    } else {
        self.picImageView.image = kImage(@"");
    }
    if (listModel.price_lfeel) {
        self.lfeelPriceLabel.text = [NSString stringWithFormat:@"乐荟价: ¥%@", listModel.price_lfeel];
    }
    if ([listModel.iscollection integerValue] == 0) {
        [self.collectionBtn setImage:kImage(@"NewGoods_unLike") forState:(UIControlStateNormal)];
        self.collectionBtn.selected = NO;
    } else {
        [self.collectionBtn setImage:kImage(@"NewGoods_Like") forState:(UIControlStateNormal)];
        self.collectionBtn.selected = YES;
    }
    if (listModel.product_name) {
        self.titleLabel.text = [NSString stringWithFormat:@"%@", listModel.product_name];
    }
}









@end
