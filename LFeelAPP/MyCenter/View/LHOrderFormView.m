//
//  LHOrderFormView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHOrderFormView.h"
#define kOrderAboutBtnTag                5000
@implementation LHOrderFormView



- (instancetype)initWithFrame:(CGRect)frame imageNameArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray {
    if (self = [super initWithFrame:frame]) {
        CGFloat margin = ((kScreenWidth/4)-kFit(35))/2;
        for (int i = 0; i < titleArray.count; i++) {
            
            CustomButton *button = [[CustomButton alloc] initWithFrame:CGRectMake(margin*(i*2+1) + i*kFit(35), (frame.size.height-kFit(55))/2, kFit(35), kFit(55)) imageFrame:CGRectMake(0, 0, kFit(35), kFit(35)) imageName:imageArray[i] titleLabelFrame:CGRectMake(0, kFit(35), kFit(35), kFit(20)) title:titleArray[i] titleColor:[UIColor blackColor] titleFont:kFit(11)];
            button.tag = kOrderAboutBtnTag + i;
            button.badgeBGColor = [UIColor redColor];
            button.badgeTextColor = [UIColor whiteColor];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [self addSubview:button];
            
        }
    }
    return self;
}


#pragma mark   --------- button 点击事件
- (void)buttonClick:(UIButton *)sender {
    if (self.customBtnBlock) {
        self.customBtnBlock(sender.tag-kOrderAboutBtnTag);
    }
}


//block方法回调
- (void)clickCustomButton:(CustomButtonBlock)customBtnBlock {
    self.customBtnBlock = customBtnBlock;
}


@end
