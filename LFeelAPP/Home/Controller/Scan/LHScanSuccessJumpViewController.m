//
//  LHScanSuccessJumpViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/18.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHScanSuccessJumpViewController.h"

@interface LHScanSuccessJumpViewController ()

@end

@implementation LHScanSuccessJumpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.jump_bar_code) {
        [self showAlertViewWithTitle:self.jump_bar_code];
    } else {
        [self showAlertViewWithTitle:self.jump_URL];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setHBK_NavigationBar];
}

- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"扫描结果" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
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
