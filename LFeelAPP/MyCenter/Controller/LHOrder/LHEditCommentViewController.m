//
//  LHEditCommentViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/27.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHEditCommentViewController.h"
#import "LHAddCommentView.h"


@interface LHEditCommentViewController ()


@end

@implementation LHEditCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setHBK_NavigationBar];
    
    
}

#pragma mark ---------------------  UI -------------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"评价" backAction:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    } rightFirst:@"发表" rightFirstBtnAction:^{
        
    }];
}
//- (void)






#pragma mark ------------------------ 网路请求 ---------------------











































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
