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

@interface LHChooseClothesViewController ()<UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/*搜索框*/
@property (nonatomic, strong) UISearchBar *chooseSearchBar;

@property (nonatomic, strong) UICollectionView *chooseColllectionView;

/**
 存储请求到的商品
 */
@property (nonatomic, strong) NSMutableArray *goodsArray;

@property (nonatomic, strong) LHChooseTypeView *chooseView;

@property (nonatomic, strong) UIButton *openButton;


@end

@implementation LHChooseClothesViewController

- (NSMutableArray *)goodsArray {
    if (!_goodsArray) {
        self.goodsArray = [NSMutableArray new];
    }
    return _goodsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCollectionView];
    [self setChooseJumpView];
    [self setScreeningView];
    [self setHBK_NavigationBar];
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
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kFit(45))];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth/2, kFit(45))];
    titleLabel.text = @"全部类别";
    titleLabel.font = kFont(15);
    [bgView addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-kFit(30), kFit(15), kFit(15), kFit(15))];
    imageView.image = kImage(@"ChooseClothes_open");
    [bgView addSubview:imageView];
    
    LHDevider *devider = [[LHDevider alloc] initWithFrame:CGRectMake(0, kFit(45)-0.5, kScreenWidth, 0.5)];
    [bgView addSubview:devider];
    
    self.openButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.openButton.frame = CGRectMake(0, 0, kScreenWidth, kFit(45));
    [self.openButton addTarget:self action:@selector(openAndCloseAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bgView addSubview:self.openButton];
}

/**
 创建collectionView
 */
- (void)setCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.chooseColllectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64+kFit(45), kScreenWidth, kScreenHeight-64-kFit(45)-49) collectionViewLayout:layout];
    self.chooseColllectionView.dataSource = self;
    self.chooseColllectionView.delegate = self;
    self.chooseColllectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.chooseColllectionView];
    
    [self.chooseColllectionView registerNib:[UINib nibWithNibName:@"LHNewGoodsCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"LHNewGoodsCollectionCell"];
}

/*
 弹出来的筛选的View
*/
 - (void)setChooseJumpView {
    self.chooseView = [[LHChooseTypeView alloc] initWithFrame:CGRectMake(0, -(kFit(40)*5-(64+kFit(45))), kScreenWidth, kFit(40)*5)];
     self.chooseView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.chooseView];
}


#pragma mark ---------------------- <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LHNewGoodsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHNewGoodsCollectionCell" forIndexPath:indexPath];
    cell.titleLabel.font = kFont(13*kRatio);
    cell.lfeelPriceLabel.font = kFont(12*kRatio);
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




#pragma mark ---------- Action -------------

- (void)openAndCloseAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        NSLog(@"展开%d", sender.selected);
        [self showChooseView];
    } else {
        NSLog(@"合上%d", sender.selected);
        [self hideChooseView];
    }
}

- (void)showChooseView {
    [UIView animateWithDuration:0.5 animations:^{
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
