//
//  LHAccountCenterViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/31.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHAccountCenterViewController.h"
#import "LHAccountCenterCell.h"
#import "LHAccountCenterHeaderFooterView.h"
#import "LHReceiveAddressViewController.h"
#import "LHPayWayView.h"
#import "Order.h"
#import "RSADataSigner.h"
#import "LHPayResultsViewController.h"
#import "LHLeBaiViewController.h"


typedef NS_ENUM(NSInteger, PayType) {
    PayWithLBFPayType = 0,
    PayWithAliPayType,
    PayWithWXPayType,
    PayWithUnionPayType
};
@interface LHAccountCenterViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *orderTableView;

@property (nonatomic, assign) NSInteger payType;

@property (nonatomic, strong) LHAccountCenterHeaderView *headerView;

@property (nonatomic, strong) NSMutableArray *shoppingCartIDArray;
//存储请求到的店铺
@property (nonatomic, strong) NSMutableArray *storeArray;
//总价格
@property (nonatomic, strong) UILabel *allPriceLabel;

//地址ID
@property (nonatomic, copy) NSString *address_id;


@end

@implementation LHAccountCenterViewController
- (NSMutableArray *)storeArray {
    if (!_storeArray) {
        self.storeArray = [NSMutableArray new];
    }
    return _storeArray;
}
- (NSMutableArray *)shoppingCartIDArray {
    if (!_shoppingCartIDArray) {
        self.shoppingCartIDArray = [NSMutableArray new];
        for (LHCartGoodsModel *model in self.goodsModelArray) {
            [self.shoppingCartIDArray addObject:model.shoppingcar_id];
        }
    }
    return _shoppingCartIDArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self createOrderTableView];
    [self setHBK_NavigationBar];
    [self setBottomView];
    [self setDefualtPayType];
    
    [self requestAddressDefaultListData];
}


#pragma mark --------------------  网络请求 --------------------

//请求默认地址
- (void)requestAddressDefaultListData {
    [self showProgressHUD];
    [LHNetworkManager requestForGetWithUrl:kAddressListUrl parameter:@{@"user_id": kUser_id, @"isdefault": @1} success:^(id reponseObject) {
        NSLog(@"=============%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            for (NSDictionary *dic in reponseObject[@"data"]) {
                LHAddressModel *model = [[LHAddressModel alloc] init];
                model.isdefault = [NSString stringWithFormat:@"%@", dic[@"isdefault"]];
                [model setValuesForKeysWithDictionary:dic];
                self.address_id = [NSString stringWithFormat:@"%@", model.id_];
                NSLog(@"地址ID-------- %@", model.id_);
                self.headerView.isUpdateFrame = YES;
                self.headerView.nameLabel.text = [NSString stringWithFormat:@"收件人: %@", model.name];
                self.headerView.phoneLabel.text = model.mobile;
                self.headerView.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@", model.province, model.city, model.district, model.detail_address];
                self.headerView.frame = CGRectMake(0, 0, kScreenWidth, kFit(85));
                [self.orderTableView reloadData];
            }
            
            [self requestAccountOrderData];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"请求错误"];
            });
        
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideProgressHUD];
        });
        
    } failure:^(NSError *error) {
        
    }];
}

//订单列表
- (void)requestAccountOrderData {
    [self showProgressHUD];
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc] init];
    
    if (self.goodsModelArray.count > 0) {
        //拼接字符数组
        NSMutableString *ids = [NSMutableString stringWithString:@"["];
        for (LHCartGoodsModel *model in self.goodsModelArray) {
            [ids appendFormat:@"'%@',",model.shoppingcar_id];
        }
        NSString *idStr = [NSString stringWithFormat:@"%@]",[ids substringWithRange:NSMakeRange(0, [ids length]-1)]];
        //核心代码
        //将字符数组装入参数字典中
        [paramsDict setObject:idStr forKey:@"shoppingcar_id"];
    }
    if (self.productInfoDic) {
        [paramsDict setObject:self.productInfoDic[@"id"] forKey:@"product_id"];
        [paramsDict setObject:self.spec_id forKey:@"spec_id"];
        
    }
    [LHNetworkManager requestForGetWithUrl:kAccOrderUrl parameter:paramsDict success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            for (NSDictionary *dic in reponseObject[@"data"]) {
                LHAccountStoreModel *model = [[LHAccountStoreModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [model configerGoodsArrayWithArray:dic[@"products"]];
                [self.storeArray addObject:model];
            }
            self.allPriceLabel.text = [NSString stringWithFormat:@"总计: %.2f", [reponseObject[@"totalprice"] floatValue]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideProgressHUD];
            [self.orderTableView reloadData];
            
        });
        
    } failure:^(NSError *error) {
        
    }];
}

