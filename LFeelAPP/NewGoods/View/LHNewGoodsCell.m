//
//  LHNewGoodsCell.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHNewGoodsCell.h"

@implementation LHNewGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = [UIColor redColor];
        self.statusView.backgroundColor = [UIColor redColor];
    } else {
        self.backgroundColor = kColor(245, 246, 246);
        self.titleLabel.textColor = [UIColor blackColor];
        self.statusView.backgroundColor = [UIColor clearColor];
    }
}


- (void)setListModel:(LHCategoryListModel *)listModel {
    if (listModel.category_name) {
        self.titleLabel.text = listModel.category_name;
    }
}












@end
