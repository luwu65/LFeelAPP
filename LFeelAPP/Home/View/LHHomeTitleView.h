//
//  LHHomeTitleView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHHomeTitleView : UIView

@property (nonatomic, strong) UILabel *chineseLabel;//显示汉字的label

@property (nonatomic, strong) UILabel *englishLael; //显示英文的label

@property (nonatomic, strong) UIColor *chineseColor;//汉字的颜色

@property (nonatomic, strong) UIColor *englishColor;//英文的颜色


/**
 没个cell上的title  英文和中文

 @param frame 尺寸
 @param chinese 中文标题
 @param chineseFont 中午字体的大小
 @param english 英文字体
 @param englishFont 英文字体的大小
 */
- (instancetype)initWithFrame:(CGRect)frame chinese:(NSString *)chinese chineseFont:(NSInteger)chineseFont english:(NSString *)english englishFont:(NSInteger)englishFont;
























@end
