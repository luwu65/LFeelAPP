//
//  LHEditCommentCell.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/29.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHEditCommentCell.h"

@implementation LHEditCommentCell

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
    self.goodsImageView = [[UIImageView alloc] init];
    self.goodsImageView.frame = CGRectMake(kFit(10), kFit(10), kFit(80), kFit(80));
    self.goodsImageView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.goodsImageView];
    
    self.textView = [[HBKTextView alloc] initWithFrame:CGRectMake(self.goodsImageView.maxX+10, 10, kScreenWidth-kFit(110), kFit(120))];
    self.textView.placeHolder = @"亲! 说说你的使用心得, 分享给他们吧!";
    self.textView.font = kFont(kFit(14));
    self.textView.layer.borderWidth = 0;
    self.textView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.contentView addSubview:self.textView];
    
    
    self.firstImageView = [[LHImageView alloc] initWithFrame:CGRectMake(kFit(10), self.textView.maxY+kFit(10), (kScreenWidth-kFit(40))/3, (kScreenWidth-kFit(40))/3)];
    self.firstImageView.deleteButton.hidden = YES;
    self.firstImageView.image = kImage(@"Order_AddImage");
    [self.contentView addSubview:self.firstImageView];
    
    
    self.secondImageView = [[LHImageView alloc] initWithFrame:CGRectMake(kFit(10), self.textView.maxY+kFit(10), (kScreenWidth-kFit(40))/3, (kScreenWidth-kFit(40))/3)];
    self.secondImageView.deleteButton.hidden = YES;
    self.secondImageView.image = kImage(@"Order_AddImage");
    [self.contentView addSubview:self.secondImageView];
    
    self.addImageView = [[LHImageView alloc] initWithFrame:CGRectMake(kFit(10), self.textView.maxY+kFit(10), (kScreenWidth-kFit(40))/3, (kScreenWidth-kFit(40))/3)];
    self.addImageView.deleteButton.hidden = YES;
    self.addImageView.image = kImage(@"Order_AddImage");
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)];
    [self.addImageView addGestureRecognizer:tap];
    [self.contentView addSubview:self.addImageView];
}


- (void)tapImageView {
//    NSLog(@"点击了");
    if (self.SelectImageBlock) {
        self.SelectImageBlock();
    }
}



























@end
