//
//  LHNavigationViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHNavigationViewController.h"
#import "LHUserInfoViewController.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "AppDelegate.h"
#import "LHPayResultsViewController.h"
#import "LHPackSuccessViewController.h"
#import "LHMyBoxViewController.h"
#import "LHLeBaiViewController.h"

static CGFloat kDistance = 80.0f;



@interface LHNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation LHNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.hidden = YES;
    
    self.screenShotArray = [NSMutableArray array];
    
    self.gestureRecognizerEnabled = YES;
    self.fd_fullscreenPopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.enabled = NO;
    self.fd_fullscreenPopGestureRecognizer.delegate = self;

    [self.fd_fullscreenPopGestureRecognizer addTarget:self action:@selector(panGesIng:)];
    self.fd_fullscreenPopGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.fd_fullscreenPopGestureRecognizer];
    
}

- (void)panGesIng:(UIPanGestureRecognizer *)panGes {
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *rootVC = appdelegate.window.rootViewController;
    UIViewController *presentedVC = rootVC.presentedViewController;
    if (self.viewControllers.count == 1) {
        return;
    }
    
    if (panGes.state == UIGestureRecognizerStateBegan) {
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        appdelegate.screenShotView.hidden = NO;
        
    } else if (panGes.state == UIGestureRecognizerStateChanged) {
        CGPoint pt = [panGes translationInView:self.view];
        
        if (pt.x >= 10) {
            rootVC.view.transform = CGAffineTransformMakeTranslation(pt.x - 10, 0);
            presentedVC.view.transform = CGAffineTransformMakeTranslation(pt.x - 10, 0);
        }
    } else if (panGes.state == UIGestureRecognizerStateEnded) {
        CGPoint pt = [panGes translationInView:self.view];
        if (pt.x >= kDistance)
        {
            [UIView animateWithDuration:0.15 animations:^{
                rootVC.view.transform = CGAffineTransformMakeTranslation(kScreenWidth, 0);
                presentedVC.view.transform = CGAffineTransformMakeTranslation(kScreenWidth, 0);
            } completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];
                rootVC.view.transform = CGAffineTransformIdentity;
                presentedVC.view.transform = CGAffineTransformIdentity;
                appdelegate.screenShotView.hidden = YES;
                
            }];
        } else {
            [UIView animateWithDuration:0.15 animations:^{
                rootVC.view.transform = CGAffineTransformIdentity;
                presentedVC.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                appdelegate.screenShotView.hidden = YES;
                
            }];
        }
    }
}

- (void)setGestureRecognizerEnabled:(BOOL)gestureRecognizerEnabled {
    _gestureRecognizerEnabled = gestureRecognizerEnabled;
    self.fd_fullscreenPopGestureRecognizer.enabled = gestureRecognizerEnabled;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if ([viewController isKindOfClass:[LHUserInfoViewController class]] || [viewController isKindOfClass:[LHPayResultsViewController class]] || [viewController isKindOfClass:[LHPackSuccessViewController class]] || [viewController isKindOfClass:[LHMyBoxViewController class]] || [viewController isKindOfClass:[LHLeBaiViewController class]]) {
        self.gestureRecognizerEnabled = NO;
        
    } else {
        self.gestureRecognizerEnabled = YES;
    }
    
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(appdelegate.window.size.width, appdelegate.window.size.height), YES, 0);
    [appdelegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.screenShotArray addObject:viewImage];
    appdelegate.screenShotView.imageView.image = viewImage;
    
    [super pushViewController:viewController animated:animated];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        self.viewControllers = @[rootViewController];
        
    }
    return self;
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.screenShotArray removeLastObject];
    UIImage *image = [self.screenShotArray lastObject];
    
    if (image) {
        appdelegate.screenShotView.imageView.image = image;
    }
    
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (self.screenShotArray.count > 2) {
        [self.screenShotArray removeObjectsInRange:NSMakeRange(1, self.screenShotArray.count - 1)];
    }
    UIImage *image = [self.screenShotArray lastObject];
    if (image) {
        appdelegate.screenShotView.imageView.image = image;
    }
    return [super popToRootViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSArray *arr = [super popToViewController:viewController animated:animated];
    
    if (self.screenShotArray.count > arr.count) {
        for (int i = 0; i < arr.count; i++) {
            [self.screenShotArray removeLastObject];
        }
        UIImage *image = [self.screenShotArray lastObject];
        if (image) {
            AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            appdelegate.screenShotView.imageView.image = image;
        }
    }
    return arr;
}

//防止手势冲突——防止UITableView的点击事件和手势事件冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 输出点击的view的类名
    // NSLog(@"%@", NSStringFromClass([touch.view class]));
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
