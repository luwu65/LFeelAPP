//
//  LHBillHistoryViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/21.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBillHistoryViewController.h"
#import "LHPackingBoxView.h"
#import "LHOrderGoodsCell.h"
#import "LHBillHeaderFooterView.h"
@interface LHBillHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *billTableView;

@end

@implementation LHBillHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    [self setHBK_NavigationBar];
}


- (void)setupUI {
    self.billTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:(UITableViewStyleGrouped)];
    self.billTableView.dataSource = self;
    self.billTableView.delegate = self;
    [self.view addSubview:self.billTableView];
    self.billTableView.tableFooterView = [[UIView alloc] init];
    self.billTableView.backgroundColor = kColor(245, 245, 245);
}

- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"开票历史" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


#pragma mark  ---------- <UITableViewDelegate, UITableViewDataSource> -----------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80*kRatio;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40*kRatio;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50*kRatio;
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
    static NSString *footerViewID = @"LHBillFooterView";
    LHBillFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerViewID];
    if (!footerView) {
        footerView = [[LHBillFooterView alloc] initWithReuseIdentifier:footerViewID];
    }
    footerView.allPriceLabel.text = @"总价: 20000";
    return footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *headerViewID = @"LHBillHeaderView";
    LHBillHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
    if (!headerView) {
        headerView = [[LHBillHeaderView alloc] initWithReuseIdentifier:headerViewID];
        [headerView.selectBtn removeFromSuperview];
        //此举是隐藏哪个选中的按钮
        [headerView.orderNumLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView.mas_left).offset(10);
            make.top.equalTo(headerView.mas_top).offset(5);
            make.bottom.equalTo(headerView.mas_bottom).offset(-5);
            make.right.equalTo(headerView.mas_right).offset(-80*kRatio);
        }];
    }
    headerView.orderNumLabel.text = @"订单编号: 133333333333333";
    return headerView;
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
