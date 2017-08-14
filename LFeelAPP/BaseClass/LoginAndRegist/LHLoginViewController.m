//
//  LHLoginViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/19.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHLoginViewController.h"
#import "LHRegistViewController.h"
#import "LhCaptchaLoginViewController.h"
#import "LHForgetPasswordViewController.h"
#import "LHUserInfoModel.h"

@interface LHLoginViewController ()

@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UITextField *phoneTextField;


@end

@implementation LHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    [self thirdLogin];

    
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
    UIView *wireTopView = [[UIView alloc] init];
    wireTopView.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:wireTopView];
    [wireTopView mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.bottom.equalTo(wireTopView.mas_top).offset(-(50-30*kRatio)/2);
        make.width.mas_equalTo(30*kRatio);
        make.height.mas_equalTo(30*kRatio);
    }];
    
    UIView *lineTopView = [[UIView alloc] init];
    lineTopView.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:lineTopView];
    [lineTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneImageView.mas_right).offset(10);
        make.bottom.equalTo(wireTopView.mas_top).offset(-5);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(40);
    }];
    
    self.phoneTextField = [[UITextField alloc] init];
    _phoneTextField.placeholder = @"请输入手机号";
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextField.font = kFont(16*kRatio);
    [self.view addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineTopView.mas_right).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-30*kRatio);
        make.centerY.equalTo(phoneImageView.mas_centerY);
        make.height.mas_equalTo(40);
    }];
    
    //横线
    UIView *wireBottomView = [[UIView alloc] init];
    wireBottomView.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:wireBottomView];
    [wireBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(wireTopView.mas_bottom).offset(50);
        make.height.mas_equalTo(1);
    }];
    
    
    UIImageView *passwordImageView = [[UIImageView alloc] init];
    passwordImageView.image = [UIImage imageNamed:@"Login_Password"];
    [self.view addSubview:passwordImageView];
    [passwordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30*kRatio);
        make.bottom.equalTo(wireBottomView.mas_top).offset(-(50-30*kRatio)/2);
        make.width.mas_equalTo(30*kRatio);
        make.height.mas_equalTo(30*kRatio);
    }];
    
    UIView *lineBottomView = [[UIView alloc] init];
    lineBottomView.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:lineBottomView];
    [lineBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordImageView.mas_right).offset(10);
        make.bottom.equalTo(wireBottomView.mas_top).offset(-5);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(40);
    }];
    
    self.passwordTextField = [[UITextField alloc] init];
    _passwordTextField.placeholder = @"请输入密码";
    _passwordTextField.font = kFont(16*kRatio);
    _passwordTextField.secureTextEntry = YES;
    [self.view addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineTopView.mas_right).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-30*kRatio);
        make.centerY.equalTo(passwordImageView.mas_centerY);
        make.height.mas_equalTo(40);
    }];
    
    
    //验证码登录按钮
    UIButton *mgsBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [mgsBtn setTitle:@"验证码登录" forState:(UIControlStateNormal)];
    mgsBtn.layer.cornerRadius = 5;
    mgsBtn.layer.masksToBounds = YES;
    mgsBtn.backgroundColor = [UIColor redColor];
    [mgsBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    mgsBtn.titleLabel.font = kFont(15*kRatio);
    [mgsBtn addTarget:self action:@selector(mgsBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:mgsBtn];
    [mgsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.width.mas_equalTo(100*kRatio);
        make.height.mas_equalTo(30*kRatio);
        make.top.equalTo(wireBottomView.mas_bottom).offset(10);
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
        make.top.equalTo(mgsBtn.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(40*kRatio);
    }];
    
    //注册
    UILabel *registLabel = [[UILabel alloc] init];
    registLabel.text = @"注册";
    registLabel.textColor = [UIColor lightGrayColor];
    registLabel.font = kFont(14*kRatio);
    registLabel.userInteractionEnabled = YES;
    [self.view addSubview:registLabel];
    [registLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginBtn.mas_left).offset(0);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    UITapGestureRecognizer *tapRegist = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRegistAction)];
    [registLabel addGestureRecognizer:tapRegist];
    
    //忘记密码
    UILabel *forgetLabel = [[UILabel alloc] init];
    forgetLabel.text = @"忘记密码?";
    forgetLabel.textColor = [UIColor lightGrayColor];
    forgetLabel.textAlignment = NSTextAlignmentRight;
    forgetLabel.font = kFont(14*kRatio);
    forgetLabel.userInteractionEnabled = YES;
    [self.view addSubview:forgetLabel];
    [forgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.loginBtn.mas_right).offset(0);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    UITapGestureRecognizer *tapForget = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapForgetAction)];
    [forgetLabel addGestureRecognizer:tapForget];
}

