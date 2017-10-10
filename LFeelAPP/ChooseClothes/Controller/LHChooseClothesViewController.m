//
//  LHChooseClothesViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/2.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHChooseClothesViewController.h"
#import "LHNewGoodsCollectionCell.h"
#import "LHChooseTypeView.h"
#import "LHTagView.h"
#import "LHCategoryView.h"
#import "LHCategoryListViewController.h"
#import "LHGoodsDetailViewController.h"

@interface LHChooseClothesViewController ()<UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/*搜索框*/
@property (nonatomic, strong) UISearchBar *chooseSearchBar;

/**
 商品列表
 */
@property (nonatomic, strong) UICollectionView *goodsColllectionView;


/**
 存储请求到的商品
 */
@property (nonatomic, strong) NSMutableArray *goodsArray;

@property (nonatomic, strong) LHChooseTypeView *chooseView;

/**
 全部类别button
 */
@property (nonatomic, strong) UIButton *openButton;

/**
 全部类别View
 */
@property (nonatomic, strong) UIView *categoryView;

/**
 全部类别
 */
@property (nonatomic, strong) LHTagView *allCategoryView;

//self.allCategoryLabel
@property (nonatomic, strong) UILabel *allCategoryLabel;
/**
 一级类别
 */
@property (nonatomic, strong) NSMutableArray *categoryListArray;

@end

@implementation LHChooseClothesViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self requestCategoryListData];
    
    
    
}


#pragma mark  --------------- UI --------------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    bgView.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:bgView];
    // 分隔线
    CALayer * layer = [CALayer layer];
    layer.frame = CGRectMake(0, 63.5, kScreenWidth, 0.5);
    layer.backgroundColor = HexColorInt32_t(DDDDDD).CGColor;
    [self.view.layer addSublayer:layer];
    
    _chooseSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(15, 20, kScreenWidth-30, 44)];
    _chooseSearchBar.barTintColor = kColor(245, 245, 245);
    _chooseSearchBar.layer.borderWidth = 0;
    _chooseSearchBar.placeholder = @"输入品牌或商品名称";
    _chooseSearchBar.searchBarStyle = UISearchBarStyleMinimal;
    _chooseSearchBar.delegate = self;
    [bgView addSubview:_chooseSearchBar];
}


/**
 创建筛选条件的横条 ----> 全部品类
 */
- (void)setScreeningView {
    self.categoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kFit(45))];
    self.categoryView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.categoryView];
    
    self.allCategoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-kFit(30), kFit(45))];
    self.allCategoryLabel.text = @"规格";
    self.allCategoryLabel.font = kFont(15);
    [self.categoryView addSubview:self.allCategoryLabel];
    
//    self.allCategoryView = [[LHTagView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-kFit(30), kFit(45)) TxtArray:@[@"全部类别"]];
//    [self.categoryView addSubview:self.allCategoryView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-kFit(30), kFit(15), kFit(15), kFit(15))];
    imageView.image = kImage(@"ChooseClothes_open");
    [self.categoryView addSubview:imageView];
    
    LHDevider *devider = [[LHDevider alloc] initWithFrame:CGRectMake(0, kFit(45)-0.5, kScreenWidth, 0.5)];
    [self.categoryView addSubview:devider];
    
    self.openButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.openButton.frame = CGRectMake(0, 0, kScreenWidth, kFit(45));
    [self.openButton addTarget:self action:@selector(openAndCloseAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.categoryView addSubview:self.openButton];
}

/**
 创建collectionView
 */
- (void)setCollectionView {
    //下面的商品列表
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.goodsColllectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64+kFit(45), kScreenWidth, kScreenHeight-64-kFit(45)-49) collectionViewLayout:layout];
    self.goodsColllectionView.dataSource = self;
    self.goodsColllectionView.delegate = self;
    self.goodsColllectionView.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:self.goodsColllectionView];
    
    [self.goodsColllectionView registerNib:[UINib nibWithNibName:@"LHNewGoodsCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"LHNewGoodsCollectionCell"];
    [self.goodsColllectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LHCategoryView"];

    self.goodsColllectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"下拉刷新");
        [self.goodsArray removeAllObjects];
        [self requestRecommendGoodsListData];
    }];
    self.goodsColllectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"上拉加载");
        [self requestRecommendGoodsListData];
    }];
}

