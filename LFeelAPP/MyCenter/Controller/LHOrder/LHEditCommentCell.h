//
//  LHEditCommentCell.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/29.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHImageView.h"

@interface LHEditCommentCell : UITableViewCell




@property (nonatomic, strong) LHImageView *addImageView;

@property (nonatomic, strong) LHImageView *firstImageView;
@property (nonatomic, strong) LHImageView *secondImageView;


@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) HBKTextView *textView;
@property (nonatomic, copy) void (^SelectImageBlock)();








































@end
