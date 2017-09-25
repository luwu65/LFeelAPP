//
//  LHAddVipViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/19.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHAddVipViewController.h"
#import "LHPayWayView.h"
#import "LHPayResultsViewController.h"
typedef NS_ENUM(NSInteger, PayType) {
    PayWithLBFPayType = 0,
    PayWithAliPayType,
    PayWithWXPayType,
    PayWithUnionPayType
};

@interface LHAddVipViewController ()

@property (nonatomic, assign) BOOL isClick;
@property (nonatomic, strong) CustomButton *halfYearBtn;
@property (nonatomic, strong) CustomButton *yearBtn;
@property (nonatomic, assign) NSInteger payType;
@property (nonatomic, strong) NSMutableArray<LHAddVipModel *> *vipArray;

@property (nonatomic, strong) NSMutableDictionary *goodsInfoDic;

@property (nonatomic, assign) NSInteger clickIndex;

@end

@implementation LHAddVipViewController

- (NSMutableDictionary *)goodsInfoDic {
    if (!_goodsInfoDic) {
        self.goodsInfoDic = [NSMutableDictionary new];
    }
    return _goodsInfoDic;
}

- (NSMutableArray *)vipArray {
    if (!_vipArray) {
        self.vipArray = [NSMutableArray new];
    }
    return _vipArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.isClick = NO;
    [self setUI];
    [self requestAddVipData];
    [self setDefualtPayType];
}


#pragma mark -------------- UI ------------------
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
    
    self.yearBtn = [[CustomButton alloc] initWithVipBtnFrame:CGRectZero];
    [self.yearBtn addTarget:self action:@selector(yearBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bgImageView addSubview:self.yearBtn];
    [self.yearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.top.equalTo(cLabel.mas_bottom).offset(30*kRatio);
        make.height.mas_offset(80);
    }];
    
    
    self.halfYearBtn = [[CustomButton alloc] initWithVipBtnFrame:CGRectZero];
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

#pragma mark  -------------- Action -----------
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
    
    self.clickIndex = 0;
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
    self.clickIndex = 1;
}

//立即购买
- (void)buyVipAction {
    [self setPayViewWithLabel:nil];
    
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ------------- 网络请求 -------------------
- (void)requestAddVipData {
    [self showProgressHUD];
    [LHNetworkManager requestForGetWithUrl:kGoodsDetailUrl parameter:@{@"id": @4, @"user_id": kUser_id} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            for (NSDictionary *dic in reponseObject[@"data"][@"property_value"]) {
                NSLog(@"%@ <<<-----------", dic);
                LHAddVipModel *model = [[LHAddVipModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.vipArray addObject:model];
            }
            
            self.goodsInfoDic = reponseObject[@"data"][@"productInfo"];
        }
        
        LHAddVipModel *aModel = self.vipArray.firstObject;
        self.yearBtn.allMoneyLabel.text = [NSString stringWithFormat:@"¥%@", aModel.price];
        self.yearBtn.mouthMoneyLabel.text = [NSString stringWithFormat:@"分期: ¥%ld/月", [aModel.price integerValue]/[aModel.property_value integerValue]];
        self.yearBtn.timeLabel.text = [NSString stringWithFormat:@"%@个月", aModel.property_value];
        
        
        LHAddVipModel *bModel = self.vipArray.lastObject;
        self.halfYearBtn.allMoneyLabel.text = [NSString stringWithFormat:@"¥%@", bModel.price];
        self.halfYearBtn.mouthMoneyLabel.text = [NSString stringWithFormat:@"分期: ¥%ld/月", [bModel.price integerValue]/[bModel.property_value integerValue]];
        self.halfYearBtn.timeLabel.text = [NSString stringWithFormat:@"%@个月", bModel.property_value];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideProgressHUD];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}


//提交订单
- (void)requestSubmitOrderData{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showProgressHUDWithTitle:@"提交订单"];
    });
    LHAddVipModel *model = self.vipArray[self.clickIndex];
    
    NSString * products = [NSString stringWithFormat:@"[{\"count\":\"1\",\"product_id\":\"%@\",\"price_lfeel\":\"%@\",\"spec_id\":\"%@\", \"shop_id\":\"%@\"}]", self.goodsInfoDic[@"id"], model.price, model.spec_id, self.goodsInfoDic[@"shop_id"]];
    //核心代码
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc] init];
    //将字符数组装入参数字典中
    [paramsDict setObject:products forKey:@"products"];
    [paramsDict setObject:@0 forKey:@"type"];
    [paramsDict setObject:@1 forKey:@"address_id"];
    [paramsDict setObject:kUser_id forKey:@"user_id"];
