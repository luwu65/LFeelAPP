//
//  LHImageView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/29.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHImageView.h"

@implementation LHImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        
        [self setDeleteButtonWithFrame:frame];
        
    }
    return self;
}


- (void)setDeleteButtonWithFrame:(CGRect)frame {
    self.deleteButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    self.deleteButton.backgroundColor = [UIColor redColor];
    [self.deleteButton setImage:kImage(@"Order_deleteImage") forState:(UIControlStateNormal)];
    self.deleteButton.frame = CGRectMake(frame.size.width-10, -10, 20, 20);
    self.deleteButton.layer.cornerRadius = 10;
    self.deleteButton.layer.masksToBounds = YES;
    [self addSubview:self.deleteButton];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-kFit(15)-kFit(20), frame.size.width, kFit(15))];
//    self.titleLabel.text = @"0/3";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.titleLabel];
    
}











@end
