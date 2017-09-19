//
//  LHHomeViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHHomeViewController.h"
#import "LHHomeTableViewCell.h"
#import "LHCycleScrollView.h"
#import "LHNewHandsViewController.h"
#import "LHChooseGoodsViewController.h"
#import <SDCycleScrollView.h>
#import "LHHomeModel.h"
#import "LHScanViewController.h"
@interface LHHomeViewController ()<UITableViewDelegate, UITableViewDataSource>



@property (nonatomic, strong) UITableView *homeTabeView;

/*轮播图数组*/
@property (nonatomic, strong) NSMutableArray *cycleImageArray;

/*主题下面的商品数组*/
@property (nonatomic, strong) NSMutableArray *themeGoodsArray;

/*主题数组*/
@property (nonatomic, strong) NSMutableArray *themeArray;

@property (nonatomic, strong) LHHomeCycleView *cycleScrollView;


@end

@implementation LHHomeViewController
- (NSMutableArray *)themeArray {
    if (!_themeArray) {
        self.themeArray = [NSMutableArray array];
    }
    return _themeArray;
}
- (NSMutableArray *)cycleImageArray {
    if (!_cycleImageArray) {
        self.cycleImageArray = [NSMutableArray array];
    }
    return _cycleImageArray;
}



- (NSMutableArray *)themeGoodsArray {
    if (!_themeGoodsArray) {
        self.themeGoodsArray = [NSMutableArray array];
    }
    return _themeGoodsArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUI];
    [self setHBK_NavigationBar];
    [self requestCycleScrollViewData];
}


#pragma mark  ---------------------  网络请求  ---------------------
//轮播图数据
- (void)requestCycleScrollViewData {
    [self showProgressHUDWithTitle:@"加载中..."];
    //请求之前先把之前数组里的数据清除, 防止下拉刷新重复添加
    [self.cycleImageArray removeAllObjects];
    [LHNetworkManager requestForGetWithUrl:kCycleViewUrl parameter:nil success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([kSTR(reponseObject[@"isError"]) isEqualToString:@"0"]) {
            for (NSDictionary *imaggeURlDic in reponseObject[@"data"]) {
                [self.cycleImageArray addObject:imaggeURlDic[@"url"]];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cycleScrollView.cycleView.imageURLStringsGroup = self.cycleImageArray;
            [self.homeTabeView reloadData];
            [self requestSpecialData];
        });

    } failure:^(NSError *error) {
        
    }];
}


- (void)requestSpecialData {
    //请求之前先把之前数组里的数据清除, 防止下拉刷新重复添加
    [self.themeArray removeAllObjects];
    [LHNetworkManager requestForGetWithUrl:kThemeURl parameter:nil success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([kSTR(reponseObject[@"isError"]) isEqualToString:@"0"]) {
            for (NSDictionary *modelDic in reponseObject[@"data"]) {
                LHHomeThemesModel *model = [[LHHomeThemesModel alloc] init];
                [model setValuesForKeysWithDictionary:modelDic];
                [self.themeArray addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.homeTabeView reloadData];
            [self requestThemeGoodsData];
            
        });

    } failure:^(NSError *error) {
        
    }];
}

