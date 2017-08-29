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

@property (nonatomic, strong) NSMutableArray<LHAddressModel *> *addressArray;


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
        
    [self requestAddressListData];
}
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"我的地址" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    } rightFirst:@"新增" rightFirstBtnAction:^{
        LHEditAddressViewController *editVC = [[LHEditAddressViewController alloc] init];
        editVC.hbk_navgationBar.title = @"新增地址";
        editVC.SubmitBlock = ^{
            [self.addressArray removeAllObjects];
            [self.addressTableView.mj_header beginRefreshing];
        };
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
    
    self.addressTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.addressArray removeAllObjects];
        [self requestAddressListData];
    }];
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.addressArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHReceiveAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHReceiveAddressCell"];
    if (cell == nil) {
        cell = [[LHReceiveAddressCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LHReceiveAddressCell"];
    }
    cell.addressModel = self.addressArray[indexPath.section];
    [cell deleteAddressBlock:^{
        [self deleteAddressAlertWithModel:self.addressArray[indexPath.section]];
        [self.addressArray removeObjectAtIndex:indexPath.section];
    }];
    
    [cell EditAddressBlock:^{
        LHEditAddressViewController *editVC = [[LHEditAddressViewController alloc] init];
        editVC.addressModel = self.addressArray[indexPath.section];
        editVC.SubmitBlock = ^{
            [self.addressArray removeAllObjects];
            [self.addressTableView.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:editVC animated:YES];
        
    }];
  
    [cell setDefaultAddressBlock:^(UIButton *sender) {
        LHAddressModel *model = self.addressArray[indexPath.section];
        if ([model.isdefault integerValue] == 0) {
            [self requestDefaultAddressWithIndex:indexPath.section];
        }
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 26 + kFit(80);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.addressBlock) {
        return;
    }
    NSLog(@"---- %ld ----", indexPath.section);
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

- (void)deleteAddressAlertWithModel:(LHAddressModel *)model {
    @weakify(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定要删除这个地址吗?" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self requestDeleteAddressDataWithModel:model];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark  ---------------  网络请求 --------------------
//地址列表
- (void)requestAddressListData {
    [self showProgressHUD];
    [LHNetworkManager requestForGetWithUrl:kAddressList parameter:@{@"user_id": kUser_id} success:^(id reponseObject) {
        NSLog(@"++++++++++++%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            for (NSDictionary *dic in reponseObject[@"data"]) {
                LHAddressModel *model = [[LHAddressModel alloc] init];
                model.isdefault = [NSString stringWithFormat:@"%@", dic[@"isdefault"]];
                [model setValuesForKeysWithDictionary:dic];
                [self.addressArray addObject:model];
            }
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideProgressHUD];
            [self.addressTableView.mj_header endRefreshing];
            [self.addressTableView reloadData];
        });
        if (self.addressArray.count == 0) {
            //如果为空, 添加显示为空的View
            
        }
    } failure:^(NSError *error) {
        
    }];
}
//删除地址
- (void)requestDeleteAddressDataWithModel:(LHAddressModel *)model {
    [self showProgressHUD];
    [LHNetworkManager PostWithUrl:kAddreessDeleteUrl parameter:@{@"id": model.id_} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideProgressHUD];
                [MBProgressHUD showSuccess:@"删除成功"];
                [self.addressTableView reloadData];
            });
        }
    } failure:^(NSError *error) {
        
    }];
}

//设为默认
- (void)requestDefaultAddressWithIndex:(NSInteger)index {
    [self showProgressHUD];
    LHAddressModel *model = self.addressArray[index];
    [LHNetworkManager PostWithUrl:kAddressUpdateUrl parameter:@{@"user_id": model.user_id, @"id": model.id_, @"isdefault": @"1"} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            for (LHAddressModel *aModel in self.addressArray) {
                if (aModel == model) {
                    aModel.isdefault = @"1";
                } else {
                    aModel.isdefault = @"0";
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideProgressHUD];
                [self.addressTableView reloadData];
            });
        } else {
            [MBProgressHUD showError:@"失败"];
        }
    } failure:^(NSError *error) {
        
    }];
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
