//
//  LHPackInfoViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/31.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHPackInfoViewController.h"
#import "LHPackInfoChooseView.h"
#import "LHReceiveAddressViewController.h"

@interface LHPackInfoViewController ()<LHPickViewDelegate> {
    LHPackInfoView *_firstView;
    LHPackInfoView *_secondView;
    LHPackInfoView *_thirdView;
    NSString *_ChooseID;
    
}
@property (nonatomic, strong) LHPickView *linePickView;

@property (nonatomic, strong) UIView *addressBgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIView *noAddressBgView;


@property (nonatomic, strong) UIView *defaultView;
@property (nonatomic, strong) UILabel *remindLabel;

@end

@implementation LHPackInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    [self setHBK_NavigationBar];
    
    [self chooseClothesAction];
}


#pragma mark  ------------- UI -------------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"完善信息" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)setupUI {
    self.view.backgroundColor = kColor(245, 245, 245);
    
    [self CreateNoAddressView];
    
    _firstView = [LHPackInfoView creatView];
    _firstView.numLabel.text = @"第一件:";
    _firstView.frame = CGRectMake(0, self.noAddressBgView.maxY+15, kScreenWidth, kFit(45));
    [self.view addSubview:_firstView];
    
    _secondView = [LHPackInfoView creatView];
    _secondView.numLabel.text = @"第二件:";
    _secondView.frame = CGRectMake(0, _firstView.maxY, kScreenWidth, kFit(45));
    [self.view addSubview:_secondView];

    _thirdView = [LHPackInfoView creatView];
    _thirdView.numLabel.text = @"第三件:";
    _thirdView.frame = CGRectMake(0, _secondView.maxY, kScreenWidth, kFit(45));
    [self.view addSubview:_thirdView];
    
    self.defaultView = [[UIView alloc] initWithFrame:CGRectMake(0, _thirdView.maxY+15, kScreenWidth, kFit(35))];
    self.defaultView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.defaultView];
    
    CustomButton *defaultBtn = [[CustomButton alloc] initWithFrame:CGRectMake(kScreenWidth-kFit(90), 0, kFit(80), kFit(35)) imageFrame:CGRectMake(10, 5, kFit(25), kFit(25)) imageName:@"MyBox_click_default" titleLabelFrame:CGRectMake(kFit(30), 0, kFit(45), kFit(35)) title:@"默认" titleColor:[UIColor blackColor] titleFont:15];
    [defaultBtn addTarget:self action:@selector(defaultBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.defaultView addSubview:defaultBtn];
    
    self.remindLabel = [[UILabel alloc] init];
    self.remindLabel.text = @"温馨提示:选择默认, 我们会根据您在个人信息里填写的信息选择商品大小哦~";
    self.remindLabel.numberOfLines = 0;
    self.remindLabel.font = kFont(12);
    [self.view addSubview:self.remindLabel];
    [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.defaultView.mas_bottom).offset(10);
    }];
    
    
    UIButton *submitBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    submitBtn.frame = CGRectMake(kFit(30), kScreenHeight-kFit(80), kScreenWidth-kFit(60), kFit(40));
    [submitBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [submitBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    submitBtn.layer.cornerRadius = 2;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.borderColor = [UIColor redColor].CGColor;
    submitBtn.layer.borderWidth = 1;
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:submitBtn];
}

- (void)createLineOnePickViewWithArray:(NSArray *)array {
    self.linePickView = [[LHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    self.linePickView.delegate = self;
    self.linePickView.toolbarTextColor = [UIColor blackColor];
    self.linePickView.toolbarBGColor = kColor(245, 245, 245);
    [self.linePickView show];
}

- (void)CreateNoAddressView {
    self.noAddressBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kFit(60))];
    self.noAddressBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.noAddressBgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapNoAddressViewAction)];
    [self.noAddressBgView addGestureRecognizer:tap];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, kFit(60))];
    titleLabel.text = @"收货地址";
    titleLabel.font = kFont(15);
    [self.noAddressBgView addSubview:titleLabel];
    
    UIImageView *openImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 30, (self.noAddressBgView.frame.size.height - 20)/2, 8, 16)];
    openImageView.image = kImage(@"MyCenter_CardBox_OpenCell");
    [self.noAddressBgView addSubview:openImageView];
    
}

- (void)CreateAddressView {
    self.addressBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kFit(100))];
    self.addressBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.addressBgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAddressViewAction)];
    [self.addressBgView addGestureRecognizer:tap];
    
    UIImageView *addressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kFit(10), (self.addressBgView.frame.size.height-kFit(15))/2, kFit(12), kFit(16))];
    addressImageView.image = kImage(@"MyBox_Address");
    [self.addressBgView addSubview:addressImageView];
    
    UIImageView *openImageView = [[UIImageView alloc] init];
    openImageView.image = kImage(@"MyCenter_CardBox_OpenCell");
    [self.addressBgView addSubview:openImageView];
    [openImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.addressBgView.mas_right).offset(-10);
        make.width.mas_equalTo(kFit(8));
        make.height.mas_equalTo(kFit(15));
        make.centerY.mas_equalTo(self.addressBgView.mas_centerY);
    }];
    
    //姓名
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kFit(30), kFit(10), (kScreenWidth-kFit(60))/2, kFit(20))];
    self.nameLabel.font = kFont(15);
    [self.addressBgView addSubview:self.nameLabel];
    
    //电话
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.maxX, kFit(10), (kScreenWidth-kFit(60))/2, kFit(20))];
    self.phoneLabel.textAlignment = NSTextAlignmentRight;
    [self.addressBgView addSubview:self.phoneLabel];
    
    //地址
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(kFit(30), kFit(35), kScreenWidth-kFit(60), kFit(50))];
    self.addressLabel.font = kFont(14);
    [self.addressBgView addSubview:self.addressLabel];
}




