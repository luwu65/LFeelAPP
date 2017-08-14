//
//  LHMyCenterHeaderView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/16.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickIconBlock)();
@interface LHMyCenterHeaderView : UIView

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIButton *nameButton;
@property (nonatomic, strong) UIImageView *bgImageView;//背景图

- (instancetype)initWithFrame:(CGRect)frame;


@property (nonatomic, copy) ClickIconBlock clickIconBlock;



- (void)clickIconBlock:(ClickIconBlock)block;




















@end
