//
//  LHCollectViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/20.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHCollectViewController.h"
#import "LHMyBoxCell.h"
#import "LHCollectModel.h"
@interface LHCollectViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *collecTableView;
@property (nonatomic, strong) NSMutableArray *goodsArray;


@end

@implementation LHCollectViewController

- (NSMutableArray *)goodsArray {
    if (!_goodsArray) {
        self.goodsArray = [NSMutableArray new];
    }
    return _goodsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    self.view.backgroundColor = kColor(245, 245, 245);
    [self collecTableView];
    
    [self setHBK_NavigationBar];
    
    [self requestColloctionListData];
    
    

}

#pragma mark --------------- UI ------------------------
- (UITableView *)collecTableView {
    if (!_collecTableView) {
        self.collecTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-kNavBarHeight) style:(UITableViewStylePlain)];
        self.collecTableView.backgroundColor = kColor(245, 245, 245);
        self.collecTableView.dataSource = self;
        self.collecTableView.delegate = self;
        self.collecTableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:self.collecTableView];
        self.collecTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            NSLog(@"刷新");
        }];
        
        self.collecTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            NSLog(@"加载");
        }];
    }
    return _collecTableView;
}

- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"我的收藏" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark --------------- <UITableViewDelegate, UITableViewDataSource> -----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHMyBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHMyBoxCell"];
    if (cell == nil) {
        cell = [[LHMyBoxCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LHMyBoxCell"];
    }
    cell.collectModel = self.goodsArray[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kFit(80);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark -------------- 网络请求 -------------------

- (void)requestColloctionListData {
    [self showProgressHUD];
    [LHNetworkManager requestForGetWithUrl:kCollectionListUrl parameter:@{@"user_id":kUser_id} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            for (NSDictionary *dic in reponseObject[@"data"]) {
                LHCollectModel *model = [[LHCollectModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.goodsArray addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideProgressHUD];
            [self.collecTableView reloadData];
        });
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
