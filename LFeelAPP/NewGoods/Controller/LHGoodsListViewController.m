//
//  LHGoodsListViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/22.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHGoodsListViewController.h"
#import "LHNewGoodsCollectionCell.h"
@interface LHGoodsListViewController ()<UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UISearchBar *newsGoodSearchBar;
@property (nonatomic, strong) UIButton *newsBtn;
@property (nonatomic, strong) UIButton *priceBtn;

@property (nonatomic, assign) NSInteger priceBtnClickIndex;//价格button被点击的次数

@property (nonatomic, strong) UICollectionView *goodsCollectionView;

@end

@implementation LHGoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self setHBK_NavigationBar];
}




- (void)setUI {
    self.priceBtnClickIndex = 0;
    
    UIView *btnBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 40*kRatio)];
    btnBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btnBgView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39*kRatio, kScreenWidth, 1)];
    lineView.backgroundColor = kColor(245, 245, 245);
    [btnBgView addSubview:lineView];
    
    self.newsBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.newsBtn setTitle:@"新品" forState:(UIControlStateNormal)];
    self.newsBtn.titleLabel.font = kFont(15*kRatio);
    [self.newsBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.newsBtn addTarget:self action:@selector(newBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.newsBtn.frame = CGRectMake(0, 0, kScreenWidth/2, 39*kRatio);
    [btnBgView addSubview:self.newsBtn];
    
    
    _priceBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_priceBtn setTitle:@"价格" forState:(UIControlStateNormal)];
    _priceBtn.titleLabel.font = kFont(15*kRatio);
    [_priceBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_priceBtn setImage:[UIImage imageNamed:@"NewGoods_price_default"] forState:(UIControlStateNormal)];
    _priceBtn.frame = CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 39*kRatio);
    [_priceBtn addTarget:self action:@selector(priceBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    _priceBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -75*kRatio);
    [btnBgView addSubview:self.priceBtn];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.goodsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40*kRatio+64, kScreenWidth, kScreenHeight-64-40*kRatio) collectionViewLayout:layout];
    self.goodsCollectionView.dataSource = self;
    self.goodsCollectionView.delegate = self;
    self.goodsCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.goodsCollectionView];

    [self.goodsCollectionView registerNib:[UINib nibWithNibName:@"LHNewGoodsCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"LHNewGoodsCollectionCell"];
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
    
    _newsGoodSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(44, 20, kScreenWidth-44, 44)];
    _newsGoodSearchBar.barTintColor = kColor(245, 245, 245);
    _newsGoodSearchBar.layer.borderWidth = 0;
    _newsGoodSearchBar.placeholder = @"输入品牌或商品名称";
    _newsGoodSearchBar.searchBarStyle = UISearchBarStyleMinimal;
    _newsGoodSearchBar.delegate = self;
    [bgView addSubview:_newsGoodSearchBar];
    
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backBtn setImage:kImage(@"Back_Button") forState:(UIControlStateNormal)];
    backBtn.frame = CGRectMake(0, 20, 44, 44);
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [bgView addSubview:backBtn];
}

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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   LHNewGoodsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHNewGoodsCollectionCell" forIndexPath:indexPath];
    NSString *priStr = @"官网价: ¥19999";
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:priStr];
    [attributeMarket setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle)} range:NSMakeRange(0,priStr.length)];
    cell.webPriceLabel.attributedText = attributeMarket;
    cell.titleLabel.font = kFont(13*kRatio);
    cell.lfeelPriceLabel.font = kFont(12*kRatio);
    cell.webPriceLabel.font = kFont(12*kRatio);
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth-15)/2, (kScreenWidth-15)*3/5 + 40*kRatio);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
