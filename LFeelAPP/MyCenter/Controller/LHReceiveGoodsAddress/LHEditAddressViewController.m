//
//  LHEditAddressViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/20.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHEditAddressViewController.h"
#import "LHCityChooseView.h"
@interface LHEditAddressViewController ()<UIPickerViewDelegate>


@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *detailAddressTF;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;


@property (nonatomic, copy) NSString *province;//省
@property (nonatomic, copy) NSString *city;//市
@property (nonatomic, copy) NSString *area;//区

//是否默认
@property (weak, nonatomic) IBOutlet UISwitch *defaultSwitch;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@end

@implementation LHEditAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view rm_fitAllConstraint];
    self.topConstraint.constant = kNavBarHeight-10;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    if (self.addressModel) {
        [self setHBK_NavigationBarWithTitle:@"修改地址"];
        self.nameTF.text = self.addressModel.name;
        self.phoneTF.text = self.addressModel.mobile;
        self.detailAddressTF.text = self.addressModel.detail_address;
        [self.addressBtn setTitle:[NSString stringWithFormat:@"%@%@%@", self.addressModel.province, self.addressModel.city, self.addressModel.district] forState:(UIControlStateNormal)];
        self.defaultSwitch.on = [self.addressModel.isdefault integerValue] == 1 ? YES : NO;
    } else {
        NSLog(@"添加地址");
        [self setHBK_NavigationBarWithTitle:@"添加地址"];
    }
    
    
}
#pragma mark ----------- UI -----------
- (void)setHBK_NavigationBarWithTitle:(NSString *)title {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:title backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark ------------- Action --------------
//保存地址
- (IBAction)submitBtnAction:(UIButton *)sender {
    kVerifyText(self.nameTF.text.length, @"请输入姓名");
    kVerifyPhone(self.phoneTF.text, @"请输入正确手机号");
    if (!self.province || !self.city || !self.area) {
        dispatch_async(dispatch_get_main_queue(), ^{
            kShowError(@"请选择省市区");
        });
    }
    kVerifyText(self.detailAddressTF.text.length, @"请输入详细地址");
    if (self.addressModel) {
        [self requestUpdateAddressData];
    } else {
        [self requestAddAddressData];
    }
}

- (IBAction)chooseAddress:(UIButton *)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    LHCityChooseView * cityView = [[LHCityChooseView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    cityView.selectedBlock = ^(NSString * province, NSString * city, NSString * area){
        self.province = province;
        self.city = city;
        self.area = area;
        NSLog(@"%@%@%@",province,city,area);
        [self.addressBtn setTitle:[NSString stringWithFormat:@"%@%@%@", province, city, area] forState:(UIControlStateNormal)];
        [self.addressBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    };
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview: cityView];
    [window bringSubviewToFront:cityView];
}


// 回收键盘
- (IBAction)handleEmptyView:(UITapGestureRecognizer *)sender {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}


#pragma  mark ----------------- 网络请求 --------------
//添加地址
- (void)requestAddAddressData {
    //地址是否默认   先默认为0 (不是默认)
    NSInteger isDefault = self.defaultSwitch.on == YES ? 1 : 0;
    NSDictionary *dic = @{@"user_id": kUser_id,
                          @"province": self.province,
                          @"city": self.city,
                          @"district": self.area,
                          @"mobile": self.phoneTF.text,
                          @"detail_address": self.detailAddressTF.text,
                          @"isdefault":@(isDefault),
                          @"name": self.nameTF.text};
    [LHNetworkManager PostWithUrl:kAddAddressUrl parameter:dic success:^(id reponseObject) {
        NSLog(@"-----------%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:@"添加成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (self.SubmitBlock) {
                        self.SubmitBlock();
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                });
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"参数错误"];
            });
        }
    } failure:^(NSError *error) {
        
    }];
}


//修改地址
- (void)requestUpdateAddressData {
    //地址是否默认   先默认为0 (不是默认)
    NSInteger isDefault = self.defaultSwitch.on == YES ? 1 : 0;
    NSString *AProvince = nil, *ACity = nil, *AArea = nil;
    if (self.province || self.city || self.area) {
        AProvince = self.province;
        ACity = self.city;
        AArea = self.area;
    } else {
        AProvince = self.addressModel.province;
        ACity = self.addressModel.city;
        AArea = self.addressModel.district;
    }
    NSDictionary *dic = @{@"user_id": kUser_id, @"province": AProvince, @"city": ACity, @"district": AArea, @"mobile": self.phoneTF.text, @"detail_address": self.detailAddressTF.text, @"isdefault":@(isDefault), @"name": self.nameTF.text, @"id": self.addressModel.id_};
    [LHNetworkManager PostWithUrl:kAddressUpdateUrl parameter:dic success:^(id reponseObject) {
        NSLog(@"-----------%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:@"修改成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (self.SubmitBlock) {
                        self.SubmitBlock();
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                });
            });
        } else {
            [MBProgressHUD showError:@"参数错误"];
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
