//
//  LHMyCenterViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHMyCenterViewController.h"
#import "LHOrderFormView.h"
#import "LHMyCenterCell.h"
#import "LHMyCenterHeaderView.h"
#import "LHMyOrderViewController.h"
#import "LHAddVipViewController.h"
#import "LHSettingViewController.h"
#import "LHReceiveAddressViewController.h"
#import "LHUserInfoViewController.h"
#import "LHCollectViewController.h"
#import "LHWebViewController.h"
#import "LHCardBagViewController.h"
#import "LHBoxHistoryViewController.h"
static NSString *myCenterCell = @"myCenterCell";
@interface LHMyCenterViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myCenterTableView;
@property (nonatomic, strong) LHMyCenterHeaderView *headerView;

@property (nonatomic, strong) NSMutableArray *cellTitleArray;
@property (nonatomic, strong) NSMutableArray *cellImageViewArray;
@property (nonatomic, strong) LHOrderFormView *orderAbooutView;
@end

@implementation LHMyCenterViewController

- (NSMutableArray *)cellImageViewArray {
    if (!_cellImageViewArray) {
        self.cellImageViewArray = [NSMutableArray arrayWithObjects:@"MyCenter_Bill", @"MyCenter_Card", @"MyCenter_Collect", @"MyCenter_History", @"MyCenter_Address", @"MyCenter_Setting", nil];
    }
    return _cellImageViewArray;
}
- (NSMutableArray *)cellTitleArray {
    if (!_cellTitleArray) {
        self.cellTitleArray = [NSMutableArray arrayWithObjects:@"我的订单", @"我的分销", @"我的卡包", @"我的收藏", @"我的盒子历史", @"收货地址", @"设置",nil];
    }
    return _cellTitleArray;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    //设置导航栏为透明的
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:kColor(255, 255, 255)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColor(245, 245, 245);

    
    [self setUI];
    
    
    [self setHBK_NavigationBar];
    
    
    
}
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"个人中心" rightFirst:@"加入会员" rightFirstBtnAction:^{
        NSLog(@"加入会员");
        LHAddVipViewController *addVip = [[LHAddVipViewController alloc] init];
        [self.navigationController pushViewController:addVip animated:YES];
    }];
    self.hbk_navgationBar.rightFirstBtn.frame = CGRectMake(kScreenWidth-70, 31, 60, 20);
    self.hbk_navgationBar.bgColor = [UIColor clearColor];
    self.hbk_navgationBar.deviderLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.hbk_navgationBar.titleLabel.textColor = [UIColor clearColor];
    self.hbk_navgationBar.rightFirstBtn.layer.cornerRadius = 2;
    self.hbk_navgationBar.rightFirstBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.hbk_navgationBar.rightFirstBtn.layer.borderWidth = 1;
    self.hbk_navgationBar.rightFirstBtn.layer.masksToBounds = YES;
    self.hbk_navgationBar.rightFirstBtn.titleLabel.font = kFont(13);
    [self.hbk_navgationBar.rightFirstBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
}

