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
#import "LHMyBoxViewController.h"

@interface LHNewGoodsViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>

@property (nonatomic, strong) UITableView *newsGoodTableView;
@property (nonatomic, strong) UICollectionView *newsGoodCollectionView;
//记录点击了第几个cell, 响应的collectionView上的数据变化
@property (nonatomic, assign) NSUInteger clickIndex;
/*搜索框*/
@property (nonatomic, strong) UISearchBar *newsGoodSearchBar;

@end

@implementation LHNewGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setHBK_NavigationBar];
    [self setUI];
}

- (void)setUI {
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:kColor(242, 242, 242)] forBarMetrics:UIBarMetricsDefault];
    
    self.newsGoodTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth/4, kScreenHeight-kNBarTBarHeight) style:(UITableViewStylePlain)];
    self.newsGoodTableView.dataSource = self;
    self.newsGoodTableView.delegate = self;
    self.newsGoodTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.newsGoodTableView];
    //默认选中第一行
    [self.newsGoodTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHNewGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHNewGoodsCell" forIndexPath:indexPath];

    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.clickIndex = indexPath.row;
    [self.newsGoodCollectionView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44*kRatio + 5;
}

#pragma mark ------------ UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.clickIndex == 0) {
        LHNewGoodsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHNewGoodsCollectionCell" forIndexPath:indexPath];
        cell.lfeelPriceLabel.text = @"优惠价:10000";
        NSString *priStr = @"官网价:¥19999";
        NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:priStr];
        [attributeMarket setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle)} range:NSMakeRange(0,priStr.length)];
        cell.webPriceLabel.attributedText = attributeMarket;
    
        return cell;
    } else {
        LHBrondCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHBrondCollectionCell" forIndexPath:indexPath];
        
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
        return CGSizeMake(kScreenWidth/4*3, 100*kRatio);
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
        LHNewGoodsHeaderView *headerView = [[LHNewGoodsHeaderView alloc] initWithFrame:CGRectMake(0, 0, reusableView.frame.size.width, reusableView.frame.size.height) imageUrl:@"" title:@"奢华大牌"];
        if (reusableView.subviews.count >= 1) {
            return reusableView;
        }
        [reusableView addSubview:headerView];
        
        return reusableView;
    }
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.clickIndex == 0) {
        //假数据, 随便跳转的   不用就删掉
        
        ///头文件也要删掉
        LHMyBoxViewController *boxVC = [[LHMyBoxViewController alloc] init];
        boxVC.subPage = YES;
        [self.navigationController pushViewController:boxVC animated:YES];
    
    } else {
        LHGoodsListViewController *goodsListVC = [[LHGoodsListViewController alloc] init];
        [self.navigationController pushViewController:goodsListVC animated:YES];
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