//提交订单
- (void)requestSubmitOrderData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showProgressHUDWithTitle:@"提交订单"];
    });
    NSString *products = nil;
    if (self.goodsModelArray) {
        //type-->0新品购买,1租赁
        //pay_way 0信用卡分期 1支付宝  2微信支付  3银联
        NSMutableArray *arr = [NSMutableArray new];
        for (LHCartGoodsModel *model in self.goodsModelArray) {
            NSMutableString *ids = [NSMutableString stringWithString:@"{"];
            [ids appendFormat:@"\"count\":\"%ld\",\"product_id\":\"%@\",\"price_lfeel\":\"%@\",\"spec_id\":\"%@\",\"shop_id\":\"%@\"", (long)model.count, model.product_id, model.price_lfeel, model.spec_id, model.shop_id];
            NSString *idStr = [NSString stringWithFormat:@"%@}",[ids substringWithRange:NSMakeRange(0, [ids length])]];
            [arr addObject:idStr];
        }
        NSMutableString *ids = [NSMutableString stringWithString:@"["];
        for (NSString *aStr in arr) {
            [ids appendFormat:@"%@,", aStr];
        }
        products = [NSString stringWithFormat:@"%@]",[ids substringWithRange:NSMakeRange(0, [ids length]-1)]];
        //    NSLog(@"-products------%@", products);
    }
    if (self.productInfoDic) {
        products = [NSString stringWithFormat:@"[{\"count\":\"1\",\"product_id\":\"%@\",\"price_lfeel\":\"%@\",\"spec_id\":\"%@\", \"shop_id\":\"%@\"}]", self.productInfoDic[@"id"], self.productInfoDic[@"price_lfeel"], self.spec_id, self.productInfoDic[@"shop_id"]];
    }
    //核心代码
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc] init];
    //将字符数组装入参数字典中
    [paramsDict setObject:products forKey:@"products"];
    [paramsDict setObject:@0 forKey:@"type"];
    [paramsDict setObject:self.address_id forKey:@"address_id"];
    [paramsDict setObject:kUser_id forKey:@"user_id"];
    [paramsDict setObject:@"[1,2]" forKey:@"privilege_ids"];
    [paramsDict setObject:@(self.payType) forKey:@"pay_way"];
    [LHNetworkManager PostWithUrl:kSubmitOrderUrl parameter:paramsDict success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
           dispatch_async(dispatch_get_main_queue(), ^{
               [self hideProgressHUD];
               [[NSNotificationCenter defaultCenter] postNotificationName:@"AddShoppingCartSuccess" object:nil];
               if ([reponseObject[@"data"][@"pay_way"] integerValue] == 0) {
                   LHLeBaiViewController *LBFVC = [[LHLeBaiViewController alloc] init];
                   
                   [self.navigationController pushViewController:LBFVC animated:YES];
                   
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



#pragma mark  -----------------  UI  ------------------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"结算中心" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)createOrderTableView {
    self.orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-kTabBarHeight) style:(UITableViewStyleGrouped)];
    self.orderTableView.delegate = self;
    self.orderTableView.dataSource = self;
    [self.view addSubview:self.orderTableView];
    
    self.headerView = [[LHAccountCenterHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kFit(50))];
    @weakify(self);
    self.headerView.clickHeaderViewBlock = ^{
        @strongify(self);
        LHReceiveAddressViewController *receiveVC = [[LHReceiveAddressViewController alloc] init];
        receiveVC.addressBlock = ^(LHAddressModel *model) {
            self.address_id = [NSString stringWithFormat:@"%@", model.id_];
            NSLog(@"地址ID-------- %@", model.id_);
            self.headerView.isUpdateFrame = YES;
            self.headerView.nameLabel.text = [NSString stringWithFormat:@"收件人: %@", model.name];
            self.headerView.phoneLabel.text = model.mobile;
            self.headerView.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@", model.province, model.city, model.district, model.detail_address];
          
            self.headerView.frame = CGRectMake(0, 0, kScreenWidth, kFit(85));
            [self.orderTableView reloadData];
            
        };
        [self.navigationController pushViewController:receiveVC animated:YES];
    };
    self.orderTableView.tableHeaderView = self.headerView;
    
    LHAccountCenterFooterView *footerView = [LHAccountCenterFooterView creatView];
    footerView.frame = CGRectMake(0, 0, kScreenWidth, kFit(140));
    footerView.payTypeBlock = ^(UILabel *label) {
        [self setPayViewWithLabel:label];
    };
    footerView.AgreeDelegateBlock = ^{
        NSLog(@"同意");
        
    };
    
    self.orderTableView.tableFooterView = footerView;
}

/*
 总金额  付款
 */
- (void)setBottomView {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.orderTableView.maxY, kScreenWidth, kTabBarHeight)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UIButton *submitBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    submitBtn.backgroundColor = [UIColor redColor];
    submitBtn.frame = CGRectMake(kScreenWidth/3*2, 0, kScreenWidth/3, kTabBarHeight);
    submitBtn.titleLabel.font = kFont(15);
    [submitBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:(UIControlEventTouchUpInside)];
    [bgView addSubview:submitBtn];
    
    UILabel *allPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/3*2-15, kTabBarHeight)];
