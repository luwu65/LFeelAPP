//
//  LHGoodsListViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/22.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHGoodsListViewController.h"
#import "LHNewGoodsCollectionCell.h"
#import "LHNewGoodsDetailViewController.h"
@interface LHGoodsListViewController ()<UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UISearchBar *newsGoodSearchBar;
@property (nonatomic, strong) UIButton *newsBtn;
@property (nonatomic, strong) UIButton *priceBtn;

@property (nonatomic, assign) NSInteger priceBtnClickIndex;//价格button被点击的次数

@property (nonatomic, strong) UICollectionView *goodsCollectionView;
@property (nonatomic, strong) NSMutableArray *goodsArray;

@end

@implementation LHGoodsListViewController
- (NSMutableArray *)goodsArray {
    if (!_goodsArray) {
        self.goodsArray = [NSMutableArray new];
    }
    return _goodsArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self setHBK_NavigationBar];
    
    if (self.isRecommend) {
        [self requestGoodsListDataWithModel:nil];
    } else {
        [self requestGoodsListDataWithModel:self.listModel];
    }
   
}



#pragma mark --------------- UI ------------------------------
- (void)setUI {
    self.priceBtnClickIndex = 0;
    
    UIView *btnBgView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, kFit(40))];
    btnBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btnBgView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kFit(39), kScreenWidth, 1)];
    lineView.backgroundColor = kColor(245, 245, 245);
    [btnBgView addSubview:lineView];
    
    self.newsBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.newsBtn setTitle:@"新品" forState:(UIControlStateNormal)];
    self.newsBtn.titleLabel.font = kFont(kFit(15));
    [self.newsBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.newsBtn addTarget:self action:@selector(newBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.newsBtn.frame = CGRectMake(0, 0, kScreenWidth/2, kFit(39));
    [btnBgView addSubview:self.newsBtn];
    
    
    _priceBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_priceBtn setTitle:@"价格" forState:(UIControlStateNormal)];
    _priceBtn.titleLabel.font = kFont(kFit(15));
    [_priceBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_priceBtn setImage:[UIImage imageNamed:@"NewGoods_price_default"] forState:(UIControlStateNormal)];
    _priceBtn.frame = CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, kFit(39));
    [_priceBtn addTarget:self action:@selector(priceBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    _priceBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -kFit(75));
    [btnBgView addSubview:self.priceBtn];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.goodsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kFit(40)+kNavBarHeight, kScreenWidth, kScreenHeight-kNavBarHeight-kFit(40)-kIPhoneXBottomHeight) collectionViewLayout:layout];
    self.goodsCollectionView.dataSource = self;
    self.goodsCollectionView.delegate = self;
    self.goodsCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.goodsCollectionView];
    [self LH_Refresh];
    [self.goodsCollectionView registerNib:[UINib nibWithNibName:@"LHNewGoodsCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"LHNewGoodsCollectionCell"];
}
- (void)setHBK_NavigationBar {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight)];
    bgView.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:bgView];
    // 分隔线
    CALayer * layer = [CALayer layer];
    layer.frame = CGRectMake(0, 63.5, kScreenWidth, 0.5);
    layer.backgroundColor = HexColorInt32_t(DDDDDD).CGColor;
    [self.view.layer addSublayer:layer];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, bgView.maxY-44, kScreenWidth, 44)];
    [bgView addSubview:bottomView];
    
    _newsGoodSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(44, 0, kScreenWidth-44, 44)];
    _newsGoodSearchBar.barTintColor = kColor(245, 245, 245);
    _newsGoodSearchBar.layer.borderWidth = 0;
    _newsGoodSearchBar.placeholder = @"输入品牌或商品名称";
    _newsGoodSearchBar.searchBarStyle = UISearchBarStyleMinimal;
    _newsGoodSearchBar.delegate = self;
    [bottomView addSubview:_newsGoodSearchBar];
    

    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backBtn setImage:kImage(@"Back_Button") forState:(UIControlStateNormal)];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:backBtn];
}

#pragma mark -------------------------- Action ------------------------------
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)newBtnAction:(UIButton *)sender {
    if (sender.selected) {
        [sender setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        NSLog(@"1111");
    } else {
        [sender setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        NSLog(@"2222");
    }
        sender.selected = !sender.selected;
}

- (void)priceBtnAction:(UIButton *)sender {
    self.priceBtnClickIndex++;
    if (self.priceBtnClickIndex == 1) {//从大到小排序
        [sender setImage:[UIImage imageNamed:@"NewGoods_price_up"] forState:(UIControlStateNormal)];
    } else if (self.priceBtnClickIndex == 2) {//从小到大排序
        [sender setImage:[UIImage imageNamed:@"NewGoods_price_down"] forState:(UIControlStateNormal)];
    } else if (_priceBtnClickIndex == 3) {//默认
        self.priceBtnClickIndex = 0;
        [sender setImage:[UIImage imageNamed:@"NewGoods_price_default"] forState:(UIControlStateNormal)];
    }
}

- (void)LH_Refresh {
    self.goodsCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"刷新");
        [self.goodsArray removeAllObjects];
        if (self.isRecommend) {
            [self requestGoodsListDataWithModel:nil];
        } else {
            [self requestGoodsListDataWithModel:self.listModel];
        }
    }];
    self.goodsCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"加载");
        if (self.isRecommend) {
            [self requestGoodsListDataWithModel:nil];
        } else {
            [self requestGoodsListDataWithModel:self.listModel];
        }
    }];
}


#pragma mark ---------------------- <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   LHNewGoodsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHNewGoodsCollectionCell" forIndexPath:indexPath];
    cell.titleLabel.font = kFont(kFit(13));
    cell.lfeelPriceLabel.font = kFont(kFit(12));
    cell.listModel = self.goodsArray[indexPath.row];
    [cell handleCollecitonBtnAction:^(BOOL isClick) {
        LHGoodsListModel *model = self.goodsArray[indexPath.row];
        if (isClick) {
            model.iscollection = @"0";
        } else {
            model.iscollection = @"1";
        }
        [self requestCollectGoodsDataWithModel:model];
    }];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth-15)/2, (kScreenWidth-15)*3/5 + kFit(40));
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LHNewGoodsDetailViewController *newVC = [[LHNewGoodsDetailViewController alloc] init];
    newVC.listModel = self.goodsArray[indexPath.row];
    [self.navigationController pushViewController:newVC animated:YES];
}

#pragma mark -------------------------- 网络请求 ------------------
/**
 请求推荐的商品列表
 */
- (void)requestGoodsListDataWithModel:(LHCategoryDetailListModel *)model {
    [self showProgressHUD];
    //recommended 是否推荐 0 --> 不推荐; 1 --> 推荐
    //type 0 --> 购买的商品; 1 --> 租赁的商品 , @"user_id": kUser_id
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if (model) {
         NSDictionary *aDic = @{@"id": model.id_, @"type": @0};
        dic = [aDic mutableCopy];
    } else {
        NSDictionary *aDic = @{@"recommend": @1, @"type": @0};
        dic = [aDic mutableCopy];
    }
    [LHNetworkManager requestForGetWithUrl:kNewGoodsListUrl parameter:dic success:^(id reponseObject) {
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
            [self.goodsCollectionView.mj_header endRefreshing];
            [self.goodsCollectionView.mj_footer endRefreshing];
            [self.goodsCollectionView reloadData];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
