//
//  LHBoxHistoryViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/10.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBoxHistoryViewController.h"
#import "LHMyBoxCell.h"

@interface LHBoxHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *boxHistoryTableView;



@end

@implementation LHBoxHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kColor(245, 245, 245);
    [self setUI];
    
    [self setHBK_NavigationBar];
    
}
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"我的盒子历史" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)setUI {
    self.boxHistoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.boxHistoryTableView.delegate = self;
    self.boxHistoryTableView.dataSource = self;
    [self.view addSubview:self.boxHistoryTableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHMyBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHMyBoxCell"];
    if (cell == nil) {
        cell = [[LHMyBoxCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LHMyBoxCell"];
    }
    cell.titleLabel.text = @"哈哈还哈";
    cell.brandLabel.text = @"brand";
    cell.sizeLabel.text = @"S, XL";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80*kRatio;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    lineView.backgroundColor = kColor(245, 245, 245);
    [view addSubview:lineView];
    
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth-20, 29)];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.font = kFont(15*kRatio);
    timeLabel.text = @"2017-6-12";
    [view addSubview:timeLabel];
    
    UIView *lineBotView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, kScreenWidth, 1)];
    lineBotView.backgroundColor = kColor(245, 245, 245);
    [view addSubview:lineBotView];
    return view;
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