- (void)setUI {
    self.myCenterTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49) style:(UITableViewStylePlain)];
    self.myCenterTableView.backgroundColor = [UIColor clearColor];
    self.myCenterTableView.dataSource = self;
    self.myCenterTableView.delegate = self;
    self.myCenterTableView.showsVerticalScrollIndicator = NO;
    self.myCenterTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.myCenterTableView];
    
     self.headerView = [[LHMyCenterHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200*kRatio)];
    self.headerView.bgImageView.backgroundColor = [UIColor cyanColor];
    [self.headerView clickIconBlock:^{
        LHUserInfoViewController *userInfoVC = [[LHUserInfoViewController alloc] init];
        [self.navigationController pushViewController:userInfoVC animated:YES];
    }];
    [_headerView.nameButton setTitle:@"小强" forState:(UIControlStateNormal)];
    self.myCenterTableView.tableHeaderView = _headerView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    footerView.backgroundColor = kColor(245, 245, 245);
    UIButton *callBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [callBtn setTitle:@"客服热线: 020-37889773" forState:(UIControlStateNormal)];
    callBtn.frame = CGRectMake(80, 20, kScreenWidth-160, 40);
    [callBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    callBtn.titleLabel.font = kFont(14);
    [callBtn addTarget:self action:@selector(callBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [footerView addSubview:callBtn];
    self.myCenterTableView.tableFooterView = footerView;
    
    [self.myCenterTableView registerNib:[UINib nibWithNibName:@"LHMyCenterCell" bundle:nil] forCellReuseIdentifier:@"LHMyCenterCell"];
}
- (void)callBtnAction {
    //拨打客服电话
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://020-37889773"] options:@{} completionHandler:nil];
}




#pragma mark -------------  UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 1;
    } else if (section == 2) {
        return 3;
    } else {
        return 2;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"MyLehuiOrderAboutCell"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = self.cellTitleArray[indexPath.row];
                cell.detailTextLabel.text = @"查看更多订单";
                cell.detailTextLabel.font = kFont(14*kRatio);
                cell.textLabel.font = kFont(14*kRatio);
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        } else {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"MyLehuiOrderAboutCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell addSubview:[self createOrderAbooutView]];
            }
            return cell;
        }
        
    } else {
        LHMyCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHMyCenterCell" forIndexPath:indexPath];
        cell.titleLabel.font = kFont(14*kRatio);
        if (1 == indexPath.section) {
            cell.titleLabel.text = self.cellTitleArray[indexPath.row+1];
            cell.picImageView.image = [UIImage imageNamed:self.cellImageViewArray[indexPath.row]];
            
        } else if(2 == indexPath.section){
            cell.titleLabel.text = self.cellTitleArray[indexPath.row+2];
            cell.picImageView.image = [UIImage imageNamed:self.cellImageViewArray[indexPath.row+1]];
            
        } else if (3 == indexPath.section) {
            cell.titleLabel.text = self.cellTitleArray[indexPath.row+5];
            cell.picImageView.image = [UIImage imageNamed:self.cellImageViewArray[indexPath.row+4]];
            
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        return 65*kRatio;
    } else {
        return 50*kRatio;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 15*kRatio;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        LHMyOrderViewController *orderVC = [[LHMyOrderViewController alloc] init];
        orderVC.index = 0;
        [self.navigationController pushViewController:orderVC animated:YES];
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            //卡包
            LHCardBagViewController *cardBagVC = [[LHCardBagViewController alloc] init];
            [self.navigationController pushViewController:cardBagVC animated:YES];
            
        } else  if (indexPath.row == 1){
            //收藏
            LHCollectViewController *collectVC = [[LHCollectViewController alloc] init];
            [self.navigationController pushViewController:collectVC animated:YES];
            
        } else {
            LHBoxHistoryViewController *boxVC = [[LHBoxHistoryViewController alloc] init];
            [self.navigationController pushViewController:boxVC animated:YES];
            
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            LHReceiveAddressViewController *receiveVC = [[LHReceiveAddressViewController alloc] init];
            [self.navigationController pushViewController:receiveVC animated:YES];
            
        } else {
            //设置
            LHSettingViewController *settingVC = [[LHSettingViewController alloc] init];
            [self.navigationController pushViewController:settingVC animated:YES];
        
        }
    }
    if (indexPath.section == 1) {

        
    }

}


//创建 --待付款, 待发货, 待收货, 待评论视图
- (LHOrderFormView *)createOrderAbooutView {
    self.orderAbooutView = [[LHOrderFormView alloc] initWithFrame:CGRectMake(1, 1, kScreenWidth-2, 68) imageNameArray:@[@"MyCenter_waitPay", @"MyCenter_waitSend", @"MyCenter_waitReceive", @"MyCenter_waitComment"] titleArray:@[@"待付款", @"待发货", @"待收货", @"待评论"]];
    
    [self.orderAbooutView clickCustomButton:^(NSInteger index) {
        switch (index) {
            case 0:{
                LHMyOrderViewController *orderVC = [[LHMyOrderViewController alloc] init];
                orderVC.index = 1;
                [self.navigationController pushViewController:orderVC animated:YES];
            }
                break;
            case 1:{
                LHMyOrderViewController *orderVC = [[LHMyOrderViewController alloc] init];
                orderVC.index = 2;
                [self.navigationController pushViewController:orderVC animated:YES];
                
            }
                break;
            case 2:{
                LHMyOrderViewController *orderVC = [[LHMyOrderViewController alloc] init];
                orderVC.index = 3;
                [self.navigationController pushViewController:orderVC animated:YES];
                
            }
                break;
            case 3:{
                LHMyOrderViewController *orderVC = [[LHMyOrderViewController alloc] init];
                orderVC.index = 4;
                [self.navigationController pushViewController:orderVC animated:YES];
                
            }
                break;
                
            default:
                break;
        }
        
        
    }];
           CustomButton *btn = (CustomButton *)[self.orderAbooutView viewWithTag:4002];
            btn.badgeValue = @"1";
    return _orderAbooutView;
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    CGFloat y = offset.y;
    if (offset.y < 0) {
        CGRect rect =self.headerView.frame;
        rect.origin.y = offset.y;
        rect.size.height =CGRectGetHeight(rect)-offset.y;
        self.headerView.bgImageView.frame = rect;
        self.headerView.clipsToBounds=NO;
    }
    CGFloat alphy = y / 150 > 1.0 ? 1.0 : y / 150;
    self.hbk_navgationBar.bgColor = [UIColor colorWithRed:256 green:0 blue:0 alpha:alphy];
    self.hbk_navgationBar.titleLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:alphy];
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
