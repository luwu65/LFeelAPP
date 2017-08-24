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
@interface LHOrderListTableViewController ()

@end

@implementation LHOrderListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = kRandomColor;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[LHAccountGoodsCell class] forCellReuseIdentifier:@"LHAccountGoodsCell"];
    
    if (self.type == 0) {
        self.tableView.backgroundColor = [UIColor redColor];
    } else if (self.type == 1) {
        
        self.tableView.backgroundColor = [UIColor orangeColor];

    } else if (self.type == 2) {
        self.tableView.backgroundColor = [UIColor greenColor];

        
    } else if (self.type == 3) {
        self.tableView.backgroundColor = [UIColor purpleColor];

        
    } else if (self.type == 4) {
        self.tableView.backgroundColor = [UIColor cyanColor];

        
    }
    
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
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHAccountGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHAccountGoodsCell" forIndexPath:indexPath];
    cell.titleLabel.text = @"你好";
    cell.sizeLabel.text = @"黑色, M码";
    cell.priceLabel.text = @"$11111";
    cell.numLabel.text = @"x2";
    
    
    if (self.type == 0) {
        cell.backgroundColor = [UIColor redColor];
    } else if (self.type == 1) {
        cell.backgroundColor = [UIColor orangeColor];
    } else if (self.type == 2) {
        cell.backgroundColor = [UIColor greenColor];
    } else if (self.type == 3) {
        cell.backgroundColor = [UIColor purpleColor];
    } else if (self.type == 4) {
        cell.backgroundColor = [UIColor cyanColor];
    }
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LHOrderHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LHOrderHeaderView"];
    if (!headerView) {
        headerView = [[LHOrderHeaderView alloc] initWithReuseIdentifier:@"LHOrderHeaderView"];
    }
    headerView.shopLabel.text = @"AAAAA";
    headerView.statusLabel.text = @"待付款";
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    LHOrderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LHOrderFooterView"];
    if (!footerView) {
        footerView = [[LHOrderFooterView alloc] initWithReuseIdentifier:@"LHOrderFooterView"];
    }
    [footerView.leftBtn setTitle:@"查看物流" forState:(UIControlStateNormal)];
    [footerView.leftBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [footerView.rightBtn setTitle:@"评价" forState:(UIControlStateNormal)];
    [footerView.rightBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    footerView.allLabel.text = @"总共3件商品, 共25000元(运费到付)";
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kFit(80);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kFit(55);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kFit(90);
}


















@end