//    allPriceLabel.text = @"总计: 1000.00";
    allPriceLabel.textAlignment = NSTextAlignmentRight;
    self.allPriceLabel = allPriceLabel;
    self.allPriceLabel.textColor = [UIColor redColor];
    [bgView addSubview:allPriceLabel];

    
}



//选择付款方式
- (void)setPayViewWithLabel:(UILabel *)label {
    LHPayWayView *payView = [[LHPayWayView alloc] initWithIndex:self.payType];
    [payView clickPayWayBlock:^(NSInteger index) {
        NSLog(@"%ld", (long)index);
        self.payType = index;
        if (0 == index) {
         label.text = @"信用卡分期";
        } else if (1 == index) {
         label.text = @"支付宝";
        } else if (2 == index) {
         label.text = @"微信支付";
        } else {
         label.text = @"银联支付";
        }
    }];
    [payView show];
}


#pragma mark  ---------------------- Aciton -------------
- (void)submitAction {
    NSLog(@"提交");
    kVerifyText(self.address_id.length, @"请选择地址");
    [self requestSubmitOrderData];

}
/*
 默认的付款方式
 */
- (void)setDefualtPayType {
    self.payType = PayWithAliPayType;
}

#pragma mark --------------  <UITableViewDelegate, UITableViewDataSource> -------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.storeArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LHAccountStoreModel *model = self.storeArray[section];
    return model.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"LHAccountGoodsCell";
    LHAccountGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LHAccountGoodsCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    LHAccountStoreModel *storeModel = self.storeArray[indexPath.section];
    LHAccountGoodsModel *goodsModel = [storeModel.products objectAtIndex:indexPath.row];
    [cell reloadDataWithModel:goodsModel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kFit(80);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kFit(40);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kFit(120);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LHAccountSectionHeaderView *view = [[LHAccountSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kFit(40))];
    LHAccountStoreModel *model = self.storeArray[section];
    view.titleLabel.text = model.shopname;
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    LHAccountSectionFooterView *footerView = [LHAccountSectionFooterView creatView];
    footerView.frame = CGRectMake(0, 0, kScreenWidth, kFit(120));
    footerView.CheaperCardBlock = ^{
        NSLog(@"优惠券");
    };
    LHAccountStoreModel *model = self.storeArray[section];
    footerView.shopAllPriceLabel.text = [NSString stringWithFormat:@"总共 %@ 件商品, 共 %.2f 元", model.product_count, model.shop_total_money];
    return footerView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
