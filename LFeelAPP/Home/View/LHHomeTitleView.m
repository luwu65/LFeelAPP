//
//  LHHomeTitleView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHHomeTitleView.h"

@implementation LHHomeTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame chinese:(NSString *)chinese chineseFont:(NSInteger)chineseFont english:(NSString *)english englishFont:(NSInteger)englishFont {
    if (self = [super initWithFrame:frame]) {
        _chineseLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, (self.frame.size.height-15)/2)];
        _chineseLabel.text = chinese;
        _chineseLabel.font = kFont(chineseFont * kRatio);
        [self addSubview:_chineseLabel];
        
        _englishLael = [[UILabel alloc] initWithFrame:CGRectMake(5, (self.frame.size.height-10)/2 + 5, self.frame.size.width-10, (self.frame.size.height-15)/2)];
        _englishLael.text = english;
        _englishLael.font = kFont(englishFont * kRatio);
        [self addSubview:_englishLael];
    }
    return self;
}




@end
