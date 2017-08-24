//
//  LHTitleSliderView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/24.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHTitleSliderView : UIView
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, copy) void (^buttonSelected)(NSInteger index);

@end
