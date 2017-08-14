//
//  LHGoodsCommentCell.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/27.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHPhotoGroupView.h"

//typedef void(^ClickAllCommentBlock)();

@interface LHGoodsCommentCell : UITableViewCell




@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *heightLabel;
@property (nonatomic, strong) UILabel *sizeLabel;
@property (nonatomic, strong) UILabel *buySizeLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) LHPhotoGroupView *photoGroupView;



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


- (void)setUINoComent;
- (void)setUIWithComment;

+ (CGFloat)cellHeightWithString:(NSString *)string;
- (void)adjustCellWithString:(NSString *)string;


@end
