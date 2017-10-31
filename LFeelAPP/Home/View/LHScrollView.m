//
//  LHScrollView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/16.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHScrollView.h"
#define kHeaderViewHeight    kFit(250)
@implementation LHScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray {
    if (self = [super initWithFrame:frame]) {
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.contentSize = CGSizeMake(kScreenWidth, (kScreenHeight-kNavBarHeight-kIPhoneXBottomHeight)*(imageArray.count));
        for (int i = 0; i < imageArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageArray[i]]];
            imageView.frame = CGRectMake(0, i*(kScreenHeight-kNavBarHeight-kIPhoneXBottomHeight), kScreenWidth, kScreenHeight-kNavBarHeight-kIPhoneXBottomHeight);
            [self addSubview:imageView];
        }
    }
    return self;
}



- (instancetype)initWithFrame:(CGRect)frame imageRadio:(CGFloat)imageRadio imageName:(NSString *)imageName{
    if (self = [super initWithFrame:frame]) {
        self.showsVerticalScrollIndicator = YES;
        self.contentSize = CGSizeMake(kScreenWidth, kScreenWidth*imageRadio);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*imageRadio)];
        imageView.image = [UIImage imageNamed:imageName];
        [self addSubview:imageView];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = NO;
    }
    return self;
}


- (void)setOffset:(CGPoint)offset {
    _offset = offset;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    BOOL hitHead = point.y < (kHeaderViewHeight - self.offset.y);
    if (hitHead || !view) {
        self.scrollEnabled = NO;
        if (!view) {
            for (UIView* subView in self.subviews) {
                if (subView.frame.origin.x == self.contentOffset.x) {
                    view = subView;
                }
            }
        }
        return view;
    } else {
        self.scrollEnabled = YES;
        return view;
    }
}






@end