- (void)requestThemeGoodsData {
    //请求之前先把之前数组里的数据清除, 防止下拉刷新重复添加
    [self.themeGoodsArray removeAllObjects];
    //@"limit":@3,在首页限制3件
    [LHNetworkManager requestForGetWithUrl:kGoodsUrl parameter:@{@"page":@1, @"pronum": @3} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([kSTR(reponseObject[@"isError"]) isEqualToString:@"0"]) {
            for (NSDictionary *adic in reponseObject[@"data"]) {
                LHHomeThemeGoodsModel *model = [[LHHomeThemeGoodsModel alloc] init];
                model.theme_id = adic[@"theme_id"];
                model.value = [NSMutableArray arrayWithArray:adic[@"value"]];
                [self.themeGoodsArray addObject:model];
            }
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.homeTabeView.mj_header endRefreshing];
            [self hideProgressHUD];
            [self.homeTabeView reloadData];
        });
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark  ------------------   UI  控件 ----------------------
//创建最底层的TableView   左右上角的button
- (void)setUI {
    
    self.homeTabeView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-49-64) style:(UITableViewStyleGrouped)];
    self.homeTabeView.delegate = self;
    self.homeTabeView.dataSource = self;
    [self.view addSubview:self.homeTabeView];
    
    self.cycleScrollView = [[LHHomeCycleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*2/3 + 35*kRatio) imageFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*2/3) placeholderImage:@"Home_New_04" buttonTitle:@[@"专业搭配师", @"不限次换穿", @"五星级清洗"] buttonImage:@[@"Home_Like", @"Home_Like", @"Home_Like"]];
    self.cycleScrollView.cycleView.imageURLStringsGroup = self.cycleImageArray;
    self.homeTabeView.tableHeaderView = self.cycleScrollView;
    
    [self.cycleScrollView clickCycleBlock:^(NSInteger index) {
        NSLog(@"点击了第%ld张", (long)index);
    }];
    
    @weakify(self);
    self.homeTabeView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self requestCycleScrollViewData];
    }];
}

- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"首页" leftFirst:@"Home_Camera" leftFirstAction:^{
        LHScanViewController *scanVC = [[LHScanViewController alloc] init];
        [self.navigationController pushViewController:scanVC animated:YES];
    } rightFirst:@"Home_service" rightFirstBtnAction:^{
        NSLog(@"客服");
        [self openZCServiceWithProduct:nil];
    }];
}




#pragma mark  -------------------  Action  -----------------------



#pragma mark -----------------------   UITableViewDataSource  UITableViewDelegate -----------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.themeGoodsArray.count+1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LHHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHBoxTableViewCellA"];
        if (cell == nil) {
            cell = [[LHHomeTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LHBoxTableViewCellA" newCustomerWithCollectionFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*2/5+10+50*kRatio)];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.homeTitleView.chineseLabel.text = @"新手须知";
        cell.homeTitleView.englishLael.text = @"GET TO KNOW US";
      [cell clickBuyNewCollectionViewCellBlock:^(NSIndexPath *index) {
          LHNewHandsViewController *newVC = [[LHNewHandsViewController alloc] init];
          newVC.index = index.row;
          [self.navigationController pushViewController:newVC animated:YES];
      }];

        return cell;
    } else {
        if (indexPath.row == 0) {
            LHHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHBoxTableViewCellB"];
            if (cell == nil) {
                cell = [[LHHomeTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LHBoxTableViewCellB" recommendSpecialWithCollectionFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*9/10 + 10 + 50*kRatio)];

            }
            cell.homeTitleView.chineseLabel.text = @"精选推介";
            cell.homeTitleView.englishLael.text = @"SPECIAL ITEMS";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell getThemeDataArray:_themeArray];
            
            [cell clickSpecialCollectionViewCellBlock:^(NSIndexPath *index) {
//                NSLog(@"%ld", index.row);
                LHChooseGoodsViewController *chooseVC = [[LHChooseGoodsViewController alloc] init];
                chooseVC.themesModel = self.themeArray[index.row];
                [self.navigationController pushViewController:chooseVC animated:YES];
            }];
            
            
            return cell;
        } else {
            LHHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHBoxTableViewCellC"];
            if (cell == nil) {
                cell = [[LHHomeTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LHBoxTableViewCellC" goodsCollectionFrame:CGRectMake(0, 0, kScreenWidth, (kScreenWidth + 45)*4/9+10)];
                
            }

            cell.themesModel = self.themeArray[indexPath.row-1];
            cell.themeGoodsModel = self.themeGoodsArray[indexPath.row-1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return kScreenWidth*2/5 + 10 + 50*kRatio;
    } else {
        if (indexPath.row == 0) {
            return kScreenWidth*4/5 + 10 + 50*kRatio;
        } else {
            return (kScreenWidth + 45)*4/9 + 10 + 50*kRatio;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 15;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row != 0) {
        LHChooseGoodsViewController *chooseVC = [[LHChooseGoodsViewController alloc] init];
//        NSLog(@"------%ld", indexPath.row);
        chooseVC.themesModel = self.themeArray[indexPath.row-1];
        [self.navigationController pushViewController:chooseVC animated:YES];
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
