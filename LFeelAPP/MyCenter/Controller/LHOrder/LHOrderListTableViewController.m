//
//  LHOrderListTableViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/22.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHOrderListTableViewController.h"
#import "LHAccountCenterCell.h"
#import "LHOrderHeaderFooterView.h"
#import "LHOrderModel.h"
#import "LHPayWayView.h"
#import "LHLeBaiViewController.h"
#import "LHEditCommentViewController.h"
#import "LHPayResultsViewController.h"

@interface LHOrderListTableViewController ()
@property (nonatomic, strong) NSMutableArray *storeArray;

@property (nonatomic, strong) MBProgressHUD *HUD;

@property (nonatomic, strong) UIView *emptyView;

@property (nonatomic, assign) NSInteger page;

@end

@implementation LHOrderListTableViewController

- (NSMutableArray *)storeArray {
    if (!_storeArray) {
        self.storeArray = [NSMutableArray new];
    }
    return _storeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = kColor(245, 245, 245);
    [self.tableView registerClass:[LHAccountGoodsCell class] forCellReuseIdentifier:@"LHAccountGoodsCell"];
    
    [self requestMyOrderListWithType:self.type page:1];
    self.page = 1;
    
    @weakify(self);
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"%ld", self.page);
        [self requestMyOrderListWithType:self.type page:self.page];
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.storeArray removeAllObjects];
        [self requestMyOrderListWithType:self.type page:1];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark ------------------------------ Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.storeArray.count < 5) {
        self.tableView.mj_footer.hidden = YES;
    } else {
        self.tableView.mj_footer.hidden = NO;
    }
    return self.storeArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LHOrderModel *model = self.storeArray[section];
    return model.products.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHAccountGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHAccountGoodsCell" forIndexPath:indexPath];
    LHOrderModel *model = self.storeArray[indexPath.section];
    LHOrderProductModel *productModel = model.products[indexPath.row];
    [cell reloadDataWithLHOrderProductModel:productModel];
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LHOrderHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LHOrderHeaderView"];
    if (!headerView) {
        headerView = [[LHOrderHeaderView alloc] initWithReuseIdentifier:@"LHOrderHeaderView"];
    }
    LHOrderModel *model = self.storeArray[section];
    headerView.shopLabel.text = model.shopname;
    [headerView.shopImageview sd_setImageWithURL:kURL(model.shop_logo) placeholderImage:kImage(@"")];
    if ([model.status integerValue] == 0) {
        headerView.statusLabel.text = @"待付款";
        
    } else if ([model.status integerValue] == 1) {
        headerView.statusLabel.text = @"待发货";
        
    } else if ([model.status integerValue] == 2) {
        headerView.statusLabel.text = @"待收货";

        
    } else {
        
        
    }
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    LHOrderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LHOrderFooterView"];
//    if (!footerView) {
//        footerView = [[LHOrderFooterView alloc] initWithReuseIdentifier:@"LHOrderFooterView"];
//    }
    LHOrderFooterView *footerView = [[LHOrderFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    LHOrderModel *model = self.storeArray[section];
    footerView.allLabel.text = [NSString stringWithFormat:@"总共%@件商品, 共%@元(运费到付)", model.shop_count, model.shop_price];
    
    if ([model.status integerValue] == 0) {//待付款
        [footerView.leftBtn setTitle:@"取消订单" forState:(UIControlStateNormal)];
        [footerView.leftBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        footerView.leftBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        footerView.leftBtn.layer.borderWidth = 1;
        [footerView.rightBtn setTitle:@"去支付" forState:(UIControlStateNormal)];
        [footerView.rightBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        footerView.rightBtn.backgroundColor = [UIColor redColor];
    } else if ([model.status integerValue] == 1) {//待发货
        footerView.bottomView.hidden = YES;
    } else if ([model.status integerValue] == 2) {//待收货
        [footerView.leftBtn setTitle:@"查看物流" forState:(UIControlStateNormal)];
        [footerView.leftBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        footerView.leftBtn.layer.borderColor = [UIColor redColor].CGColor;
        footerView.leftBtn.layer.borderWidth = 1;
        [footerView.rightBtn setTitle:@"确认收货" forState:(UIControlStateNormal)];
        [footerView.rightBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        footerView.rightBtn.backgroundColor = [UIColor redColor];
    } else if ([model.status integerValue] == 3) {//已收货\待收货
        [footerView.leftBtn setTitle:@"删除订单" forState:(UIControlStateNormal)];
        [footerView.leftBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        footerView.leftBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        footerView.leftBtn.layer.borderWidth = 1;
        [footerView.rightBtn setTitle:@"评价" forState:(UIControlStateNormal)];
        [footerView.rightBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        footerView.rightBtn.backgroundColor = [UIColor redColor];
        
        
    } else if ([model.status integerValue] == 4) {
        
    } else if ([model.status integerValue] == 5) {
        
    } else if ([model.status integerValue] == 6) {
        
    }

    footerView.ClickBtnBlock = ^(UIButton *sender) {
        NSLog(@"%@--------%ld", sender.titleLabel.text, section);
        if ([sender.titleLabel.text isEqualToString:@"去支付"]) {
            [self setPayViewWithLabel:nil section:section];
            
        } else if ([sender.titleLabel.text isEqualToString:@"取消订单"]) {
            [self showAlertViewWithTitle:@"确定要取消订单?" yes:@"确定" no:@"取消" yesHandler:^(UIAlertAction *action) {
                
            } noHandler:^(UIAlertAction *action) {
                
            }];
        } else if ([sender.titleLabel.text isEqualToString:@"查看物流"]) {
            
            
            
            
        } else if ([sender.titleLabel.text isEqualToString:@"确认收货"]) {
            [self showAlertViewWithTitle:@"确认您已收到货物?" yes:@"收到了" no:@"没有" yesHandler:^(UIAlertAction *action) {
                [self requestComfirmReceiveGoodsWithModel:self.storeArray[section]];
            } noHandler:^(UIAlertAction *action) {
                
            }];
        } else if ([sender.titleLabel.text isEqualToString:@"删除订单"]) {
            [self showAlertViewWithTitle:@"确认删除订单?" yes:@"确认" no:@"取消" yesHandler:^(UIAlertAction *action) {
                [self requestDeleteOrderWithModel:self.storeArray[section]];
            } noHandler:^(UIAlertAction *action) {
                
            }];
        } else if ([sender.titleLabel.text isEqualToString:@"评价"]) {
            LHEditCommentViewController *editCVC = [[LHEditCommentViewController alloc] init];
            editCVC.orderModel = self.storeArray[section];
            [self.navigationController pushViewController:editCVC animated:YES];
        }
        
    };
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kFit(80);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kFit(55);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    LHOrderModel *model = self.storeArray[section];
    if ([model.status integerValue] == 0) {//待付款
        return kFit(90);
    } else if ([model.status integerValue] == 1) {//待发货
        return kFit(45);
    } else if ([model.status integerValue] == 2) {//待收货
        return kFit(90);
    } else if ([model.status integerValue] == 3) {//已收货\待评价
        return kFit(90);
    } else if ([model.status integerValue] == 4) {
        return kFit(90);
    } else if ([model.status integerValue] == 5) {
        return kFit(90);
    } else {
        return kFit(90);
    }
}


#pragma mark ------------------ 网络请求 -------------------
//订单状态 0待付款 1待发货 2待收货 3已收货（完成） 4申请退换 5退换中 6退换完成
- (void)requestMyOrderListWithType:(NSInteger)type page:(NSInteger)page{
    [self showProgressHUDWithTitle:@"加载中..."];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:kUser_id forKey:@"user_id"];
    if (type != 0) {
        [dic setObject:@(type-1) forKey:@"status"];
    }
    [dic setObject:@(page) forKey:@"page"];
    [dic setObject:@0 forKey:@"level"];
//    [self.tableView.mj_footer resetNoMoreData];
    [LHNetworkManager requestForGetWithUrl:kOrderListUrl parameter:dic success:^(id reponseObject) {
        NSLog(@"----%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            for (NSDictionary *dic in reponseObject[@"data"]) {
                LHOrderModel *model = [[LHOrderModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [model configerGoodsArrayWithArray:dic[@"products"]];
                [self.storeArray addObject:model];
            }
            
            if (self.storeArray.count == 0) {
                [self emptyView];
            } else {
                [_emptyView removeFromSuperview];
            }
            
            self.page = [reponseObject[@"pageInfo"][@"page"] integerValue] + 1;
            
            if (page == [reponseObject[@"pageInfo"][@"total_page"] integerValue]) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView.mj_header endRefreshing];
                [self hideProgressHUD];
                [self.tableView reloadData];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                [self hideProgressHUD];
                [MBProgressHUD showError:@"请求错误"];
            });
        }
    } failure:^(NSError *error) {
        
    }];
}


/**
 重新付款提交订单
 */
- (void)requestSubmitOrderDataWithModel:(LHOrderModel *)model payType:(NSInteger)payType {
    [LHNetworkManager PostWithUrl:kLebaiPayUrl parameter:@{@"order_no": model.order_no, @"pay_way": @(payType)} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            if (payType == 1) {
                
                [self payForAliPay:reponseObject[@"data"]];
                
            } else if (payType == 2){
                
                [self payForWXPay:reponseObject[@"data"]];
                
            }
        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self reloadData];
//        });
        
    } failure:^(NSError *error) {
        
    }];
}

/**
 确认收货
 */
- (void)requestComfirmReceiveGoodsWithModel:(LHOrderModel *)model {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showProgressHUD];
    });
    
    [LHNetworkManager PostWithUrl:kComfirmGoodsUrl parameter:@{@"order_no": model.order_no, @"status": @3} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:@"确认收货!"];
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.mj_header beginRefreshing];
            [self hideProgressHUD];
        });
    } failure:^(NSError *error) {
        
    }];
}

