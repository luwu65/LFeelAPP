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
        
        [self.webPriceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20*kRatio);
            make.top.equalTo(self.titleLabel).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
            make.width.mas_equalTo(self.frame.size.width/2);
        }];

        NSString *priStr = @"官网价: ¥19999";
        NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:priStr];
        [attributeMarket setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle)} range:NSMakeRange(0,priStr.length)];
        self.webPriceLabel.attributedText = attributeMarket;
        
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
        
        [self.webPriceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.top.equalTo(self.titleLabel).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
            make.width.mas_equalTo(self.frame.size.width/2);
        }];
    }
    return self;
}









- (void)handleCollecitonBtnAction:(CollecitonButtonBlock)block {
    self.collectionBtnBlock = block;
}





@end
