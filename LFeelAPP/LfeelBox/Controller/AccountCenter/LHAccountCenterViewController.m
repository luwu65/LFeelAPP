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
typedef NS_ENUM(NSInteger, PayType) {
    PayWithLBFPayType = 0,
    PayWithAliPayType,
    PayWithWXPayType,
    PayWithUnionPayType
};
@interface LHAccountCenterViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *orderTableView;

@property (nonatomic, assign) NSInteger payType;


@end

@implementation LHAccountCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self createOrderTableView];
    [self setHBK_NavigationBar];
    [self setBottomView];
    [self setDefualtPayType];
}

/*
  默认的付款方式
 */
- (void)setDefualtPayType {
    self.payType = PayWithAliPayType;
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
    
    LHAccountCenterHeaderView *headerView = [[LHAccountCenterHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    headerView.nameLabel.text = @"aaa";
    headerView.phoneLabel.text = @"1223455856";
    headerView.addressLabel.text = @"话不能尴尬kg哈kg哈kg啊啊";
    headerView.clickHeaderViewBlock = ^{
        LHReceiveAddressViewController *receiveVC = [[LHReceiveAddressViewController alloc] init];
        receiveVC.addressBlock = ^(LHAddressModel *model) {
            NSLog(@"点击了");
            headerView.isUpdateFrame = YES;
            headerView.nameLabel.text = @"收货人: 黄冰珂";
            headerView.phoneLabel.text = @"13298368875";
            headerView.addressLabel.text = @"上海静安区爱就爱阿姐";
            headerView.frame = CGRectMake(0, 0, kScreenWidth, kFit(85));
            
            [self.orderTableView reloadData];
            
        };
        [self.navigationController pushViewController:receiveVC animated:YES];
    };
    self.orderTableView.tableHeaderView = headerView;
    
    LHAccountCenterFooterView *footerView = [LHAccountCenterFooterView creatView];
    footerView.frame = CGRectMake(0, 0, kScreenWidth, kFit(300));
    [footerView handleAgreeBlock:^{
        NSLog(@"同意乐荟商城租赁协议");
    }];
    
    [footerView selectedCheaperCardBlock:^(UILabel *label) {
        NSLog(@"选择优惠券");
        
    }];
    
    [footerView selectedPayTypeBlock:^(UILabel *label) {
        NSLog(@"付款方式");
        [self setPayViewWithLabel:label];
    }];
    
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
    allPriceLabel.text = @"总计: 1000.00";
    allPriceLabel.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:allPriceLabel];
    
}



//选择付款方式
- (void)setPayViewWithLabel:(UILabel *)label {
    LHPayWayView *payView = [[LHPayWayView alloc] initWithIndex:self.payType];
    [payView clickPayWayBlock:^(NSInteger index) {
        NSLog(@"%ld", index);
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

}

#pragma mark --------------  <UITableViewDelegate, UITableViewDataSource> -------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"LHAccountGoodsCell";
    LHAccountGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LHAccountGoodsCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    
    cell.titleLabel.text = @"你好";
    cell.sizeLabel.text = @"黑色, M码";
    cell.priceLabel.text = @"$11111";
    cell.numLabel.text = @"x2";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kFit(80);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kFit(40);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LHAccountSectionHeaderView *view = [[LHAccountSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kFit(40))];
    view.titleLabel.text = @"乐荟海外旗舰店";
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
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
