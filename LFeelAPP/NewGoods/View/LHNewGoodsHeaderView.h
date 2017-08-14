//
//  LHNewGoodsHeaderView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickRightLabelBlock)();

@interface LHNewGoodsHeaderView : UIView

@property (nonatomic, copy) ClickRightLabelBlock clickLabelBlock;


- (void)clickRightLabelBlock:(ClickRightLabelBlock)block;


//新品
- (instancetype)initWithFrame:(CGRect)frame;



- (instancetype)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl title:(NSString *)title;



























@end
