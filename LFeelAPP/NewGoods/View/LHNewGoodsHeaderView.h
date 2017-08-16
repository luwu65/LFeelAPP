//
//  LHNewGoodsHeaderView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHNewGoodsModel.h"

typedef void(^ClickRightLabelBlock)();

@interface LHNewGoodsHeaderView : UIView

@property (nonatomic, copy) ClickRightLabelBlock clickLabelBlock;


- (void)clickRightLabelBlock:(ClickRightLabelBlock)block;


//新品
- (instancetype)initWithFrame:(CGRect)frame;


@end



@interface LHNewGoodsCategoryHeaderView : UIView


@property (nonatomic, strong) UIImageView *categoryImageView;

@property (nonatomic, strong) UILabel *categoryNameLabel;

- (instancetype)initWithFrame:(CGRect)frame;


@property (nonatomic, strong) LHCategoryListModel *model;

@end






