/**
 删除订单
 */
- (void)requestDeleteOrderWithModel:(LHOrderModel *)model {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showProgressHUD];
    });
    [LHNetworkManager PostWithUrl:kComfirmGoodsUrl parameter:@{@"order_no": model.order_no, @"deleteStatus": @1} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:@"删除成功!"];
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.mj_header beginRefreshing];
            [self hideProgressHUD];
        });
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
- (void)payForWXPay:(NSString *)dataString {
    NSData *jsonData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"--------->>> %@", dic);
    
    PayReq *payreq = [[PayReq alloc] init];
    payreq.openID = dic[@"appid"];
    payreq.partnerId = dic[@"partnerid"];
    payreq.prepayId = dic[@"prepayid"];
    payreq.nonceStr = dic[@"noncestr"];
    payreq.timeStamp = [dic[@"timestamp"] intValue];
    payreq.package = dic[@"package"];
    payreq.sign = dic[@"sign"];
    
    [WXApi sendReq:payreq];
}


#pragma mark ------------- Action ---------------------
//选择付款方式
- (void)setPayViewWithLabel:(UILabel *)label section:(NSInteger)section {
    LHOrderModel *orderModel = self.storeArray[section];
    
    LHPayWayView *payView = [[LHPayWayView alloc] initWithIndex:-1];
    @weakify(self);
    [payView clickPayWayBlock:^(NSInteger index) {
        @strongify(self);
        NSLog(@"%ld", (long)index);
        if (0 == index) {
            if ([orderModel.shop_price floatValue] < 600) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:@"分期最小金额为600元"];
                });
            } else {
                LHLeBaiViewController *lebaiVC = [[LHLeBaiViewController alloc] init];
                lebaiVC.orderModel = orderModel;
                [self.navigationController pushViewController:lebaiVC animated:YES];
            }
        } else if (1 == index) {
            [self requestSubmitOrderDataWithModel:orderModel payType:1];
            
        } else if (2 == index) {
            [self requestSubmitOrderDataWithModel:orderModel payType:2];

            
        } else if (3 == index) {
            
        }
    }];
    [payView show];
}


