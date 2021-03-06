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

@property (nonatomic, assign) CGFloat allPrice;

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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WX_PaySuccess" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PayError" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self createOrderTableView];
    [self setHBK_NavigationBar];
    [self setBottomView];
    [self setDefualtPayType];
    [self addNotification];
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
            self.allPrice = [reponseObject[@"totalprice"] floatValue];
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
        [self showProgressHUDWithTitle:@"提交订单中"];
    });
    NSString *products = nil;
    //如果是购物车过来的
    if (self.goodsModelArray) {
        //type-->0新品购买,1租赁
        //pay_way 0信用卡分期 1支付宝  2微信支付  3银联
        NSMutableArray *arr = [NSMutableArray new];
        for (LHCartGoodsModel *model in self.goodsModelArray) {
            NSMutableString *ids = [NSMutableString stringWithString:@"{"];
            [ids appendFormat:@"\"count\":\"%ld\",\"product_id\":\"%@\",\"spec_id\":\"%@\",\"shop_id\":\"%@\"", (long)model.count, model.product_id, model.spec_id, model.shop_id];
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
    //如果是详情的
    if (self.productInfoDic) {
        products = [NSString stringWithFormat:@"[{\"count\":\"1\",\"product_id\":\"%@\",\"spec_id\":\"%@\", \"shop_id\":\"%@\"}]", self.productInfoDic[@"id"], self.spec_id, self.productInfoDic[@"shop_id"]];
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
                   //乐百分支付
                   dispatch_async(dispatch_get_main_queue(), ^{
                       [self showProgressHUDWithTitle:@"提交成功, 去付款"];
//                       [MBProgressHUD showSuccess:@"提交成功, 去付款"];
                   });
                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       [self hideProgressHUD];
                       LHLeBaiViewController *LBFVC = [[LHLeBaiViewController alloc] init];
                       LBFVC.orderDic = reponseObject[@"data"];
                       [self.navigationController pushViewController:LBFVC animated:YES];
                   });
                   
               } else if ([reponseObject[@"data"][@"pay_way"] integerValue] == 1) {
                   //支付宝支付
                   [self payForAliPay:reponseObject[@"data"][@"data"]];
               } else if ([reponseObject[@"data"][@"pay_way"] integerValue] == 2) {
                   //微信支付
                   [self payForWXPay:reponseObject[@"data"][@"data"]];
               } else if ([reponseObject[@"data"][@"pay_way"] integerValue] == 3) {
                   //银联支付
                   
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


#pragma mark  -----------------  UI  ------------------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"结算中心" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)createOrderTableView {
    self.orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight-kNavBarHeight-kTabBarHeight) style:(UITableViewStyleGrouped)];
    self.orderTableView.delegate = self;
    self.orderTableView.dataSource = self;
    [self.view addSubview:self.orderTableView];
    
    self.headerView = [[LHAccountCenterHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kFit(50))];
    kWeakSelf(self);
    self.headerView.clickHeaderViewBlock = ^{
         kStrongSelf(self);
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
 总金额  付款/提交
 */
- (void)setBottomView {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.orderTableView.maxY, kScreenWidth, kTabBarHeight)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UIButton *submitBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    submitBtn.backgroundColor = [UIColor redColor];
    submitBtn.frame = CGRectMake(kScreenWidth/3*2, 0, kScreenWidth/3, bgView.height);
    submitBtn.titleLabel.font = kFont(15);
    [submitBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:(UIControlEventTouchUpInside)];
    [bgView addSubview:submitBtn];
    
    UILabel *allPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/3*2-15, bgView.height)];
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

/**
 提交订单
 */
- (void)submitAction {
    NSLog(@"提交");
    kVerifyText(self.address_id.length, @"请选择地址");
    if (self.payType != 0) {
        [self requestSubmitOrderData];
    } else {
        if (self.allPrice < 600) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"分期最小金额为600元"];
            });
        } else {
            [self requestSubmitOrderData];
        }
    }
}
/*
 默认的付款方式
 */
- (void)setDefualtPayType {
    self.payType = PayWithAliPayType;
}

- (void)addNotification {
    //微信跳转到成功的界面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToSuccessPayResultVC) name:@"WX_PaySuccess" object:nil];
    
    //取消支付(进入待支付订单界面)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToErrorPayResultVC) name:@"PayError" object:nil];
}

//支付成功
- (void)goToSuccessPayResultVC {
    LHPayResultsViewController *payResultVC = [[LHPayResultsViewController alloc] init];
    payResultVC.payType = 2;
    payResultVC.payResultStr = @"Success";
    [self.navigationController pushViewController:payResultVC animated:YES];
}
//支付失败
- (void)goToErrorPayResultVC {
    LHPayResultsViewController *payResultVC = [[LHPayResultsViewController alloc] init];
    payResultVC.payType = 2;
    payResultVC.payResultStr = @"Error";
    [self.navigationController pushViewController:payResultVC animated:YES];
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
    NSLog(@"点击了~");
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
