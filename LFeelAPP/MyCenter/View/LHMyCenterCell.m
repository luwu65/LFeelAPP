//
//  LHMyCenterCell.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHMyCenterCell.h"

@implementation LHMyCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
     
        self.titleLabel.font = kFont(15*kRatio);
        [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(25*kRatio);
            make.height.mas_equalTo(25*kRatio);
        }];
        
        
    }
    return self;
}

@end
