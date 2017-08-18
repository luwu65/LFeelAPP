//
//  LHTagView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/17.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHTagView : UIView


@property (nonatomic, strong) UIScrollView *tagScrollView;
@property (nonatomic, strong) UIView *contentView;


@property (nonatomic, copy) void (^ClickTagBlock)(NSInteger index);


/**
 只显示文字的标签

 @param frame 尺寸
 @param txtArray 文字的数组
 @return 标签视图
 */
- (instancetype)initWithFrame:(CGRect)frame TxtArray:(NSArray *)txtArray;


/**
 显示颜色的标签

 @param frame 尺寸
 @param colorArray 颜色的数组
 @return 标签视图
 */
- (instancetype)initWithFrame:(CGRect)frame ColorArray:(NSArray *)colorArray;







@end
























