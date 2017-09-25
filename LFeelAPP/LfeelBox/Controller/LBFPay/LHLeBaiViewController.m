//
//  LHLeBaiViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHLeBaiViewController.h"
#import "LHLeBaiView.h"

@interface LHLeBaiViewController ()

@end

@implementation LHLeBaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


///  初始化子控件
- (void)setupSubViews {
    
    UIScrollView * scrollView = [UIScrollView defaultScrollView];
    [self.view addSubview:scrollView];
    
    LHLeBaiView * payView = [LHLeBaiView creatViewFromNib];
//    payView.price = self.payModel.price;
//    payView.frame = Rect(0, 0, kScreenWidth, Fit(payView.height));
    [scrollView addSubview:payView];
    
    
    
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
