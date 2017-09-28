//
//  LHLeBaiPayViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/25.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHLeBaiPayViewController.h"
#import "LHPayResultsViewController.h"
@interface LHLeBaiPayViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *IDCardTF;
@property (weak, nonatomic) IBOutlet UITextField *bankCardTF;
@property (weak, nonatomic) IBOutlet UITextField *mouthTF;
@property (weak, nonatomic) IBOutlet UITextField *yearTF;
@property (weak, nonatomic) IBOutlet UITextField *CVN2TF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *smsCodeTF;
@property (weak, nonatomic) IBOutlet UITextView *remarkTV;

@end

@implementation LHLeBaiPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setHBK_NavigationBar];
    
    self.nameTF.text = @"王丹";
    self.IDCardTF.text = @"330900198809187126";
    self.bankCardTF.text = @"370248192322610";
    self.mouthTF.text = @"08";
    self.yearTF.text = @"22";
    self.CVN2TF.text = @"167";
    self.phoneTF.text = @"13298368875";
    self.smsCodeTF.text = @"888667";
    
    
}


#pragma mark -------------------------- UI ----------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"填写信用卡信息" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
#pragma mark -------------------------- Action -----------------
//确认分期
- (IBAction)submitInstalment:(UIButton *)sender {
    kVerifyText(self.nameTF.text.length, @"请输入姓名");
    kIDCard(self.IDCardTF.text, @"请输入正确身份证号码");
    kVerifyText(self.bankCardTF.text.length, @"请输入信用卡号");
    kVerifyText(self.mouthTF.text.length, @"请输入月份");
    kVerifyText(self.yearTF.text.length, @"请输入年份");
    kVerifyText(self.CVN2TF.text.length, @"请输入CVN2码");
    kVerifyText(self.phoneTF.text.length, @"请输入手机号");
    kVerifyText(self.smsCodeTF.text.length, @"请输入手机验证码");
    
    [self requestLebaiPayData];

}

//发送验证码
- (IBAction)sendSmsCode:(UIButton *)sender {
    kVerifyPhone(self.phoneTF.text, @"请输入手机号");
    [self requestSmsCodeData];
}

#pragma mark ------------------------ 网络请求 ---------------------
- (void)requestSmsCodeData {
    [LHNetworkManager requestForGetWithUrl:kLeBaiSendCodeUrl parameter:@{@"mobile": self.phoneTF.text} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            
            
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)requestLebaiPayData {
  
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showProgressHUDWithTitle:@"付款中"];
    });
    NSMutableDictionary *dic = [NSMutableDictionary new];
//  @{@"name": self.nameTF.text,
//                          @"idCard": self.IDCardTF.text,
//                          @"accNo":self.bankCardTF.text,
//                          @"validDate": [NSString stringWithFormat:@"%@%@", self.mouthTF.text, self.yearTF.text],
//                          @"cvn": self.CVN2TF.text,
//                          @"phone": self.phoneTF.text,
//                          @"smsCode": self.smsCodeTF.text,
//                          @"txnTerms": @(self.count),
//                          @"txnAmt": self.orderDic[@"total_fee"],
//                          @"pay_way": self.orderDic[@"pay_way"],
//                          @"order_no":self.orderDic[@"order_no"],
//                          @"user_id": kUser_id};
    [dic setObject:self.nameTF.text forKey:@"name"];
    [dic setObject:self.IDCardTF.text forKey:@"idCard"];
    [dic setObject:self.bankCardTF.text forKey:@"accNo"];
    [dic setObject:[NSString stringWithFormat:@"%@%@", self.mouthTF.text, self.yearTF.text] forKey:@"validDate"];
    [dic setObject:self.CVN2TF.text forKey:@"cvn"];
    [dic setObject:self.phoneTF.text forKey:@"phone"];
    [dic setObject:self.smsCodeTF.text forKey:@"smsCode"];
    [dic setObject:@(self.count) forKey:@"txnTerms"];

    [dic setObject:kUser_id forKey:@"user_id"];

    
    if (self.orderModel) {
        [dic setObject:self.orderModel.order_no forKey:@"order_no"];
        [dic setObject:self.orderModel.shop_price forKey:@"txnAmt"];
        [dic setObject:@0 forKey:@"pay_way"];

    } else {
        [dic setObject:self.orderDic[@"total_fee"] forKey:@"txnAmt"];
        [dic setObject:self.orderDic[@"pay_way"] forKey:@"pay_way"];
        [dic setObject:self.orderDic[@"order_no"] forKey:@"order_no"];

    }
    [LHNetworkManager PostWithUrl:kLebaiPayUrl parameter:dic success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        LHPayResultsViewController *payResultVC = [[LHPayResultsViewController alloc] init];
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideProgressHUD];
                [self showProgressHUDWithTitle:@"付款成功"];
            });
            
            //解析data
            NSData *jsonData = [reponseObject[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *aDic = [NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingAllowFragments) error:nil];
            NSLog(@"--------------- %@", aDic);
            payResultVC.resultDic = aDic;
            //0000 代表操作成功
            //01** 代表乐百分平台前置检查失败代码
            //02** 代表乐百分平台核心检查失败代码
            //03** 代表银联检查失败代码
            payResultVC.payResultStr = [NSString stringWithFormat:@"%@", aDic[@"respCode"]];
        }
        payResultVC.payType = 0;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideProgressHUD];
            [self.navigationController pushViewController:payResultVC animated:YES];
        });
    } failure:^(NSError *error) {
        
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
