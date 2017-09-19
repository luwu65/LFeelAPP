//
//  AppDelegate.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHScreenShotView.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

///  main
//@property (nonatomic, strong) MainViewController * mainViewController;

+ (AppDelegate *)sharedDelegate;
/// 截屏view
@property (nonatomic, strong) LHScreenShotView * screenShotView;

/// 添加监听
- (void)lh_addObserver;
/// 移除监听
- (void)lh_removeObserver;

///  截屏view
- (void)setupScreenView;


///  <#Description#>
@property (nonatomic, assign) NSInteger flagIndex;



@end

