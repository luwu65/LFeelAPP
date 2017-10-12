//
//  LHPhotoCommentCell.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/10/11.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHPhotoCommentCell.h"

@implementation LHPhotoCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    [self.photoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.contentView).offset(kFit(10));
//        make.top.mas_equalTo(self.contentView).offset(kFit(10));
//        make.bottom.mas_equalTo(self.contentView).offset(kFit(-10));
//        make.right.mas_equalTo(self.contentView).offset(kFit(-10));
//        
//    }];
//    
//    [self.deleteBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.contentView).offset(kFit(0));
//        make.right.mas_equalTo(self.contentView).offset(kFit(0));
//        make.width.height.mas_equalTo(kFit(25));
//    }];
    
}


- (IBAction)deleteBtn:(UIButton *)sender {
    if (self.DeleteBlock) {
        self.DeleteBlock();
    }
}














@end
