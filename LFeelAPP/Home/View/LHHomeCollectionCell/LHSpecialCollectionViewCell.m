//
//  LHSpecialCollectionViewCell.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHSpecialCollectionViewCell.h"

@implementation LHSpecialCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setThemeModel:(LHHomeThemesModel *)themeModel {
    if (![themeModel.url isEqualToString:@""]) {
        [self.themeImageView sd_setImageWithURL:[NSURL URLWithString:themeModel.url] placeholderImage:[UIImage imageNamed:@""]];
    }
}


@end
