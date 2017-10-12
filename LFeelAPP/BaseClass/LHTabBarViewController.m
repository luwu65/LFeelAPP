//
//  LHTabBarViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHTabBarViewController.h"
#import "LHHomeViewController.h"
#import "LHMyBoxViewController.h"
#import "LHNewGoodsViewController.h"
#import "LHMyCenterViewController.h"
#import "LHNavigationViewController.h"
//#import "LHLoginViewController.h"
#import "LHCaptchaLoginViewController.h"
#import "LHChooseClothesViewController.h"
@interface LHTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation LHTabBarViewController
- (instancetype)init {
    if (self = [super init]) {
        [self setFourViewController];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}
- (void)setFourViewController {
    LHHomeViewController *boxVC = [[LHHomeViewController alloc] init];
    LHNavigationViewController *boxNav = [self setChildController:boxVC title:@"首页" defineImageName:@"Home_default" clickImageName:@"Home_default_click"];
    
    LHChooseClothesViewController *chooseVC = [[LHChooseClothesViewController alloc] init];
    LHNavigationViewController *chooseNav = [self setChildController:chooseVC title:@"选衣" defineImageName:@"ChooseClothes_default" clickImageName:@"ChooseClothes_click"];
    
    LHMyBoxViewController *myBoxVC = [[LHMyBoxViewController alloc] init];
    LHNavigationViewController *myBoxNav = [self setChildController:myBoxVC title:@"乐荟盒子" defineImageName:@"ShoppingCart_default" clickImageName:@"ShoppingCart_default_click"];
    
    LHNewGoodsViewController *newsVC = [[LHNewGoodsViewController alloc] init];
    LHNavigationViewController *newNav = [self setChildController:newsVC title:@"新品" defineImageName:@"NewGoods_default" clickImageName:@"NewGoods_default_click"];

    LHMyCenterViewController *myCenterVC = [[LHMyCenterViewController alloc] init];
    LHNavigationViewController *myCenterNav = [self setChildController:myCenterVC title:@"我的" defineImageName:@"MyCenter_default" clickImageName:@"MyCenter_default_click"];

    self.viewControllers = @[boxNav, chooseNav, myBoxNav, newNav, myCenterNav];
}

- (LHNavigationViewController *)setChildController:(UIViewController *)childController title:(NSString *)title defineImageName:(NSString *)defineImageName clickImageName:(NSString *)clickImageName {
    childController.title = title;
    childController.tabBarItem.image  = [UIImage imageNamed:defineImageName];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:clickImageName];    
    childController.tabBarController.tabBar.tintColor = [UIColor redColor];
    self.tabBar.tintColor = [UIColor redColor];    
    LHNavigationViewController *nav = [[LHNavigationViewController alloc]initWithRootViewController:childController];
    
    return nav;
}



- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([viewController.tabBarItem.title isEqualToString:@"乐荟盒子"] || [viewController.tabBarItem.title isEqualToString:@"我的"]) {
        if (![LHUserInfoManager isLoad]) {
            LHCaptchaLoginViewController *loginVC = [[LHCaptchaLoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];            
            return NO;
        } else {
            return YES;
        }
    } else {
        return YES;
    }
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
