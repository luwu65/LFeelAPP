//
//  LHSendBackViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHSendBackViewController.h"
#import "LHScanViewController.h"


@interface LHSendBackViewController ()
/*新名*/
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
/*电话*/
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
/*快递单号*/
@property (weak, nonatomic) IBOutlet UITextField *expressNumTF;
/*备注*/
@property (weak, nonatomic) IBOutlet UITextField *remarkTF;

@property (nonatomic, copy) NSString *number;

@property (weak, nonatomic) IBOutlet UIButton *numberBtn;

@end

@implementation LHSendBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view rm_fitAllConstraint];
    [self setHBK_NavigationBar];
}
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    @weakify(self);
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"寄回盒子" backAction:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    } rightFirst:@"Home_Camera" rightFirstBtnAction:^{
        LHScanViewController *scanVC = [[LHScanViewController alloc] init];
        scanVC.controller_ID = @"LHSendBackViewController";
        scanVC.ScanContentBlock = ^(NSString *content) {
            NSLog(@"%@", content);
            [self.numberBtn setTitle:content forState:(UIControlStateNormal)];
            [self.numberBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        };
        [self.navigationController pushViewController:scanVC animated:YES];
    }];
}

//选择数量
- (IBAction)sendBackCountAction:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    [alert addAction:[UIAlertAction actionWithTitle:@"寄回 1 件" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.number = @"1";
        [sender setTitle:@"寄回 1 件" forState:(UIControlStateNormal)];
        sender.titleColor = [UIColor blackColor];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"寄回 2 件" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.number = @"2";
        [sender setTitle:@"寄回 2 件" forState:(UIControlStateNormal)];
        sender.titleColor = [UIColor blackColor];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"寄回 3 件" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.number = @"3";
        [sender setTitle:@"寄回 3 件" forState:(UIControlStateNormal)];
        sender.titleColor = [UIColor blackColor];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

//提交
- (IBAction)submitAction:(UIButton *)sender {
    

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
