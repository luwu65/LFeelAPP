//
//  LHAddBankCardViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHAddBankCardViewController.h"

@interface LHAddBankCardViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *bankCardTF;
@property (weak, nonatomic) IBOutlet UITextField *IDCardTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *captchaTF;
@property (weak, nonatomic) IBOutlet UIButton *captchalBtn;

@end

@implementation LHAddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setHBK_NavigationBar];
    
    self.nameTF.text = @"李刚";
    self.bankCardTF.text = @"370248476988912";
    self.IDCardTF.text = @"330201199608164112";
    
    
    
}


- (void)setHBK_NavigationBar {
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"添加信用卡" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark  ------------------ Action ----------------------
//
- (IBAction)addAction:(UIButton *)sender {
//    kVerifyText(self.nameTF.text.length, @"请输入姓名");
//    kVerifyText(self.bankCardTF.text, @"请输入信用卡号");
//    kIDCard(self.IDCardTF.text, @"请输入身份证号码");
//    kVerifyPhone(self.phoneTF.text, @"请输入正确手机号");
//    kVerifyText(self.captchaTF.text.length, @"请输入验证码");
    [self requestAddBankCardData];
}


#pragma mark ------------------- 网络请求 ----------------------

- (void)requestAddBankCardData {
    
    NSDictionary *dic = @{@"user_name": self.nameTF.text,
                          @"bank_no": self.bankCardTF.text,
                          @"idCard": self.IDCardTF.text,
                          @"user_id": kUser_id};
    [LHNetworkManager PostWithUrl:kAddBankCardUrl parameter:dic success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
         dispatch_async(dispatch_get_main_queue(), ^{
             [MBProgressHUD showSuccess:@"添加成功"];
         });
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self.navigationController popViewControllerAnimated:YES];
         });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"添加失败, 请重试!"];
            });
        }
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
