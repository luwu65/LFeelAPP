//
//  LHNewGoodsViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHNewGoodsViewController.h"
#import "LHNewGoodsCell.h"
#import "LHNewGoodsCollectionCell.h"
#import "LHBrondCollectionCell.h"
#import "LHNewGoodsHeaderView.h"
#import "LHGoodsListViewController.h"
#import "LHNewGoodsModel.h"
@interface LHNewGoodsViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>

@property (nonatomic, strong) UITableView *newsGoodTableView;
@property (nonatomic, strong) UICollectionView *newsGoodCollectionView;
//记录点击了第几个cell, 相应的collectionView上的数据变化
@property (nonatomic, assign) NSUInteger clickIndex;
/*搜索框*/
@property (nonatomic, strong) UISearchBar *newsGoodSearchBar;

/**
 一级类别
 */
@property (nonatomic, strong) NSMutableArray *categoryListArray;

/**
 存放请求到的商品
 */
@property (nonatomic, strong) NSMutableArray *goodsArray;

/**
 存放一级类别下的二级类别, 比如男装-->上衣,裤子
 */
@property (nonatomic, strong) NSMutableArray *detailListArray;

@end

@implementation LHNewGoodsViewController

- (NSMutableArray *)categoryListArray {
    if (!_categoryListArray) {
        self.categoryListArray = [NSMutableArray new];
    }
    return _categoryListArray;
}

- (NSMutableArray *)goodsArray {
    if (!_goodsArray) {
        self.goodsArray = [NSMutableArray new];
    }
    return _goodsArray;
}

- (NSMutableArray *)detailListArray {
    if (!_detailListArray) {
        self.detailListArray = [NSMutableArray new];
    }
    return _detailListArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setHBK_NavigationBar];
    [self setUI];
    [self requestCategoryListData];

    
    
}



#pragma mark  ------------------------ UI ------------------------------------
- (void)setUI {
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:kColor(242, 242, 242)] forBarMetrics:UIBarMetricsDefault];
    
    self.newsGoodTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth/4, kScreenHeight-kNBarTBarHeight) style:(UITableViewStylePlain)];
    self.newsGoodTableView.dataSource = self;
    self.newsGoodTableView.delegate = self;
//    self.newsGoodTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.newsGoodTableView];

    self.clickIndex = 0;
    self.newsGoodTableView.tableFooterView = [[UIView alloc] init];
    
    [self.newsGoodTableView registerNib:[UINib nibWithNibName:@"LHNewGoodsCell" bundle:nil] forCellReuseIdentifier:@"LHNewGoodsCell"];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.newsGoodCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kScreenWidth/4, 64, kScreenWidth/4*3, kScreenHeight-kNBarTBarHeight) collectionViewLayout:layout];
    self.newsGoodCollectionView.dataSource = self;
    self.newsGoodCollectionView.delegate = self;
    self.newsGoodCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.newsGoodCollectionView];
    
    [self.newsGoodCollectionView registerNib:[UINib nibWithNibName:@"LHNewGoodsCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"LHNewGoodsCollectionCell"];
    [self.newsGoodCollectionView registerNib:[UINib nibWithNibName:@"LHBrondCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"LHBrondCollectionCell"];
    
    [self.newsGoodCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LHNewGoodsHeaderView"];
    [self.newsGoodCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LHNewGoodsHeaderViewImage"];

}
- (void)setHBK_NavigationBar {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    bgView.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:bgView];
    // 分隔线
    CALayer * layer = [CALayer layer];
    layer.frame = CGRectMake(0, 63.5, kScreenWidth, 0.5);
    layer.backgroundColor = HexColorInt32_t(DDDDDD).CGColor;
    [self.view.layer addSublayer:layer];
    
    _newsGoodSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(15, 20, kScreenWidth-30, 44)];
    _newsGoodSearchBar.barTintColor = kColor(245, 245, 245);
    _newsGoodSearchBar.layer.borderWidth = 0;
    _newsGoodSearchBar.placeholder = @"输入品牌或商品名称";
    _newsGoodSearchBar.searchBarStyle = UISearchBarStyleMinimal;
    _newsGoodSearchBar.delegate = self;
    [bgView addSubview:_newsGoodSearchBar];
}
#pragma mark ------------ UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHNewGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHNewGoodsCell" forIndexPath:indexPath];
    cell.listModel = self.categoryListArray[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44*kRatio + 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.clickIndex = indexPath.row;
    if (indexPath.row != 0) {
        LHCategoryListModel *model = self.categoryListArray[indexPath.row];
        [self requestCategoryDetailDataWithID:model];
    } else {
        [self.newsGoodCollectionView reloadData];
    }
}

#pragma mark ------------ UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.clickIndex == 0) {
        return self.goodsArray.count;
        
    } else {
        return self.detailListArray.count;
        
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.clickIndex == 0) {
        LHNewGoodsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHNewGoodsCollectionCell" forIndexPath:indexPath];
        cell.listModel = self.goodsArray[indexPath.row];

        [cell handleCollecitonBtnAction:^(BOOL isClick) {
            LHGoodsListModel *model = self.goodsArray[indexPath.row];
            if (isClick) {
                KMyLog(@"收藏了");
                model.iscollection = @"0";
            } else {
                KMyLog(@"取消收藏了");
                model.iscollection = @"1";
            }
            [self requestCollectGoodsDataWithModel:model];
        }];
        
        return cell;
    } else {
        LHBrondCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHBrondCollectionCell" forIndexPath:indexPath];
        cell.listModel = self.detailListArray[indexPath.row];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.clickIndex == 0) {
        return CGSizeMake((kScreenWidth/4*3-15)/2, (kScreenWidth/4*3-15)/2*1.2 + 40*kRatio);
    } else {
        return CGSizeMake((kScreenWidth/4*3-20)/3, (kScreenWidth/4*3-20)/3 + 20*kRatio);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//这个方法是返回 Header的大小 size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (self.clickIndex == 0) {
        return CGSizeMake(kScreenWidth/4*3, 40*kRatio);
    } else {
        return CGSizeMake(kScreenWidth/4*3, kFit(100));
    }
}

//这个也是最重要的方法 获取Header的 方法。
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (self.clickIndex == 0) {
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LHNewGoodsHeaderView" forIndexPath:indexPath];
        LHNewGoodsHeaderView *headerView = [[LHNewGoodsHeaderView alloc] initWithFrame:CGRectMake(0, 0, reusableView.frame.size.width, reusableView.frame.size.height)];
        [headerView clickRightLabelBlock:^{
            NSLog(@"更多");
            LHGoodsListViewController *goodsList= [[LHGoodsListViewController alloc] init];
            goodsList.isRecommend = @"isRecommend";
            [self.navigationController pushViewController:goodsList animated:YES];
        }];
        //此举是防止collectionHeaderView重用
        if (reusableView.subviews.count >= 1) {
            return reusableView;
        }
        [reusableView addSubview:headerView];
        return reusableView;
        
    } else {
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LHNewGoodsHeaderViewImage" forIndexPath:indexPath];

        LHNewGoodsCategoryHeaderView *headerView = [[LHNewGoodsCategoryHeaderView alloc] initWithFrame:CGRectMake(0, 0, reusableView.frame.size.width, reusableView.frame.size.height)];
        LHCategoryListModel *model = self.categoryListArray[self.clickIndex];
        headerView.model = model;
        //此举是为了防止header重用, 赋值不正确, 遍历他的subViews, 删掉再添加
        if (reusableView.subviews.count >= 1) {
            for (UIView *subView in reusableView.subviews) {
                [subView removeFromSuperview];
            }
        }
        [reusableView addSubview:headerView];
        return reusableView;
    }
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.clickIndex == 0) {

        
    } else {
        LHGoodsListViewController *goodsListVC = [[LHGoodsListViewController alloc] init];
        goodsListVC.listModel = self.detailListArray[indexPath.row];
        [self.navigationController pushViewController:goodsListVC animated:YES];
    }
    
}

