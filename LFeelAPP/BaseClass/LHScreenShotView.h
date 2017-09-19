//
//  LHScreenShotView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/19.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHScreenShotView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) NSMutableArray *imageArray;

- (void)showEffectChange:(CGPoint)pt;
- (void)restore;
- (void)screenShot;


@end
