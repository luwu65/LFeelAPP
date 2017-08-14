//
//  LHDevider.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/14.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHDevider : UIView
///  分隔线颜色 默认（222, 223, 224）
@property (nonatomic, strong) UIColor *deviderColor;
///  分隔线颜色 默认0.5 最大为1
@property (nonatomic, assign) CGFloat deviderHeigth;
@end
