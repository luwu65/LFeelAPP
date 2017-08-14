//
//  LHUserInfoCell.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/3.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHUserInfoCell.h"

@implementation LHUserInfoCell

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
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kFont(15);
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.top.equalTo(self.mas_top).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.width.mas_equalTo(100);
        }];
        
        self.detailTF = [[UITextField alloc] init];
        self.detailTF.textColor = [UIColor lightGrayColor];
        self.detailTF.font = kFont(15);
        self.detailTF.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.detailTF];
        [self.detailTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(0);
            make.right.equalTo(self.mas_right).offset(-40);
            make.top.equalTo(self.mas_top).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
        }];
        
    }
    return self;
}










@end