/*
 弹出来的筛选的View
*/
 - (void)setChooseJumpView {
    self.chooseView = [[LHChooseTypeView alloc] initWithFrame:CGRectMake(0, -(kFit(40)*5-(64+kFit(45))), kScreenWidth, kFit(40)*5)];
     @weakify(self);
    self.chooseView.ClickSubmitBlock = ^(NSArray *selectArrray){
        @strongify(self);
        [self hideChooseView];
        self.openButton.selected = NO;
        
    };
    [self.view addSubview:self.chooseView];
}


#pragma mark ---------------------- <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LHNewGoodsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHNewGoodsCollectionCell" forIndexPath:indexPath];
    cell.titleLabel.font = kFont(13*kRatio);
    cell.lfeelPriceLabel.hidden = YES;
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
    return CGSizeMake((kScreenWidth-15)/2, (kScreenWidth-15)*3/5 + kFit(30));
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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LHCategoryView" forIndexPath:indexPath];
    LHCategoryView *categoryView = [[LHCategoryView alloc] initWithFrame:CGRectMake(0, 0, reusableView.frame.size.width, reusableView.frame.size.height)];
    categoryView.categoryArray = self.categoryListArray;
    categoryView.ClickCategoryBlock = ^(NSInteger index) {
        NSLog(@"%ld", (long)index);
        LHCategoryListViewController *listVC = [[LHCategoryListViewController alloc] init];
        listVC.categoryModel = self.categoryListArray[index];
        [self.navigationController pushViewController:listVC animated:YES];
    };
    
    
    //此举是防止collectionHeaderView重用
    if (reusableView.subviews.count >= 1) {
        return reusableView;
    }
    [reusableView addSubview:categoryView];
    return reusableView;
}

//这个方法是返回 Header的大小 size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, (kScreenWidth-30)/5 * 1.2 * 2+kFit(40)+20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LHGoodsDetailViewController *goodDetailVC = [[LHGoodsDetailViewController alloc] init];
    LHGoodsListModel *model = self.goodsArray[indexPath.row];
    goodDetailVC.product_id = model.product_id;
    [self.navigationController pushViewController:goodDetailVC animated:YES];
}



#pragma mark ---------- Action -------------
- (void)openAndCloseAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
//        NSLog(@"展开%d", sender.selected);
        [self showChooseView];
    } else {
//        NSLog(@"合上%d", sender.selected);
        [self hideChooseView];
    }
}

- (void)showChooseView {
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint point = self.chooseView.center;
        point.y = kFit(40)*5 + point.y;
        self.chooseView.center = point;
    }];
}

- (void)hideChooseView {
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint point = self.chooseView.center;
        point.y = point.y - kFit(40)*5;
        self.chooseView.center = point;
    }];
}


#pragma mark ---------- 网络请求 ------------------
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


/**
 请求商品分类
 */
- (void)requestCategoryListData {
    [self showProgressHUD];
    [LHNetworkManager requestForGetWithUrl:kCategoryListUrl parameter:@{@"id": @0, @"isrent": @1} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            for (NSDictionary *dic in reponseObject[@"data"]) {
                LHCategoryListModel *model = [[LHCategoryListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.categoryListArray addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //之前这里有做延迟操作, 防止user_id读取太慢
            [self requestRecommendGoodsListData];
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
    //    NSLog(@"---------------> %@", kUser_id); , @"user_id": kUser_id
    [LHNetworkManager requestForGetWithUrl:kNewGoodsListUrl parameter:@{@"recommend": @1, @"type": @1} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            if (!self.goodsColllectionView) {
                [self setCollectionView];
                [self setChooseJumpView];
                [self setScreeningView];
                [self setHBK_NavigationBar];
            }
            
            for (NSDictionary *dic in reponseObject[@"data"]) {
                LHGoodsListModel *model = [[LHGoodsListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.goodsArray addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideProgressHUD];
            [self.goodsColllectionView.mj_header endRefreshing];
            [self.goodsColllectionView reloadData];
        });
    } failure:^(NSError *error) {
        
    }];
}



#pragma mark -----------------  滑动渐变 ------- 
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    CGFloat y = offset.y;
    if (y > 100) {
        
        
    } else {
        
        
        
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
