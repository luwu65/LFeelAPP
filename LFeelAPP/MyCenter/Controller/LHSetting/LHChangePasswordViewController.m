//
//  LHChangePasswordViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/21.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHChangePasswordViewController.h"

@interface LHChangePasswordViewController ()
@property (nonatomic, strong) UITextField *captchaTextField;
@property (nonatomic, strong) UITextField *passwordTextField1;
@property (nonatomic, strong) UITextField *passwordTextField2;
@end

@implementation LHChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    [self setHBK_NavigationBar];
}
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"修改密码" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}



- (void)setUI {
    //横线
    UIView *wireView = [[UIView alloc] init];
    wireView.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:wireView];
    [wireView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.height.mas_equalTo(10);
    }];
    
    
    UIImageView *captchaImageView = [[UIImageView alloc] init];
    captchaImageView.image = [UIImage imageNamed:@"Login_Password"];
    [self.view addSubview:captchaImageView];
    [captchaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(kFit(30));
        make.top.equalTo(wireView.mas_bottom).offset((50-kFit(30))/2);
        make.width.mas_equalTo(kFit(30));
        make.height.mas_equalTo(kFit(30));
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(captchaImageView.mas_right).offset(10);
        make.top.equalTo(wireView.mas_bottom).offset(5);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(40);
    }];
    
    self.captchaTextField = [[UITextField alloc] init];
    _captchaTextField.placeholder = @"请输入原密码";
    _captchaTextField.font = kFont(kFit(16));
    [self.view addSubview:_captchaTextField];
    [_captchaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-kFit(30));
        make.centerY.equalTo(captchaImageView.mas_centerY);
        make.height.mas_equalTo(40);
    }];
    
    
    //横线
    UIView *wireView1 = [[UIView alloc] init];
    wireView1.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:wireView1];
    [wireView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(wireView.mas_bottom).offset(50);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *loginImageView1 = [[UIImageView alloc] init];
    loginImageView1.image = [UIImage imageNamed:@"Login_Password"];
    [self.view addSubview:loginImageView1];
    [loginImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kFit(30));
        make.top.equalTo(wireView1.mas_bottom).offset((50-kFit(30))/2);
        make.width.mas_equalTo(kFit(30));
        make.height.mas_equalTo(kFit(30));
    }];
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loginImageView1.mas_right).offset(10);
        make.top.equalTo(wireView1.mas_bottom).offset(5);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(40);
    }];
    
    self.passwordTextField1 = [[UITextField alloc] init];
    _passwordTextField1.placeholder = @"请输入新密码";
    _passwordTextField1.secureTextEntry = YES;
    _passwordTextField1.font = kFont(kFit(16));
    [self.view addSubview:_passwordTextField1];
    [_passwordTextField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView1.mas_right).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-kFit(30));
        make.centerY.equalTo(loginImageView1.mas_centerY);
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
    
    UIImageView *loginImageView2 = [[UIImageView alloc] init];
    loginImageView2.image = [UIImage imageNamed:@"Login_Password"];
    [self.view addSubview:loginImageView2];
    [loginImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kFit(30));
        make.top.equalTo(wireView2.mas_bottom).offset((50-kFit(30))/2);
        make.width.mas_equalTo(kFit(30));
        make.height.mas_equalTo(kFit(30));
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loginImageView2.mas_right).offset(10);
        make.top.equalTo(wireView2.mas_bottom).offset(5);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(40);
    }];
    
    self.passwordTextField2 = [[UITextField alloc] init];
    _passwordTextField2.placeholder = @"请再次输入密码";
    _passwordTextField2.secureTextEntry = YES;
    _passwordTextField2.font = kFont(kFit(16));
    [self.view addSubview:_passwordTextField2];
    [_passwordTextField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView2.mas_right).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-kFit(30));
        make.centerY.equalTo(loginImageView2.mas_centerY);
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
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(wireView3.mas_bottom).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    
    //提交
    UIButton *submitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    submitBtn.backgroundColor = [UIColor whiteColor];
    [submitBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [submitBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.borderColor = [UIColor redColor].CGColor;
    submitBtn.layer.borderWidth = 1;
    [bgView addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-80);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(kFit(40));
    }];
    
    
}

//提交
- (void)submitBtnAction {

    
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