#pragma mark ------------------- 请求

/**
 请求商品分类, 左边tableView展示的内容
 */
- (void)requestCategoryListData {
    [self showProgressHUD];
    [LHNetworkManager requestForGetWithUrl:kCategoryListUrl parameter:@{@"id": @0} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            for (NSDictionary *dic in reponseObject[@"data"]) {
                LHCategoryListModel *model = [[LHCategoryListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.categoryListArray addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.newsGoodTableView reloadData];
            //此处做延迟是防止请求太快, user_id还没有读取出来
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self requestRecommendGoodsListData];
            });
            //默认选中第一行
            [self.newsGoodTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        });
    } failure:^(NSError *error) {
        
        
    }];
}

/**
 请求推荐的商品列表
 */
- (void)requestRecommendGoodsListData {
    //recommended 是否推荐 0 --> 不推荐; 1 --> 推荐
    //type 0 --> 购买的商品; 1 --> 租赁的商品
//    NSLog(@"---------------> %@", kUser_id);
    [LHNetworkManager requestForGetWithUrl:kNewGoodsListUrl parameter:@{@"recommend": @1, @"user_id": kUser_id, @"type": @0} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            for (NSDictionary *dic in reponseObject[@"data"]) {
                LHGoodsListModel *model = [[LHGoodsListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.goodsArray addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideProgressHUD];

            [self.newsGoodCollectionView reloadData];
        });
    } failure:^(NSError *error) {
            
    }];
}


/**
 某一个分类下的子分类, 比如男装下面的 T恤, 衬衫等

 @param model 点击的那个分类 model
 */
- (void)requestCategoryDetailDataWithID:(LHCategoryListModel *)model {
    [self showProgressHUD];
    [LHNetworkManager requestForGetWithUrl:kCategoryDetailListUrl parameter:@{@"id": model.id_} success:^(id reponseObject) {
        NSLog(@"---->%@", reponseObject);
        [self.detailListArray removeAllObjects];
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            for (NSDictionary *dic in reponseObject[@"data"]) {
                LHCategoryDetailListModel *model = [[LHCategoryDetailListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.detailListArray addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideProgressHUD];
            [self.newsGoodCollectionView reloadData];
        });
    } failure:^(NSError *error) {

    }];
}


/**
 收藏/ 取消收藏

 @param model 收藏或取消收藏的模型
 */
- (void)requestCollectGoodsDataWithModel:(LHGoodsListModel *)model {
    NSString *url = nil;
    if ([model.iscollection integerValue] == 0) {
        url = kCollectionGoodsUrl;
    } else {
        url = kUncollectionGoodsUrl;
    }
    [LHNetworkManager PostWithUrl:url parameter:@{@"product_id": model.product_id, @"user_id": kUser_id, @"type": @0} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([model.iscollection integerValue] == 0) {
            if (reponseObject[@"errorCode"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showSuccess:@"收藏成功"];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:@"收藏失败"];
                });
            }
        } else {
            if (reponseObject[@"errorCode"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showSuccess:@"取消收藏"];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:@"取消收藏失败"];
                });
            }
        }

    } failure:^(NSError *error) {
        
    }];
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
