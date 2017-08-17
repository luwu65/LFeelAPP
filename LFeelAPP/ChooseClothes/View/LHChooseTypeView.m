//
//  LHChooseTypeView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/17.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHChooseTypeView.h"

@implementation LHChooseTypeView



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        for (int i = 0; i < 5; i++) {
            LHDevider *devider = [[LHDevider alloc] initWithFrame:CGRectMake(0, i*kFit(40) + kFit(40), kScreenWidth, 0.5)];
            [self addSubview:devider];
        }
        
        
        
    }
    return self;
}









@end
