//
//  LHReceiveAddressCell.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/20.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHReceiveAddressCell.h"

@implementation LHReceiveAddressCell

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
    //姓名电话
    self.nameLabel = [[UILabel alloc] init];
    _nameLabel.font = kFont(kFit(16));
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(5);
        make.height.mas_equalTo(kFit(25));
        make.width.mas_equalTo((kScreenWidth-30)/2);
    }];
    
    self.phoneLabel = [[UILabel alloc] init];
    self.phoneLabel.textAlignment = NSTextAlignmentRight;
    _phoneLabel.font = kFont(kFit(16));
    [self addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.mas_top).offset(5);
        make.width.mas_equalTo((kScreenWidth-30)/2);
        make.height.mas_equalTo(kFit(25));
    }];
    
    //地址
    self.addressLabel = [[UILabel alloc] init];
    _addressLabel.numberOfLines = 0;
//    _addressLabel.textColor = [UIColor lightGrayColor];
    _addressLabel.font = kFont(kFit(14));
    [self addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(kFit(30));
    }];
    
    //分隔线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = kColor(245, 245, 245);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(_addressLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(1);
    }];
    
    //设为默认
    self.defaultBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.defaultBtn setBackgroundImage:[UIImage imageNamed:@"MyBox_click_default"] forState:(UIControlStateNormal)];
    [self.defaultBtn addTarget:self action:@selector(defaultBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.defaultBtn];
    [self.defaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.width.mas_equalTo(kFit(25));
        make.height.mas_equalTo(kFit(25));
    }];
    
    UILabel *defaultLabel = [[UILabel alloc] init];
    defaultLabel.text = @"设为默认";
    defaultLabel.font = kFont(kFit(13));
    [self addSubview:defaultLabel];
    [defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.defaultBtn.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.width.mas_equalTo(kFit(80));
        make.height.mas_equalTo(kFit(25));
    }];
    
    //删除
    self.deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"MyCenter_address_delete"] forState:(UIControlStateNormal)];
    [self.deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.width.mas_equalTo(kFit(25));
        make.height.mas_equalTo(kFit(25));
    }];
    
    //编辑
    self.editBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.editBtn setBackgroundImage:[UIImage imageNamed:@"MyCenter_address_edit"] forState:(UIControlStateNormal)];
    [self.editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.editBtn];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.deleteBtn.mas_left).offset(-20);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.width.mas_equalTo(kFit(25));
        make.height.mas_equalTo(kFit(25));
    }];
}

//设置为默认
- (void)defaultBtnAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"MyBox_clicked"] forState:(UIControlStateNormal)];
    if (self.setDefaultBlock) {
        self.setDefaultBlock(sender);
    }
}
- (void)setDefaultAddressBlock:(SetDefaultBlock)block {
    self.setDefaultBlock = block;
}
//删除
- (void)deleteAction:(UIButton *)sender {
    if (self.deleteAddressBlock) {
        self.deleteAddressBlock();
    }
    
}
- (void)deleteAddressBlock:(DeleteAddressBlock)block {
    self.deleteAddressBlock = block;
}

//编辑
- (void)editBtnAction:(UIButton *)sender {
    if (self.editAddressBlock) {
        self.editAddressBlock();
    }
}

- (void)EditAddressBlock:(EditAddressBlock)block {
    self.editAddressBlock = block;
}


- (void)setAddressModel:(LHAddressModel *)addressModel {
    _addressModel = addressModel;
    self.nameLabel.text = [NSString stringWithFormat:@"%@", addressModel.name];
    self.phoneLabel.text = [NSString stringWithFormat:@"%@", addressModel.mobile];
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@", addressModel.province, addressModel.city, addressModel.district, addressModel.detail_address];
    if ([addressModel.isdefault integerValue] == 0) {
        [self.defaultBtn setImage:kImage(@"MyBox_click_default") forState:(UIControlStateNormal)];
    } else {
        [self.defaultBtn setImage:kImage(@"MyBox_clicked") forState:(UIControlStateNormal)];
    }
}


@end
