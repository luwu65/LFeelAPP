//
//  LHSettingViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/20.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHSettingViewController.h"
#import "LHHomeViewController.h"
#import "LHChangePasswordViewController.h"
@interface LHSettingViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSString * CacheSize;
    
}

@property (nonatomic, strong) UITableView *settingTableView;

@property (nonatomic, strong) NSMutableArray *dataArray;



@end

@implementation LHSettingViewController
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray arrayWithObjects:@"清理缓存", @"修改密码", @"当前版本", @"关于我们", @"注意事项", @"常见问题", @"服务协议", nil];
    }
    return _dataArray;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //页面一出现就开始计算缓存
    [self countCacheSize];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    [self setHBK_NavigationBar];
    NSLog(@"啦啦啦啦");
}


#pragma mark ---------- UI  ----------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"设置" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


- (void)setUI {
    self.settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight-kNavBarHeight-kIPhoneXBottomHeight) style:(UITableViewStylePlain)];
    self.settingTableView.scrollEnabled = NO;
    self.settingTableView.delegate = self;
    self.settingTableView.dataSource = self;
    [self.view addSubview:self.settingTableView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight-44*7-30)];
    footerView.backgroundColor = kColor(245, 245, 245);
    UIButton *outLoginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [outLoginBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [outLoginBtn setTitle:@"退出登录" forState:(UIControlStateNormal)];
    outLoginBtn.backgroundColor = [UIColor whiteColor];
    outLoginBtn.titleLabel.font = kFont(16);
    outLoginBtn.layer.cornerRadius = 2;
    outLoginBtn.layer.borderColor = [UIColor redColor].CGColor;
    outLoginBtn.layer.borderWidth = 1;
    outLoginBtn.layer.masksToBounds = YES;
    [outLoginBtn addTarget:self action:@selector(outLoginBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [footerView addSubview:outLoginBtn];
    [outLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footerView.mas_left).offset(40);
        make.right.equalTo(footerView.mas_right).offset(-40);
        make.bottom.equalTo(footerView.mas_bottom).offset(-40);
        make.height.mas_offset(40);
    }];
    self.settingTableView.tableFooterView = footerView;
    
}


#pragma mark ---------- Action  --------
//退出登录
- (void)outLoginBtnAction {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"确定退出登录" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [LHUserInfoManager cleanUserInfo];
        self.tabBarController.selectedIndex = 0;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *noAciton = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alertC addAction:yesAction];
    [alertC addAction:noAciton];
    [self presentViewController:alertC animated:yesAction completion:nil];
}

- (void)countCacheSize{
    [[SDImageCache sharedImageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
        NSUInteger kb = 1024;
        NSUInteger mb = 1024 * 1024;
        if (totalSize < mb) {
            if (0 == (totalSize / kb)) {
                CacheSize = @"0.00MB";
            } else {
                CacheSize  = [NSString stringWithFormat:@"%luMB", totalSize / mb];
            }
        } else {
            CacheSize = [NSString stringWithFormat:@"%.1fMB", (double)totalSize / mb];
        }
        if (CacheSize) {
            [self.settingTableView reloadData];
        }
    }];
}


#pragma mark  -------------------  <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"LHSettingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = kFont(15);
    if (indexPath.section == 0) {
        cell.textLabel.text = self.dataArray[indexPath.row];
        if (indexPath.row == 1 || indexPath.row == 3) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        } else {
            if (indexPath.row == 0) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                if (CacheSize) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",CacheSize];
                } else {
                    cell.detailTextLabel.text = @"";
                }
            }
            if (indexPath.row == 2) {
                NSString * version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"V%@", version];
            }
        }
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.dataArray[indexPath.row + 4];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            LHChangePasswordViewController *passVC = [[LHChangePasswordViewController alloc] init];
            [self.navigationController pushViewController:passVC animated:YES];
        } else if (indexPath.row == 0) {
            if ([CacheSize integerValue] > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertViewWithTitle:@"清理缓存图片" yesHandler:^(UIAlertAction * _Nullable action) {
                        [[[SDWebImageManager sharedManager] imageCache] clearDiskOnCompletion:nil];
                        [[SDWebImageManager sharedManager].imageCache clearMemory];
                        [MBProgressHUD showSuccess:@"清理成功"];
                        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                        cell.detailTextLabel.text = @"0.00MB";
                    } noHandler:nil];
                });
            }
        }
    }
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
