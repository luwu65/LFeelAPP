//
//  LHForgetPasswordViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/19.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHForgetPasswordViewController.h"

@interface LHForgetPasswordViewController ()
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *captchaTextField;
@property (nonatomic, strong) UITextField *passwordTextField1;
@property (nonatomic, strong) UITextField *passwordTextField2;


@end

@implementation LHForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}


//获取验证码
- (void)obtainCaptchaAction {
    [self showProgressHUD];
    [LHNetworkManager PostWithUrl:kGetVerifyURL parameter:@{@"mobile": self.phoneTextField.text} success:^(id reponseObject) {
//        NSLog(@"============%@----%@", reponseObject, [reponseObject class]);
        if ([kSTR(reponseObject[@"isError"]) isEqualToString:@"0"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideProgressHUD];
            });
        } else {
            [self showAlertViewWithTitle:@"发送失败, 请重新发送"];
        }
    } failure:^(NSError *error) {
        NSLog(@"~~~~~~~~~~~~%@", error);
    }];
}

//提交
- (void)submitBtnAction {
    [self showProgressHUD];
    NSDictionary *dic = @{@"mobile": self.phoneTextField.text,
                          @"username": self.phoneTextField.text,
                          @"verifycode":self.captchaTextField.text,
                          @"password": [MDManager md5withStr:self.passwordTextField2.text]};
    if ([self.passwordTextField1.text isEqualToString:self.passwordTextField2.text]) {
        [LHNetworkManager PostWithUrl:kForgetPassword parameter:dic success:^(id reponseObject) {
//            NSLog(@"AAAAAAAAAAAAAAAAA%@", reponseObject);
//            NSLog(@"%@", [reponseObject class]);
            if ([dic isKindOfClass:[NSDictionary class]]) {
                if ([reponseObject isKindOfClass:[NSDictionary class]]) {
                    if ([kSTR(reponseObject[@"isError"]) isEqualToString:@"1"]) {
                        [self showAlertViewWithTitle:@"请求失败, 请检查网络"];
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self hideProgressHUD];
                        });
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self dismissViewControllerAnimated:YES completion:nil];
                        });
                    }
                }
            }
        } failure:^(NSError *error) {
            NSLog(@"BBBBBBBBBBBBBBBBB%@", error);
            
        }];
    } else {
        [self showAlertViewWithTitle:@"两次密码不一致, 请重新输入"];
        self.passwordTextField1.text = @"";
        self.passwordTextField2.text = @"";
    }
}






