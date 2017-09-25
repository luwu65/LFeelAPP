//
//  LHPayResultsViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/18.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHPayResultsViewController.h"

@interface LHPayResultsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@end

@implementation LHPayResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setHBK_NavigationBar];
    [self judgePayStatus];
}
#pragma mark ---------------- UI ----------------------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"支付结果" leftFirst:@"Back_Button" leftFirstAction:^{
        NSLog(@"返回");
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

#pragma mark ---------------- Action -----------------
- (void)judgePayStatus {
    if (self.payType == 0) {
        if ([self.payResultStr isEqualToString:@"0000"]) {
            self.resultImageView.image = kImage(@"MyBox_Pay_Success");
            self.resultsLabel.text = @"支付成功! 您的订单会尽快进行处理!";
            [self.leftBtn setTitle:@"继续购物" forState:(UIControlStateNormal)];
        } else {
            self.resultImageView.image = kImage(@"MyBox_Pay_Fail");
            self.resultsLabel.text = @"支付失败! 请重新支付!";
            [self.leftBtn setTitle:@"重新支付" forState:(UIControlStateNormal)];
            [self.leftBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view).offset(20);
                make.right.equalTo(self.view).offset(-20);
                make.bottom.equalTo(self.view).offset(-20);
                make.height.mas_equalTo(50);
            }];
            [self.rightBtn removeFromSuperview];
        }
    } else if (self.payType == 1) {
        if ([self.payResultStr isEqualToString:@"9000"]) {
            self.resultImageView.image = kImage(@"MyBox_Pay_Success");
            self.resultsLabel.text = @"支付成功! 您的订单会尽快进行处理!";
            [self.leftBtn setTitle:@"继续购物" forState:(UIControlStateNormal)];
        } else {
            self.resultImageView.image = kImage(@"MyBox_Pay_Fail");
            self.resultsLabel.text = @"支付失败! 请重新支付!";
            [self.leftBtn setTitle:@"重新支付" forState:(UIControlStateNormal)];
            [self.leftBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view).offset(20);
                make.right.equalTo(self.view).offset(-20);
                make.bottom.equalTo(self.view).offset(-20);
                make.height.mas_equalTo(50);
            }];
            [self.rightBtn removeFromSuperview];
        }
    } else if (self.payType == 2) {
        
        
        
    } else if (self.payType == 3) {
        
        
    }
}


//继续购物/重新支付
- (IBAction)leftBtn:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"继续购物"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else if ([sender.titleLabel.text isEqualToString:@"重新支付"]) {
        
        
    }
}
//查看订单
- (IBAction)rightBtn:(UIButton *)sender {
    
    
    
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