#pragma mark  ----------------------  Action -----------
//默认
- (void)defaultBtnAction:(CustomButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        NSLog(@"选中默认");
        sender.titleImageView.image = kImage(@"MyBox_clicked");
    } else {
        NSLog(@"取消选中默认");
        sender.titleImageView.image = kImage(@"MyBox_click_default");
    }
}
//提交
- (void)submitAction {
    NSLog(@"提交");
}

//没有地址时
- (void)tapNoAddressViewAction {
    NSLog(@"选择地址");
    LHReceiveAddressViewController *receiveVC = [[LHReceiveAddressViewController alloc] init];
    receiveVC.addressBlock = ^(LHAddressModel *model) {
//        NSLog(@"%@%@%@%@", model.province, model.city, model.district, model.detail_address);
        [self.noAddressBgView removeFromSuperview];
        [self CreateAddressView];
        [self updateConstraint];
        self.nameLabel.text = model.name;
        self.phoneLabel.text = model.mobile;
        self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@", model.province, model.city, model.district, model.detail_address];;
        
    };
    [self.navigationController pushViewController:receiveVC animated:YES];
}

//有地址时
- (void)tapAddressViewAction {
    LHReceiveAddressViewController *receiveVC = [[LHReceiveAddressViewController alloc] init];
    receiveVC.addressBlock = ^(LHAddressModel *model) {
//        NSLog(@"%@%@%@%@", model.province, model.city, model.district, model.detail_address);
        self.nameLabel.text = model.name;
        self.phoneLabel.text = model.mobile;
        self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@", model.province, model.city, model.district, model.detail_address];
    };
    [self.navigationController pushViewController:receiveVC animated:YES];
}

//更新约束
- (void)updateConstraint {
    [_firstView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.addressBgView.mas_bottom).offset(15);
        make.height.mas_equalTo(kFit(45));
    }];
    [_secondView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view).offset(0);
        make.top.equalTo(_firstView.mas_bottom).offset(15);
        make.height.mas_equalTo(kFit(45));
    }];
    [_thirdView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view).offset(0);
        make.top.equalTo(_secondView.mas_bottom).offset(15);
        make.height.mas_equalTo(kFit(45));
    }];
    [self.defaultView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view).offset(0);
        make.top.equalTo(_thirdView.mas_bottom).offset(15);
        make.height.mas_equalTo(kFit(45));
    }];
    
    [self.remindLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.defaultView.mas_bottom).offset(10);
        make.height.mas_equalTo(kFit(35));
    }];
    
}



- (void)chooseClothesAction {
    [_firstView ChooseClothesBtnBlock:^{
        _ChooseID = @"1";
        [self createLineOnePickViewWithArray:kClothesSize];
        NSLog(@"第一件衣服");
    } shoesBtnBlock:^{
        _ChooseID = @"1";
        [self createLineOnePickViewWithArray:kShoesSize];
        NSLog(@"第一件鞋子");
    } bagBtnBlock:^{
        NSLog(@"第一件包包");
    } accBtnBlock:^{
        NSLog(@"第一件配饰");
    }];
    
    [_secondView ChooseClothesBtnBlock:^{
        _ChooseID = @"2";
        [self createLineOnePickViewWithArray:kClothesSize];
        NSLog(@"第二件衣服");
    } shoesBtnBlock:^{
        _ChooseID = @"2";
        [self createLineOnePickViewWithArray:kShoesSize];
        NSLog(@"第二件鞋子");
    } bagBtnBlock:^{
        NSLog(@"第二件包包");
    } accBtnBlock:^{
        NSLog(@"第二件配饰");
    }];

    [_thirdView ChooseClothesBtnBlock:^{
        _ChooseID = @"3";
        [self createLineOnePickViewWithArray:kClothesSize];
        NSLog(@"第三件衣服");
    } shoesBtnBlock:^{
        _ChooseID = @"3";
        [self createLineOnePickViewWithArray:kShoesSize];
        NSLog(@"第三件鞋子");
    } bagBtnBlock:^{
        NSLog(@"第三件包包");
    } accBtnBlock:^{
        NSLog(@"第三件配饰");
    }];
}


#pragma mark --------------- LHPickViewDelegate  -------------
//选中pickview走的回调
- (void)toobarDonBtnHaveClick:(LHPickView *)pickView resultString:(NSString *)resultString resultIndex:(NSInteger) index {
    if ([_ChooseID isEqualToString:@"1"]) {
        
        [_firstView.sizeBtn setTitle:resultString forState:(UIControlStateNormal)];
        [_firstView.sizeBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
    } else if ([_ChooseID isEqualToString:@"2"]) {
        
        [_secondView.sizeBtn setTitle:resultString forState:(UIControlStateNormal)];
        [_secondView.sizeBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
    } else if ([_ChooseID isEqualToString:@"3"]) {
        
        [_thirdView.sizeBtn setTitle:resultString forState:(UIControlStateNormal)];
        [_thirdView.sizeBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
    }
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
