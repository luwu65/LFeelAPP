//
//  LHParamCell.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/28.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHParamCell.h"

@implementation LHParamCell

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
        self.paramNameLabel = [[UILabel alloc] init];
        self.paramNameLabel.font = kFont(14);
        [self addSubview:self.paramNameLabel];
        [self.paramNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.top.equalTo(self.mas_top).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.width.mas_equalTo(kScreenWidth/3);
        }];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.textAlignment = NSTextAlignmentRight;
        self.contentLabel.font = kFont(14);
        [self addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.paramNameLabel.mas_right).offset(0);
            make.right.equalTo(self.mas_right).offset(-20);
            make.top.equalTo(self.mas_top).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
        }];
    }
    return self;
}







@end