//    [paramsDict setObject:@"[1,2]" forKey:@"privilege_ids"];/
    [paramsDict setObject:@(self.payType) forKey:@"pay_way"];
    [LHNetworkManager PostWithUrl:kSubmitOrderUrl parameter:paramsDict success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideProgressHUD];
                if ([reponseObject[@"data"][@"pay_way"] integerValue] == 0) {
                    
                    
                } else if ([reponseObject[@"data"][@"pay_way"] integerValue] == 1) {
                    
                    [self payForAliPay:reponseObject[@"data"][@"data"]];
                    
                } else if ([reponseObject[@"data"][@"pay_way"] integerValue] == 2) {
                    NSData *jsonData = [reponseObject[@"data"][@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
                    NSLog(@"--------->>> %@", dic);
                    [self payForWXPay:dic];
                } else if ([reponseObject[@"data"][@"pay_way"] integerValue] == 3) {
                    
                }
                
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideProgressHUD];
            });
        }
    } failure:^(NSError *error) {
        
    }];
}



//选择付款方式
- (void)setPayViewWithLabel:(UILabel *)label {
    LHPayWayView *payView = [[LHPayWayView alloc] initWithIndex:self.payType];
    [payView clickPayWayBlock:^(NSInteger index) {
        NSLog(@"%ld", (long)index);
        self.payType = index;
        if (0 == index) {
            label.text = @"信用卡分期";
            [self requestSubmitOrderData];
            
        } else if (1 == index) {
            label.text = @"支付宝";
            [self requestSubmitOrderData];
            
        } else if (2 == index) {
            label.text = @"微信支付";
            [self requestSubmitOrderData];
            
        } else {
            label.text = @"银联支付";
            [self requestSubmitOrderData];
            
            
        }
    }];
    [payView show];
}


/*
 默认的付款方式
 */
- (void)setDefualtPayType {
    self.payType = PayWithAliPayType;
}


#pragma mark  --------------- 支付方式 --------------------

/*
 返回码 	含义
 9000 	订单支付成功
 8000 	正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
 4000 	订单支付失败
 5000 	重复请求
 6001 	用户中途取消
 6002 	网络连接出错
 6004 	支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
 其它 	其它支付错误
 */
//支付宝支付
- (void)payForAliPay:(NSString *)dataString {
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:dataString fromScheme:@"lfeelios" callback:^(NSDictionary *resultDic) {
        LHPayResultsViewController *payResultVC = [[LHPayResultsViewController alloc] init];
        NSLog(@"reslut = %@",resultDic);
        if ([resultDic[@"resultStatus"] integerValue] == 9000) {
            NSLog(@"支付成功了~~~~~~~~~~~~~哈哈哈哈哈~~~~~~~~~~~~`");
            NSData *jsonData = [resultDic[@"result"] dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingAllowFragments) error:nil];
            NSLog(@"%@", dic);
            payResultVC.resultDic = dic;
        } else if ([resultDic[@"resultStatus"] integerValue] == 6001) {
            NSLog(@"中途取消了, 跳转到支付失败的页面");
            
            
        } else if ([resultDic[@"resultStatus"] integerValue] == 5000) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"请勿重复发起订单"];
            });
        }
        payResultVC.payType = 1;
        payResultVC.payResultStr = [NSString stringWithFormat:@"%@", resultDic[@"resultStatus"]];
        [self.navigationController pushViewController:payResultVC animated:YES];
    }];
}

//微信支付
- (void)payForWXPay:(NSDictionary *)dic {
    PayReq *payreq = [[PayReq alloc] init];
    payreq.partnerId = dic[@"mch_id"];
    payreq.prepayId = dic[@"prepay_id"];
    payreq.nonceStr = dic[@"nonce_str"];
    payreq.timeStamp = [dic[@"timestamp"] intValue];
    payreq.package = dic[@"package"];
    payreq.sign = dic[@"sign"];
    
    [WXApi sendReq:payreq];
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