- (void)setUI {
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(self.view.mas_top).offset(0);
        make.height.mas_equalTo(kScreenWidth/2);
        
    }];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backBtn setImage:[UIImage imageNamed:@"Login_Back_write"] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    backBtn.frame = CGRectMake(0, 20, 40, 40);
    [bgView addSubview:backBtn];
    
    //logo
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.backgroundColor = [UIColor greenColor];
    [bgView addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView.mas_centerX);
        make.centerY.equalTo(bgView.mas_centerY);
        make.width.mas_equalTo(80*kRatio);
        make.height.mas_equalTo(80*kRatio);
    }];
    
    //横线
    UIView *wireView1 = [[UIView alloc] init];
    wireView1.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:wireView1];
    [wireView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(bgView.mas_bottom).offset(50);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *phoneImageView = [[UIImageView alloc] init];
    phoneImageView.image = [UIImage imageNamed:@"Login_Phone"];
    [self.view addSubview:phoneImageView];
    [phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30*kRatio);
        make.bottom.equalTo(wireView1.mas_top).offset(-(50-30*kRatio)/2);
        make.width.mas_equalTo(30*kRatio);
        make.height.mas_equalTo(30*kRatio);
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneImageView.mas_right).offset(10);
        make.bottom.equalTo(wireView1.mas_top).offset(-5);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(30);
    }];
    
    self.phoneTextField = [[UITextField alloc] init];
    _phoneTextField.placeholder = @"请输入手机号";
    _phoneTextField.font = kFont(16*kRatio);
    [self.view addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView1.mas_right).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-30*kRatio);
        make.centerY.equalTo(phoneImageView.mas_centerY);
        make.height.mas_equalTo(40);
    }];
    
    //横线
    UIView *wireView2 = [[UIView alloc] init];
    wireView2.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:wireView2];
    [wireView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(wireView1.mas_bottom).offset(50);
        make.height.mas_equalTo(1);
    }];
    
    
    UIImageView *captchaImageView = [[UIImageView alloc] init];
    captchaImageView.image = [UIImage imageNamed:@"Login_Captcha"];
    [self.view addSubview:captchaImageView];
    [captchaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30*kRatio);
        make.bottom.equalTo(wireView2.mas_top).offset(-(50-30*kRatio)/2);
        make.width.mas_equalTo(30*kRatio);
        make.height.mas_equalTo(30*kRatio);
    }];
    
    UIButton *captchaBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [captchaBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [captchaBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    captchaBtn.backgroundColor = [UIColor redColor];
    captchaBtn.titleLabel.font = kFont(15);
    captchaBtn.layer.cornerRadius = 5;
    captchaBtn.layer.masksToBounds = YES;
    [captchaBtn addTarget:self action:@selector(obtainCaptchaAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:captchaBtn];
    [captchaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.centerY.equalTo(captchaImageView.mas_centerY);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(captchaImageView.mas_right).offset(10);
        make.bottom.equalTo(wireView2.mas_top).offset(-5);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(40);
    }];
    
    self.captchaTextField = [[UITextField alloc] init];
    _captchaTextField.placeholder = @"请输入验证码";
    _captchaTextField.font = kFont(16*kRatio);
    [self.view addSubview:_captchaTextField];
    [_captchaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView1.mas_right).offset(10);
        make.right.equalTo(captchaBtn.mas_left).offset(0);
        make.centerY.equalTo(captchaImageView.mas_centerY);
        make.height.mas_equalTo(40);
    }];
    
    
    //横线
    UIView *wireView3 = [[UIView alloc] init];
    wireView3.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:wireView3];
    [wireView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(wireView2.mas_bottom).offset(50);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *loginImageView1 = [[UIImageView alloc] init];
    loginImageView1.image = [UIImage imageNamed:@"Login_Password"];
    [self.view addSubview:loginImageView1];
    [loginImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30*kRatio);
        make.bottom.equalTo(wireView3.mas_top).offset(-(50-30*kRatio)/2);
        make.width.mas_equalTo(30*kRatio);
        make.height.mas_equalTo(30*kRatio);
    }];
    UIView *lineView3 = [[UIView alloc] init];
    lineView3.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:lineView3];
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loginImageView1.mas_right).offset(10);
        make.bottom.equalTo(wireView3.mas_top).offset(-5);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(40);
    }];
    
    self.passwordTextField1 = [[UITextField alloc] init];
    _passwordTextField1.placeholder = @"请输入新密码";
    _passwordTextField1.secureTextEntry = YES;
    _passwordTextField1.font = kFont(16*kRatio);
    [self.view addSubview:_passwordTextField1];
    [_passwordTextField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView3.mas_right).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-30*kRatio);
        make.centerY.equalTo(loginImageView1.mas_centerY);
        make.height.mas_equalTo(40);
    }];
    
    
    
    //横线
    UIView *wireView4 = [[UIView alloc] init];
    wireView4.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:wireView4];
    [wireView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(wireView3.mas_bottom).offset(50);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *loginImageView2 = [[UIImageView alloc] init];
    loginImageView2.image = [UIImage imageNamed:@"Login_Password"];
    [self.view addSubview:loginImageView2];
    [loginImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30*kRatio);
        make.bottom.equalTo(wireView4.mas_top).offset(-(50-30*kRatio)/2);
        make.width.mas_equalTo(30*kRatio);
        make.height.mas_equalTo(30*kRatio);
    }];
    
    UIView *lineView4 = [[UIView alloc] init];
    lineView4.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:lineView4];
    [lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loginImageView2.mas_right).offset(10);
        make.bottom.equalTo(wireView4.mas_top).offset(-5);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(40);
    }];
    
    self.passwordTextField2 = [[UITextField alloc] init];
    _passwordTextField2.placeholder = @"请再次输入密码";
    _passwordTextField2.secureTextEntry = YES;
    _passwordTextField2.font = kFont(16*kRatio);
    [self.view addSubview:_passwordTextField2];
    [_passwordTextField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView4.mas_right).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-30*kRatio);
        make.centerY.equalTo(loginImageView2.mas_centerY);
        make.height.mas_equalTo(40);
    }];
 
    //提交
    UIButton *submitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [submitBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [submitBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.borderColor = [UIColor redColor].CGColor;
    submitBtn.layer.borderWidth = 1;
    [self.view addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wireView4.mas_bottom).offset(30);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(40*kRatio);
    }];

    
}

//返回
- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
