//
//  LHCardBagViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/18.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHCardBagViewController.h"
#import "LHCardCell.h"
#import "LHCardHeaderView.h"
#import "LHMakeBillViewController.h"
@interface LHCardBagViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *cardTableView;

@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, assign) BOOL isSecond;

@property (nonatomic, strong) NSMutableArray *bankCardArray;


@end

@implementation LHCardBagViewController


- (NSMutableArray *)bankCardArray {
    if (!_bankCardArray) {
        self.bankCardArray = [NSMutableArray new];
    }
    return _bankCardArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isFirst = YES;
    self.isSecond = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self requestBankListData];
    
    [self setupUI];
    [self setHBK_NavigationBar];
    
    
}
#pragma mark -------------------------- 网络请求 --------------------------

- (void)requestBankListData {
    [LHNetworkManager requestForGetWithUrl:kBankListUrl parameter:@{@"user_id": kUser_id} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----------------------- UI --------------------------------
- (void)setupUI {
    self.cardTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.cardTableView.bounces = NO;
    self.cardTableView.delegate = self;
    self.cardTableView.dataSource = self;
    self.cardTableView.backgroundColor = kColor(245, 245, 245);
    self.cardTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.cardTableView];
}
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"我的卡包" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


#pragma mark  ------------UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
        
    } else if (section == 1) {
        if (self.isFirst) {
            //这里返回信用卡的行数, +1 是加上添加信用卡那一行
            return 2;
        } else {
            return 0;
        }
    } else if (section == 2){
        return 0;
    } else if (section == 3) {
        if (self.isSecond) {
            //这里返回优惠券的行数
            return 5;
        } else {
            return 0;
        }
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cardCell = @"LHCardCell";
    static NSString *addCardCell = @"LHAddCardCell";
    static NSString *cheaperCall = @"LHCheaperCardCell";
    static NSString *billCell = @"LHBillCardCell";
    static NSString *spaceCell = @"spaceCell";
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            LHCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cardCell];
            if (!cell) {
                cell = [[LHCardCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cardCell];
            }
            
            
            return cell;
        } else {
            LHAddCardCell *cell = [tableView dequeueReusableCellWithIdentifier:addCardCell];
            if (!cell) {
                cell = [[LHAddCardCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:addCardCell];
            }
        
            return cell;
        }
    } else if (indexPath.section == 3) {
        LHCheaperCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cheaperCall];
        if (!cell) {
            cell = [[LHCheaperCardCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cheaperCall];
        }
        
        
        return cell;
    } else if (indexPath.section == 4) {
        LHBillCardCell *cell = [tableView dequeueReusableCellWithIdentifier:billCell];
        if (!cell) {
            cell = [[LHBillCardCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:billCell];
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:spaceCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:spaceCell];
        }
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 150;
    } else if (indexPath.section == 3) {
        return 150;
    } else {
        return 50;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 50;
        
    } else if (section == 1) {
        return 0;
        
    } else if (section == 2){
        return 50;
    } else if (section == 3) {
        return 0;
    } else {
        return 0;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *viewIdentfier = @"headView";
    LHCardHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
    if (!headerView) {
        headerView = [[LHCardHeaderView alloc] initWithReuseIdentifier:viewIdentfier];
    }
    headerView.titleImageView.image = [UIImage imageNamed:@[@"MyCenter_MyCard_credit", @"", @"MyCenter_MyCard_cheaper", @"", @""][section]];
    headerView.titleLabel.text = @[@"信用卡", @"", @"优惠券", @"", @""][section];
    [headerView clickCardHeaderBlock:^(BOOL isClick) {
        //        NSLog(@"%ld--------%d", section, isClick);
        if (section == 0) {
            self.isFirst = isClick;
            if (!isClick) {
                NSLog(@"合上%ld分区", (long)section);
                [UIView animateWithDuration:0.2 animations:^{
                    headerView.openImageView.transform = CGAffineTransformRotate(headerView.openImageView.transform, M_PI);
                }];
            } else {
                NSLog(@"展开%ld分区", (long)section);
                [UIView animateWithDuration:0.2 animations:^{
                    headerView.openImageView.transform = CGAffineTransformRotate(headerView.openImageView.transform, -M_PI);
                }];
            }
            [self.cardTableView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        } else if (section == 2) {
            self.isSecond = isClick;
            if (!isClick) {
                [UIView animateWithDuration:0.2 animations:^{
                    headerView.openImageView.transform = CGAffineTransformRotate(headerView.openImageView.transform, M_PI);
                }];
            } else {
                [UIView animateWithDuration:0.2 animations:^{
                    headerView.openImageView.transform = CGAffineTransformRotate(headerView.openImageView.transform, -M_PI);
                }];
            }
            [self.cardTableView reloadSections:[[NSIndexSet alloc] initWithIndex:3] withRowAnimation:(UITableViewRowAnimationFade)];
        }
        
    }];
    
    return headerView; 
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor = kColor(245, 245, 245);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
        
    } else if (section == 1) {
        return 20;
        
    } else if (section == 2){
        return 0;
    } else if (section == 3) {
        return 20;
    } else {
        return 20;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == self.bankCardArray.count) {
            NSLog(@"添加新卡");
        }
    }
    
    if (indexPath.section == 4) {
        LHMakeBillViewController *billVC = [[LHMakeBillViewController alloc] init];
        [self.navigationController pushViewController:billVC animated:YES];
    }
    
}

#pragma mark ----------------------  Action -----------------------------








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
