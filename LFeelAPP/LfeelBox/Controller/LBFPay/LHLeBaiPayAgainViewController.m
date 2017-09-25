//
//  LHLeBaiPayAgainViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/25.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHLeBaiPayAgainViewController.h"

@interface LHLeBaiPayAgainViewController ()

@end

@implementation LHLeBaiPayAgainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setHBK_NavigationBar];
}
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"填写信用卡信息" backAction:^{
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
