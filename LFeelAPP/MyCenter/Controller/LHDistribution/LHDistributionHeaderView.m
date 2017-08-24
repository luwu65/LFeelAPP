//
//  LHDistributionView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/24.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHDistributionHeaderView.h"

@implementation LHDistributionHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)awakeFromNib {
    [super awakeFromNib];
    [self rm_fitAllConstraint];
    
}

+ (instancetype)creatView {
    return [self creatViewFromNibName:@"LHDistributionHeaderView" atIndex:0];
}






















@end
