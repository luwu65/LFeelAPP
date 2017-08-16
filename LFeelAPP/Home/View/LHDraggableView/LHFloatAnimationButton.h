//
//  LHFloatAnimationButton.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/16.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHFloatAnimationButton : UIButton


@property (nonatomic, assign) CGFloat maxLeft; /* 最大向左漂浮 默认 30 */
@property (nonatomic, assign) CGFloat maxRight; /* 最大向右漂浮 默认 25 */
@property (nonatomic, assign) CGFloat maxHeight; /* 最大漂浮高度 默认 320 */
@property (nonatomic, assign) CGFloat duration; /* 漂浮时长  默认 6 */
@property (nonatomic, strong) NSArray * images; /* 漂浮图片的数组 */


/* 启动随机动画 */
- (void) startRandom;





@end
