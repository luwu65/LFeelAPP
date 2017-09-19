//
//  LHWelcomeViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/19.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHWelcomeViewController.h"
#import "LHTabBarViewController.h"
#import "AppDelegate.h"
@interface LHWelcomeViewController ()

@end

@implementation LHWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
}

/// 初始化view
- (void)setupSubViews {
    
    UIScrollView * scrollView = [UIScrollView scrollViewWithBgColor:[UIColor whiteColor] frame:self.view.bounds];
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    NSInteger count = 4;
    for (int i = 0; i < count; i++) {
        NSString * name = [NSString stringWithFormat:@"HomeClean_0%d", i + 1];
        UIImageView * imageView = [UIImageView imageViewWithImage:[UIImage imageNamed:name] frame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        [scrollView addSubview:imageView];
        if (i == count -1) {
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
            [imageView addGestureRecognizer:tap];
        }
    }
    scrollView.contentSize = CGSizeMake(kScreenWidth * 4, 0);
    
    
}

- (void)tapAction {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(NO) forKey:@"_isFirstLaunchApp"];
    [defaults synchronize];
    
    LHTabBarViewController * main = [[LHTabBarViewController alloc] init];
    self.view.window.rootViewController = main;
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate setupScreenView];
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
