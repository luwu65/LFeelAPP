//
//  LHPackInfoView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHPackInfoView.h"

@implementation LHPackInfoView

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
    return [self creatViewFromNibName:@"LHPackInfoView" atIndex:0];
}
/*
 衣服
 */
- (IBAction)clothesBtn:(UIButton *)sender {
    
}

/*
 鞋子
 */
- (IBAction)shoesBtn:(UIButton *)sender {
    
}
/*
 包包
 */
- (IBAction)bagBtn:(UIButton *)sender {
    
}
/*
 鞋子
 */
- (IBAction)accBtn:(UIButton *)sender {
    
}





@end