//跳转到注册页面
- (void)tapRegistAction {
    LHRegistViewController *registVC = [[LHRegistViewController alloc] init];
    [self presentViewController:registVC animated:YES completion:nil];
}

//跳转到忘记密码界面
- (void)tapForgetAction {
    LHForgetPasswordViewController *forgetVC = [[LHForgetPasswordViewController alloc] init];
    [self presentViewController:forgetVC animated:YES completion:nil];
}


//验证码登录
- (void)mgsBtnAction {
    LhCaptchaLoginViewController *captchaVC = [[LhCaptchaLoginViewController alloc] init];
    [self presentViewController:captchaVC animated:YES completion:nil];
}

//登录
- (void)loginBtnAction {
    [self showProgressHUDWithTitle:@"登录中"];
    NSDictionary *dic = @{@"mobile": self.phoneTextField.text, @"password": [MDManager md5withStr:self.passwordTextField.text], @"level":@0};
    [LHNetworkManager PostWithUrl:kLoginURL parameter:dic success:^(id reponseObject) {
//        NSLog(@"%@----%@----%@", self.phoneTextField.text, self.passwordTextField.text, [MDManager md5withStr:self.passwordTextField.text]);
        NSLog(@"%@", reponseObject);
        if ([kSTR(reponseObject[@"isError"]) isEqualToString:@"0"]) {
            [LHUserInfoManager cleanUserInfo];
            LHUserInfoModel *model = [[LHUserInfoModel alloc] init];
            NSDictionary *dic = reponseObject[@"data"];
            [model setValuesForKeysWithDictionary:dic[@"user"]];
            [LHUserInfoManager saveUserInfoWithModel:model];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
                [self hideProgressHUD];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAlertViewWithTitle:reponseObject[@"errorDesc"]];
            });
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}



//第三方登录
- (void)thirdLogin {

    
    //微博
    UIButton *wbBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [wbBtn setImage:[UIImage imageNamed:@"Login_Weibo"] forState:(UIControlStateNormal)];
    [wbBtn addTarget:self action:@selector(wbBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:wbBtn];
    [wbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        make.width.mas_equalTo(50*kRatio);
        make.height.mas_equalTo(50*kRatio);
    }];
    
    
    //微信登录
    UIButton *wxBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [wxBtn setImage:[UIImage imageNamed:@"Login_Weixin"] forState:(UIControlStateNormal)];
    [wxBtn addTarget:self action:@selector(wcBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:wxBtn];
    [wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wbBtn.mas_left).offset(-60*kRatio);
        make.centerY.equalTo(wbBtn.mas_centerY);
        make.width.mas_equalTo(50*kRatio);
        make.height.mas_equalTo(50*kRatio);
    }];
    
    //QQ登录
    UIButton *qqBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [qqBtn setImage:[UIImage imageNamed:@"Login_QQ"] forState:(UIControlStateNormal)];
    [qqBtn addTarget:self action:@selector(qqBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:qqBtn];
    [qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wbBtn.mas_right).offset(60*kRatio);
        make.centerY.equalTo(wbBtn.mas_centerY);
        make.width.mas_equalTo(50*kRatio);
        make.height.mas_equalTo(50*kRatio);
    }];
    
    
    UILabel *thirdLabel = [[UILabel alloc] init];
    thirdLabel.text = @"使用其他社交账号登陆";
    thirdLabel.textColor = [UIColor lightGrayColor];
    thirdLabel.font = kFont(14*kRatio);
    [self.view addSubview:thirdLabel];
    [thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(wbBtn.mas_top).offset(-30);
        make.height.mas_equalTo(25*kRatio);
    }];
    
    
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(thirdLabel.mas_left).offset(-10);
        make.height.mas_equalTo(1);
        make.centerY.equalTo(thirdLabel.mas_centerY);
    }];
    
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(thirdLabel.mas_right).offset(10);
        make.height.mas_equalTo(1);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.centerY.equalTo(thirdLabel.mas_centerY);
    }];
}


//微信登录
- (void)wcBtnAction {
    NSLog(@"微信登录");
}


//微博登录
- (void)wbBtnAction {

    NSLog(@"微博登录");
}

//QQ登录
- (void)qqBtnAction {
   
    NSLog(@"QQ登录");
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
