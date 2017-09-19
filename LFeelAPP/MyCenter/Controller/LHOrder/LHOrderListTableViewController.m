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
@interface LHOrderListTableViewController ()
@property (nonatomic, strong) NSMutableArray *storeArray;

@property (nonatomic, strong) MBProgressHUD *HUD;

@property (nonatomic, strong) UIView *emptyView;


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
    [self.tableView registerClass:[LHAccountGoodsCell class] forCellReuseIdentifier:@"LHAccountGoodsCell"];
    
    [self requestMyOrderListWithType:self.type];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}
///刷新
- (void)reloadData{
    self.needRefresh = NO;
    [self.tableView.mj_header beginRefreshing];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
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
    LHOrderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LHOrderFooterView"];
    if (!footerView) {
        footerView = [[LHOrderFooterView alloc] initWithReuseIdentifier:@"LHOrderFooterView"];
    }
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
        [footerView.bottomView removeFromSuperview];

    } else if ([model.status integerValue] == 2) {//待收货
        [footerView.leftBtn setTitle:@"查看物流" forState:(UIControlStateNormal)];
        [footerView.leftBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        footerView.leftBtn.layer.borderColor = [UIColor redColor].CGColor;
        footerView.leftBtn.layer.borderWidth = 1;
        [footerView.rightBtn setTitle:@"确认收货" forState:(UIControlStateNormal)];
        [footerView.rightBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        footerView.rightBtn.backgroundColor = [UIColor redColor];
    } else if ([model.status integerValue] == 3) {//已收货\待收货
        
    } else if ([model.status integerValue] == 4) {
        
    } else if ([model.status integerValue] == 5) {
        
    } else if ([model.status integerValue] == 6) {
        
    }

    footerView.ClickBtnBlock = ^(UIButton *sender) {
        NSLog(@"%@--------%ld", sender.titleLabel.text, section);
        if ([sender.titleLabel.text isEqualToString:@"去付款"]) {
        
            
            
        } else if ([sender.titleLabel.text isEqualToString:@"取消订单"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定要取消订单?" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
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
- (void)requestMyOrderListWithType:(NSInteger)type {
    [self showProgressHUDWithTitle:@"加载中..."];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:kUser_id forKey:@"user_id"];
    if (type != 0) {
        [dic setObject:@(type-1) forKey:@"status"];
    }
    NSLog(@"~~~>>>> ---%ld",  (long)type);
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
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideProgressHUD];
                [self.tableView reloadData];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideProgressHUD];
                [MBProgressHUD showError:@"请求错误"];
            });
        }
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark ------------- Action ---------------------



#pragma mark ------------------ 没有数据的时候 ---------------
- (UIView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + kFit(44), kScreenWidth, kScreenHeight-64-kFit(44))];
        [self.view addSubview:_emptyView];
        
        UIImageView *emptyImageView = [[UIImageView alloc] initWithImage:kImage(@"MyCenter_NoOrder")];
        emptyImageView.frame = CGRectMake(kFit(100), 50, kScreenWidth-kFit(200), kScreenWidth-kFit(200));
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




@end
