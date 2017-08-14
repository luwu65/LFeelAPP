//
//  LHReceiveAddressViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/20.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHReceiveAddressViewController.h"
#import "LHReceiveAddressCell.h"
#import "LHEditAddressViewController.h"
@interface LHReceiveAddressViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *addressTableView;
@property (nonatomic, strong) NSIndexPath *lastPath;//记录最后点击的哪一个

@property (nonatomic, strong) NSMutableArray *addressArray;


@end

@implementation LHReceiveAddressViewController

- (NSMutableArray *)addressArray {
    if (!_addressArray) {
        self.addressArray = [NSMutableArray new];
    }
    return _addressArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self setHBK_NavigationBar];
}
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"我的地址" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    } rightFirst:@"新增" rightFirstBtnAction:^{
        NSLog(@"新增");
        LHEditAddressViewController *editVC = [[LHEditAddressViewController alloc] init];
        [self.navigationController pushViewController:editVC animated:YES];
    }];
    self.hbk_navgationBar.rightFirstBtn.frame = CGRectMake(kScreenWidth-50, 21, 50, 42);
}

- (void)setUI {    
    self.addressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-kNavBarHeight) style:(UITableViewStylePlain)];
    self.addressTableView.delegate = self;
    self.addressTableView.dataSource = self;
    self.addressTableView.tableFooterView = [[UIView alloc] init];
    self.addressTableView.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:self.addressTableView];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHReceiveAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHReceiveAddressCell"];
    if (cell == nil) {
        cell = [[LHReceiveAddressCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LHReceiveAddressCell"];
    }
    cell.nameLabel.text = @"黄冰珂     132082434343";
    cell.addressLabel.text = @"噶搜噶时光机阿里山就够啦冠军联赛";
    [cell deleteAddressBlock:^(UIButton *sender) {
        NSLog(@"删除");
        NSLog(@"删除 ---- %ld --  %ld", indexPath.section, indexPath.row);
        [self deleteAddressAlert];
    }];
    
    [cell EditAddressBlock:^(UIButton *sender) {
        NSLog(@"编辑");
        NSLog(@"编辑 ---- %ld --  %ld", indexPath.section, indexPath.row);

        
    }];
  
    [cell setDefaultAddressBlock:^(UIButton *sender) {
        NSLog(@"设为默认 ---- %ld --  %ld", indexPath.section, indexPath.row);
        
    
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 26 + 80*kRatio;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"---- %ld ----", indexPath.section);
    if (!self.addressBlock) {
        return;
    }
    LHAddressModel *model = [[LHAddressModel alloc] init];
    [self.addressArray addObject: model];
    if (self.addressBlock) {
        self.addressBlock(self.addressArray[indexPath.section]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickAddressBlock:(ClickAddressBlock)block {
    self.addressBlock = block;
}

- (void)deleteAddressAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"确定要删除这个地址吗?" preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
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
