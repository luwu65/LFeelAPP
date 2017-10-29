//
//  LHMakeBillViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/20.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHMakeBillViewController.h"
#import "LHPackingBoxView.h"
#import "LHOrderGoodsCell.h"
#import "LHBillHeaderFooterView.h"
#import "LHPackingBoxView.h"
#import "LHBillHistoryViewController.h"
@interface LHMakeBillViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *billTableView;

@end

@implementation LHMakeBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    [self setHBK_NavigationBar];
}

- (void)setupUI {
    LHApplyBillBottomView *applyView = [[LHApplyBillBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kFit(40), kScreenWidth, kFit(40))];
    [applyView applyBillBlock:^{
        NSLog(@"开发票");
    }];
    [applyView allClickGoodsBlock:^(BOOL isClick) {
         NSLog(@"全选");
        
    }];

    [self.view addSubview:applyView];
    
    self.billTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-kFit(40)-64) style:(UITableViewStyleGrouped)];
    self.billTableView.dataSource = self;
    self.billTableView.delegate = self;
    [self.view addSubview:self.billTableView];
    self.billTableView.tableFooterView = [[UIView alloc] init];
    self.billTableView.backgroundColor = kColor(245, 245, 245);

}

- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"发票" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    } rightFirst:@"发票历史" rightFirstBtnAction:^{
        NSLog(@"开票历史");
        LHBillHistoryViewController *historyVC = [[LHBillHistoryViewController alloc] init];
        [self.navigationController pushViewController:historyVC animated:YES];
    }];
    self.hbk_navgationBar.rightFirstBtn.frame = CGRectMake(kScreenWidth-84, 21, 84, 42);
}


#pragma mark  -------- Action ----------

#pragma mark  ---------- <UITableViewDelegate, UITableViewDataSource> -----------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kFit(80);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return kFit(40);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kFit(50);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"LHOrderGoodsCell";
    LHOrderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[LHOrderGoodsCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellId];
    }
    cell.titleLabel.text = @"hahahahaha";
    cell.brandLabel.text = @"奥迪";
    cell.priceLabel.text = @"$9999";
    cell.countLabel.text = @"x5";
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    LHBillFooterView *footerView = [[LHBillFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60*kRatio)];
//    footerView.allPriceLabel.text = @"总价: 20000";
//    
//    return footerView;
    
    static NSString *footerViewID = @"LHBillFooterView";
    LHBillFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerViewID];
    if (!footerView) {
        footerView = [[LHBillFooterView alloc] initWithReuseIdentifier:footerViewID];
    }
    footerView.allPriceLabel.text = @"总价: 20000";
    return footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LHBillHeaderView *headerView = [[LHBillHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kFit(50))];
    
    headerView.orderNumLabel.text = @"订单编号: 133333333333333";
    return headerView;
//    static NSString *headerViewID = @"LHBillHeaderViewMake";
//    LHBillHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
//    if (!headerView) {
//        headerView = [[LHBillHeaderView alloc] initWithReuseIdentifier:headerViewID];
//    }
//    headerView.orderNumLabel.text = @"订单编号: 133333333333333";
//
//    return headerView;
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
