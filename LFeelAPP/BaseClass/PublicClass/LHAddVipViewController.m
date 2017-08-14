//
//  LHAddVipViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/19.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHAddVipViewController.h"
@interface LHAddVipViewController ()

@property (nonatomic, assign) BOOL isClick;
@property (nonatomic, strong) CustomButton *halfYearBtn;
@property (nonatomic, strong) CustomButton *yearBtn;



@end

@implementation LHAddVipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.isClick = NO;
    [self setUI];
}

- (void)setUI {
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"AddVip_bgImageView"];
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    
    UILabel *eLabel = [[UILabel alloc] init];
    eLabel.font = kFont(20*kRatio);
    eLabel.text = @"MEMBERSHIP";
    eLabel.textAlignment = NSTextAlignmentLeft;
    [bgImageView addSubview:eLabel];
    [eLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.top.equalTo(self.view.mas_top).offset(100*kRatio);
        make.height.mas_offset(50*kRatio);
    }];
    
    UILabel *cLabel = [[UILabel alloc] init];
    cLabel.text = @"购买会员";
    cLabel.font = kFont(17*kRatio);
    cLabel.textColor = [UIColor lightGrayColor];
    [bgImageView addSubview:cLabel];
    [cLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.top.equalTo(eLabel.mas_bottom).offset(0);
        make.height.mas_offset(50*kRatio);
    }];
    
    self.yearBtn = [[CustomButton alloc] initWithFrame:CGRectZero time:@"12个月" rmb:@"990"];
    [self.yearBtn addTarget:self action:@selector(yearBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bgImageView addSubview:self.yearBtn];
    [self.yearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.top.equalTo(cLabel.mas_bottom).offset(30*kRatio);
        make.height.mas_offset(80);
    }];
    
    
    self.halfYearBtn = [[CustomButton alloc] initWithFrame:CGRectZero time:@"6个月" rmb:@"990"];
    [self.halfYearBtn addTarget:self action:@selector(halfYearBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bgImageView addSubview:self.halfYearBtn];
    [self.halfYearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.top.equalTo(self.yearBtn.mas_bottom).offset(30*kRatio);
        make.height.mas_offset(80);
    }];
    
    UIButton *buyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [buyBtn setTitle:@"立即购买" forState:(UIControlStateNormal)];
    [buyBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    buyBtn.layer.cornerRadius = 2;
    buyBtn.layer.masksToBounds = YES;
    buyBtn.layer.borderColor = [UIColor redColor].CGColor;
    buyBtn.layer.borderWidth = 1;
    [buyBtn addTarget:self action:@selector(buyVipAction) forControlEvents:(UIControlEventTouchUpInside)];
    [bgImageView addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"AddVip_back"] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [bgImageView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.mas_offset(40);
        make.width.mas_equalTo(40);
    }];
    
    
}


- (void)yearBtnAction:(CustomButton *)sender {
    self.halfYearBtn.chooseImageView.image = [UIImage imageNamed:@"MyBox_click_default"];
    if (self.halfYearBtn.selected == YES) {
        self.halfYearBtn.selected = !self.halfYearBtn.selected;
    }
    sender.selected = !sender.selected;
    if (sender.selected == NO) {
        sender.chooseImageView.image = [UIImage imageNamed:@"MyBox_click_default"];
        
    } else {
        sender.chooseImageView.image = [UIImage imageNamed:@"MyBox_clicked"];
    
    }
}

- (void)halfYearBtnAction:(CustomButton *)sender {
    self.yearBtn.chooseImageView.image = [UIImage imageNamed:@"MyBox_click_default"];
    if (self.yearBtn.selected == YES) {
        self.yearBtn.selected = !self.yearBtn.selected;
    }
    sender.selected = !sender.selected;
    if (sender.selected == NO) {
        sender.chooseImageView.image = [UIImage imageNamed:@"MyBox_click_default"];        
    } else {
        sender.chooseImageView.image = [UIImage imageNamed:@"MyBox_clicked"];
        
    }
    
}

- (void)buyVipAction {
    
    
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
