//
//  LHSendBackViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHSendBackViewController.h"
#import "LHScanViewController.h"
#import "LHPackSuccessViewController.h"

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
    
    [self configureData];
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
            self.expressNumTF.text = content;
        };
        [self.navigationController pushViewController:scanVC animated:YES];
    }];
}

#pragma mark ------------------------------ Aciton ------------------------
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
    kVerifyText(self.nameTF.text.length, @"请输入姓名");
    kVerifyText(self.phoneTF.text, @"请输入正确的电话号码");
    if ([self.numberBtn.titleLabel.text isEqualToString:@"数量"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showError:@"请选择寄回数量"];
        });
    } else {
        
        [self requestPackingBoxData];
        
    }

}

#pragma mrak  ------------------- 网络请求 ------------------------

//寄回盒子
- (void)requestPackingBoxData {
    //0普通订单 1提现申请 2打包盒子 3寄回盒子
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showProgressHUDWithTitle:@"提交中..."];
    });
    [LHNetworkManager PostWithUrl:kPackingBoxUrl parameter:@{@"expressCode": self.expressNumTF.text, @"type":@3, @"user_id":kUser_id, @"remark": [NSString stringWithFormat:@"姓名:%@,电话:%@,寄回数量:%@,备注:%@", self.nameTF.text, self.phoneTF.text, self.numberBtn.titleLabel.text, self.remarkTF.text]} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideProgressHUD];
                [MBProgressHUD showSuccess:@"提交成功"];
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                LHPackSuccessViewController *packSuccessVC = [[LHPackSuccessViewController alloc] init];
                packSuccessVC.Controller_ID = @"LHSendBackViewController";
                [self.navigationController pushViewController:packSuccessVC animated:YES];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideProgressHUD];
                [MBProgressHUD showError:reponseObject[@"errorDesc"]];
            });
        }
    } failure:^(NSError *error) {
        
        
    }];
}


- (void)configureData {
    LHUserInfoModel *model = [LHUserInfoManager getUserInfo];
    self.nameTF.text = model.real_name;
    self.phoneTF.text = model.mobile;
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