///刷新
- (void)reloadData{
    self.needRefresh = NO;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark ------------------ 没有数据的时候 ---------------
- (UIView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-kFit(44))];
        _emptyView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_emptyView];
        
        UIImageView *emptyImageView = [[UIImageView alloc] initWithImage:kImage(@"MyCenter_NoOrder")];
        emptyImageView.frame = CGRectMake(kFit(100), kFit(60), kScreenWidth-kFit(200), kScreenWidth-kFit(200));
        [self.emptyView addSubview:emptyImageView];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, emptyImageView.maxY+kFit(20), kScreenWidth, 25)];
        textLabel.text = @"您还没有相关的订单";
        textLabel.font = kFont(15*kRatio);
        textLabel.textColor = [UIColor lightGrayColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        [self.emptyView addSubview:textLabel];
    }
    return _emptyView;
}



#pragma mark ------------------ HUD ------------------------
//懒加载
- (MBProgressHUD *)HUD {
    if (!_HUD) {
        self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
        self.HUD.bezelView.color = [UIColor colorWithWhite:0.0 alpha:1];
        self.HUD.contentColor = [UIColor whiteColor];
        self.HUD.animationType = MBProgressHUDAnimationFade;
        [self.view addSubview:_HUD];
    }
    return _HUD;
}

//显示loading动画
- (void)showProgressHUD {
    [self showProgressHUDWithTitle:nil];
}

//隐藏loading动画
- (void)hideProgressHUD {
    if (self.HUD != nil) {
        //移除并置空
        [self.HUD hideAnimated:YES];
        self.HUD = nil;
    }
}

//显示带有文字的loading
- (void)showProgressHUDWithTitle:(NSString *)title {
    if (title.length == 0) {
        self.HUD.label.text = @"请稍候";
    } else {
        self.HUD.label.text  = title;
    }
    //显示loading
    [self.HUD showAnimated:YES];
}


#pragma mark ------------------ 弹框 ---------------------
- (void)showAlertViewWithTitle:(NSString *)title yes:(NSString *)yes no:(NSString *)no yesHandler:(void (^ __nullable)(UIAlertAction *action))yesHandler noHandler:(void (^ __nullable)(UIAlertAction *action))noHandler {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:(UIAlertControllerStyleAlert)];
    if (yes) {
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:yes style:(UIAlertActionStyleDefault) handler:yesHandler];
        [alertC addAction:sureAction];
    }
    if (no) {
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:no style:(UIAlertActionStyleCancel) handler:noHandler];
        [alertC addAction:noAction];
    }
    [self presentViewController:alertC animated:YES completion:nil];
}









@end
