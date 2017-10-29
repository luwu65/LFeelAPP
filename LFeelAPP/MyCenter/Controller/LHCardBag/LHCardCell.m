//
//  LHCardCell.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/19.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHCardCell.h"

@implementation LHCardCell

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
    //红色背景
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self).insets(UIEdgeInsetsMake(0, 10, 10, 10));
    }];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
   //银行图片
    self.bankImageView = [[UIImageView alloc] init];
    self.bankImageView.layer.cornerRadius = kFit(50)/2;
    self.bankImageView.layer.masksToBounds = YES;
    [bgView addSubview:_bankImageView];
    [self.bankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(10);
        make.top.equalTo(bgView).offset(10);
        make.width.mas_equalTo(kFit(50));
        make.height.mas_equalTo(kFit(50));
    }];

    
    //解绑
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitle:@"解绑" forState:(UIControlStateNormal)];
    self.cancelBtn.titleLabel.font = kFont(kFit(15));
    [self.cancelBtn addTarget:self action:@selector(deleteBankCard) forControlEvents:(UIControlEventTouchUpInside)];
    [self.cancelBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [bgView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-10);
        make.top.equalTo(bgView).offset(10);
        make.height.mas_equalTo(kFit(20));
        make.width.mas_equalTo(kFit(60));
    }];
    self.cancelBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.cancelBtn.layer.borderWidth = 1;
    
    //属于哪个银行
    self.bankLabel = [[UILabel alloc] init];
    self.bankLabel.textColor = [UIColor whiteColor];
    self.bankLabel.font = kFont(kFit(15));
    [bgView addSubview:self.bankLabel];
    [self.bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankImageView.mas_right).offset(10);
        make.right.equalTo(self.cancelBtn.mas_left).offset(-10);
        make.top.equalTo(bgView.mas_top).offset(10);
        make.height.mas_equalTo(kFit(25));
    }];
    
    //信用卡
    self.bankClassLabel = [[UILabel alloc] init];
    self.bankClassLabel.textColor = [UIColor whiteColor];
    self.bankClassLabel.text = @"信用卡";
    self.bankClassLabel.font = kFont(kFit(15));
    [bgView addSubview:self.bankClassLabel];
    [self.bankClassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankImageView.mas_right).offset(10);
        make.right.equalTo(self.cancelBtn.mas_left).offset(-10);
        make.top.equalTo(_bankLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(kFit(25));
    }];
    
    //卡号
    self.bankNumLabel = [[UILabel alloc] init];
    self.bankNumLabel.textColor = [UIColor whiteColor];
    self.bankNumLabel.font = kFont(kFit(20));
    [bgView addSubview:self.bankNumLabel];
    [self.bankNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankImageView.mas_right).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.bottom.equalTo(bgView).offset(-10);
        make.height.mas_equalTo(kFit(25));
    }];
    
}

- (void)setBankModel:(LHBankCardModel *)bankModel {
    self.bankNumLabel.text = bankModel.bank_no;
    self.bankImageView.backgroundColor = kRandomColor;
    self.bankLabel.text = @"******银行";
}

- (void)deleteBankCard {
    if (self.DeleteBlock) {
        self.DeleteBlock();
    }
}


@end


@implementation LHAddCardCell

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
    self.bgView = [[UIImageView alloc] init];
    self.bgView.image = [UIImage imageNamed:@"MyCenter_MyCard_BgView"];
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self).insets(UIEdgeInsetsMake(0, 10, 10, 10));
    }];
    self.addLabel = [[UILabel alloc] init];
    self.addLabel.textColor = [UIColor lightGrayColor];
    self.addLabel.text = @"添加新的信用卡";
    self.addLabel.font = kFont(kFit(18));
    [self.bgView addSubview:self.addLabel];
    [self.addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.bgView.center);
        make.height.mas_equalTo(50);
    }];
    
    self.addImageView = [[UIImageView alloc] init];
    self.addImageView.image = [UIImage imageNamed:@"MyCenter_MyCard_Add"];
    [self.bgView addSubview:self.addImageView];
    [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.addLabel.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.bgView.centerY);
        make.width.mas_equalTo(kFit(40));
        make.height.mas_equalTo(kFit(40));
    }];
}



