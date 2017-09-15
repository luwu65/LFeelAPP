//
//  LHCategoryListViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/21.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHCategoryListViewController.h"
#import "LHTagView.h"
#import "LHNewGoodsCollectionCell.h"


@interface LHCategoryListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/**
 商品列表
 */
@property (nonatomic, strong) UICollectionView *goodsColllectionView;

@end

@implementation LHCategoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self setHBK_NavigationBar];
    
}

#pragma mark ------------------ UI --------------

- (void)setUI {
    LHTagView *sizeView = [[LHTagView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kFit(35)) TxtArray:kClothesSize];
    sizeView.ClickTagBlock = ^(NSInteger index) {
        NSLog(@"%@", kClothesSize[index]);
    };
    [self.view addSubview:sizeView];
    
    //下面的商品列表
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.goodsColllectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64+kFit(35), kScreenWidth, kScreenHeight-64-kFit(35)) collectionViewLayout:layout];
    self.goodsColllectionView.dataSource = self;
    self.goodsColllectionView.delegate = self;
    self.goodsColllectionView.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:self.goodsColllectionView];
    
    [self.goodsColllectionView registerNib:[UINib nibWithNibName:@"LHNewGoodsCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"LHNewGoodsCollectionCell"];
    
}

- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
   self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:self.categoryModel.category_name backAction:^{
       [self.navigationController popViewControllerAnimated:YES];
   }];
}



#pragma mark ---------------------- <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LHNewGoodsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHNewGoodsCollectionCell" forIndexPath:indexPath];
    cell.titleLabel.font = kFont(13*kRatio);
    cell.lfeelPriceLabel.hidden = YES;
    //    cell.listModel = self.goodsArray[indexPath.row];
    [cell handleCollecitonBtnAction:^(BOOL isClick) {
        //        LHGoodsListModel *model = self.goodsArray[indexPath.row];
        //        if (isClick) {
        //            model.iscollection = @"0";
        //        } else {
        //            model.iscollection = @"1";
        //        }
        //        [self requestCollectGoodsDataWithModel:model];
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







































- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
