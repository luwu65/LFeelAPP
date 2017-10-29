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

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) UIView *emptyBgView;

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
    self.page = 1;
    
    [self requestColloctionListDataWithPage:1];
    
    

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
        self.collecTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshTableView)];
        self.collecTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshTableView)];

    }
    return _collecTableView;
}

- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"我的收藏" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)addEmptyView {
    self.emptyBgView = [[UIView alloc] init];
    self.emptyBgView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-kNavBarHeight);
    [self.view addSubview:self.emptyBgView];
    
    UIImageView *emptyImageView = [[UIImageView alloc] initWithImage:kImage(@"MyBox_Empty_MyBox")];
    emptyImageView.frame = CGRectMake(kFit(100), kFit(104), kScreenWidth-kFit(200), kScreenWidth-kFit(200));
    [self.emptyBgView addSubview:emptyImageView];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, emptyImageView.maxY+kFit(20), kScreenWidth, 25)];
    textLabel.text = @"收藏夹还是空的哟~";
    textLabel.font = kFont(kFit(15));
    textLabel.textColor = [UIColor lightGrayColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [self.emptyBgView addSubview:textLabel];
    
    UIButton *goBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    goBtn.frame = CGRectMake(kFit(40), kScreenHeight-kNavBarHeight - kFit(100), kScreenWidth-kFit(80), kFit(40));
    [goBtn setTitle:@"逛逛新品~" forState:(UIControlStateNormal)];
    [goBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    goBtn.layer.masksToBounds = YES;
    goBtn.layer.borderColor = [UIColor redColor].CGColor;
    goBtn.layer.borderWidth = 1;
    goBtn.layer.cornerRadius = 2;
    [goBtn addTarget:self action:@selector(handleGoHomeAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.emptyBgView addSubview:goBtn];
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

- (void)requestColloctionListDataWithPage:(NSInteger)page {
    [self showProgressHUD];
    [LHNetworkManager requestForGetWithUrl:kCollectionListUrl parameter:@{@"user_id":kUser_id, @"type": @0, @"page":@(page)} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            for (NSDictionary *dic in reponseObject[@"data"]) {
                LHCollectModel *model = [[LHCollectModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.goodsArray addObject:model];
            }
        }
        
        if (page == [reponseObject[@"total"] integerValue]) {
            [self.collecTableView.mj_footer endRefreshingWithNoMoreData];
        }
        if (self.goodsArray.count == 0) {
            [self addEmptyView];
        } else {
            [self.emptyBgView removeFromSuperview];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideProgressHUD];
            [self.collecTableView.mj_footer endRefreshing];
            [self.collecTableView.mj_header endRefreshing];
            [self.collecTableView reloadData];
        });
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark --------------  Action ---------------
//刷新
- (void)headerRefreshTableView {
    NSLog(@"刷新");
    [self.goodsArray removeAllObjects];
    [self requestColloctionListDataWithPage:0];
    
}

//加载
- (void)footerRefreshTableView {
    self.page++;
    [self requestColloctionListDataWithPage:self.page];
    NSLog(@"加载");
}

//逛逛新品
- (void)handleGoHomeAction {
    NSLog(@"逛逛新品");
    self.tabBarController.selectedIndex = 3;
    [self.navigationController popViewControllerAnimated:YES];
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