@end




@implementation LHCheaperCardCell

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
    //黄色背景
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = kHexColorInt32_t(da9221);
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self).insets(UIEdgeInsetsMake(0, 10, 10, 10));
    }];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    
    //卡的类型
    self.cardClassLabel = [[UILabel alloc] init];
    self.cardClassLabel.textColor = [UIColor whiteColor];
    self.cardClassLabel.text = @"乐荟券";
    self.cardClassLabel.font = kFont(kFit(14));
    [bgView addSubview:self.cardClassLabel];
    [self.cardClassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(10);
        make.top.equalTo(bgView.mas_top).offset(10);
        make.height.mas_equalTo(kFit(20));
        make.width.mas_equalTo(kFit(50));
    }];
    
    //余额
    self.balanceRMBLabel = [[UILabel alloc] init];
    self.balanceRMBLabel.textColor = [UIColor whiteColor];
    self.balanceRMBLabel.textAlignment = NSTextAlignmentCenter;
    self.balanceRMBLabel.font = kFont(kFit(18));
    [bgView addSubview:self.balanceRMBLabel];
    [self.balanceRMBLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView.centerX);
        make.left.equalTo(bgView.mas_left).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.height.mas_equalTo(kFit(35));
        make.top.equalTo(self.cardClassLabel.mas_bottom).offset(5);
    }];
    
    //商品描述
    self.commentLabel = [[UILabel alloc] init];
    self.commentLabel.textColor = [UIColor whiteColor];
    self.commentLabel.textAlignment = NSTextAlignmentCenter;
    self.commentLabel.font = kFont(kFit(14));
    [bgView addSubview:self.commentLabel];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView.centerX);
        make.left.equalTo(bgView.mas_left).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.height.mas_equalTo(kFit(20));
        make.top.equalTo(self.balanceRMBLabel.mas_bottom).offset(5);
    }];

    //商品总额
    self.allRMBLabel = [[UILabel alloc] init];
    self.allRMBLabel.textColor = [UIColor whiteColor];
    self.allRMBLabel.font = kFont(kFit(14));
    [bgView addSubview:self.allRMBLabel];
    [self.allRMBLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(10);
        make.bottom.equalTo(bgView.mas_bottom).offset(-10);
        make.height.mas_equalTo(kFit(20));
        make.width.mas_equalTo(kFit(100));
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.font = kFont(kFit(14));
    self.timeLabel.textColor = [UIColor whiteColor];
    [bgView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.bottom.equalTo(bgView.mas_bottom).offset(-10);
        make.height.mas_equalTo(kFit(20));
        make.width.mas_equalTo(kFit(100));
    }];
}




@end



@implementation LHBillCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.billImageView = [[UIImageView alloc] init];
        self.billImageView.image = [UIImage imageNamed:@"MyCenter_MyCard_bill"];
        [self.contentView addSubview:self.billImageView];
        [self.billImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(12);
            make.bottom.equalTo(self.mas_bottom).offset(-12);
            make.width.equalTo(self.billImageView.mas_height).multipliedBy(1.0f);
        }];

        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = kFont(kFit(15));
        self.titleLabel.text = @"发票";
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.billImageView.mas_right).offset(10);
            make.top.equalTo(self.mas_top).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.width.mas_equalTo(kFit(100));
        }];
        
        UIImageView *openImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-20, 36/2, 8, 15)];
        openImageView.image = kImage(@"MyCenter_CardBox_OpenCell");
        [self.contentView addSubview:openImageView];
        
        
    }
    return self;
}



@end


























