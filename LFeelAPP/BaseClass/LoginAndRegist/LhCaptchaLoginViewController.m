//
//  LhCaptchaLoginViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/26.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LhCaptchaLoginViewController.h"

@interface LhCaptchaLoginViewController ()
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *captchaTextField;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation LhCaptchaLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    
    [self setUI];
    
    
    
    
}
//获取验证码
- (void)obtainCaptchaAction {
    [LHNetworkManager PostWithUrl:kGetVerifyURL parameter:@{@"mobile": self.phoneTextField.text} success:^(id reponseObject) {
        NSLog(@"============%@----%@", reponseObject, [reponseObject class]);
        
    } failure:^(NSError *error) {
        NSLog(@"~~~~~~~~~~~~%@", error);
    }];
}


//登录
- (void)loginBtnAction {
    [LHNetworkManager PostWithUrl:kVerifyLogin parameter:@{@"mobile":self.phoneTextField.text, @"verifycode":self.captchaTextField.text} success:^(id reponseObject) {
        NSLog(@"!!!!!!!!!1%@", reponseObject);
        if ([kSTR(reponseObject[@"isError"]) isEqualToString:@"0"]) {
            [LHUserInfoManager cleanUserInfo];
            LHUserInfoModel *model = [[LHUserInfoModel alloc] init];
            NSDictionary *dic = reponseObject[@"data"];
            [model setValuesForKeysWithDictionary:dic[@"user"]];
            [LHUserInfoManager saveUserInfoWithModel:model];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAlertViewWithTitle:reponseObject[@"errorDesc"]];
            });
        }
    } failure:^(NSError *error) {
        
    }];
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
    captchaBtn.titleLabel.font = kFont(15*kRatio);
    captchaBtn.layer.cornerRadius = 5;
    captchaBtn.layer.masksToBounds = YES;
    [captchaBtn addTarget:self action:@selector(obtainCaptchaAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:captchaBtn];
    [captchaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.centerY.equalTo(captchaImageView.mas_centerY);
        make.width.mas_equalTo(100);
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
//    _captchaTextField.secureTextEntry = YES;
    [self.view addSubview:_captchaTextField];
    [_captchaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView1.mas_right).offset(10);
        make.right.equalTo(captchaBtn.mas_left).offset(0);
        make.centerY.equalTo(captchaImageView.mas_centerY);
        make.height.mas_equalTo(40);
    }];
    
    
    //登录
    self.loginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
    [_loginBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    _loginBtn.layer.cornerRadius = 5;
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.borderColor = [UIColor redColor].CGColor;
    _loginBtn.layer.borderWidth = 1;
    [self.view addSubview:_loginBtn];
    [_loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wireView2.mas_bottom).offset(30);
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
