//
//  LHCollectViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/20.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHCollectViewController.h"
#import "LHMyBoxCell.h"
@interface LHCollectViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *collecTableView;

@end

@implementation LHCollectViewController

- (UITableView *)collecTableView {
    if (!_collecTableView) {
        self.collecTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-kNavBarHeight) style:(UITableViewStylePlain)];
        self.collecTableView.backgroundColor = kColor(245, 245, 245);
        self.collecTableView.dataSource = self;
        self.collecTableView.delegate = self;
        self.collecTableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:self.collecTableView];
    }
    return _collecTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = kColor(245, 245, 245);
    [self collecTableView];
    
    [self setHBK_NavigationBar];
}

- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"我的收藏" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
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
