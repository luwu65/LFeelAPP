//
//  LHGoodsCommentCell.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/27.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHGoodsCommentCell.h"

@implementation LHGoodsCommentCell

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
        
    }
    return self;
}



- (void)setUINoComent {
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.text = @"暂时没有评价";
    detailLabel.textColor = [UIColor lightGrayColor];
    detailLabel.font = kFont(kFit(15));
    [self addSubview:detailLabel];
    
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_offset(50);
    }];
}

- (void)setUIWithComment {
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.backgroundColor = [UIColor redColor];
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(kFit(15));
        make.width.mas_equalTo(kFit(40));
        make.height.mas_equalTo(kFit(40));
    }];
    self.iconImageView.layer.cornerRadius = kFit(40)/2;
    self.iconImageView.layer.masksToBounds = YES;

    
    self.userNameLabel = [[UILabel alloc] init];
    self.userNameLabel.font = kFont(kFit(12));
    [self addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.mas_top).offset(kFit(15));
        make.height.mas_equalTo(kFit(15));
    }];
    
    self.heightLabel = [[UILabel alloc] init];
    self.heightLabel.font = kFont(kFit(10));
//    self.heightLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.heightLabel];
    [self.heightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(kFit(15));
        make.width.mas_equalTo(60);
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kFit(15));
        make.width.mas_equalTo(1);
        make.left.equalTo(self.heightLabel.mas_right).offset(2);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(5);
    }];

    self.sizeLabel = [[UILabel alloc] init];
    self.sizeLabel.textAlignment = NSTextAlignmentCenter;
    self.sizeLabel.font = kFont(kFit(10));
    [self addSubview:self.sizeLabel];
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView1.mas_right).offset(2);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(kFit(15));
        make.width.mas_equalTo(50);
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kFit(15));
        make.width.mas_equalTo(1);
        make.left.equalTo(self.sizeLabel.mas_right).offset(2);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(5);
    }];

    self.buySizeLabel = [[UILabel alloc] init];
    self.buySizeLabel.font = kFont(kFit(10));
    self.buySizeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.buySizeLabel];
    [self.buySizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView2.mas_right).offset(2);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(kFit(15));
        make.width.mas_equalTo(50);
    }];

    
    self.photoGroupView = [[LHPhotoGroupView alloc] initWithWidth:kScreenWidth-kFit(40)-30];
    self.photoGroupView.backgroundColor = [UIColor greenColor];
    [self addSubview:self.photoGroupView];
    [self.photoGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.height.mas_equalTo(0);
    }];
    
    self.commentLabel = [[UILabel alloc] init];
    self.commentLabel.font = kFont(12);
    self.commentLabel.numberOfLines = 0;
    self.commentLabel.backgroundColor = [UIColor redColor];
    [self addSubview:self.commentLabel];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(0);
    }];
}






//重新布局cell
- (void)adjustCellWithString:(NSString *)string {
    //改变contentLabel的frame
    CGRect labelFrame = self.commentLabel.frame;
    labelFrame.size.height = [LHGoodsCommentCell labelHeightWithString:string];
    [self.commentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(labelFrame.size.height);
    }];
}

//重新计算label高度
+ (CGFloat)labelHeightWithString:(NSString *)string {
    //根据内容计算label的高度
    //注意: 字典的字体要和label的字体一致, 给定的尺寸宽度要和label的宽度一致
    CGRect rect = [string boundingRectWithSize:CGSizeMake(kScreenWidth - 30 - kFit(40), MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    return rect.size.height + 5;
}

+ (CGFloat)cellHeightWithString:(NSString *)string {
    return kFit(70) + [LHGoodsCommentCell labelHeightWithString:string] + (kScreenWidth-40-kFit(40))/3;
}


@end
