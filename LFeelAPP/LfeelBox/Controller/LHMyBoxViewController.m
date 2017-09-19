//
//  LHMyBoxViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHMyBoxViewController.h"
#import "LHSegmentControlView.h"
#import "LHPackingBoxView.h"
#import "LHMyBoxCell.h"
#import "LHPackInfoViewController.h"
#import "LHShoppingCartCell.h"
#import "LHCartHeaderView.h"
#import "LHShoppingCartModel.h"
#import "LHAccountCenterViewController.h"
#import "LHSendBackViewController.h"
#import "LHHomeModel.h"
#import "LHCertificationViewController.h"


#define kTag_CartEmptyView  3101
#define kTag_BoxEmptyView   3102


@interface LHMyBoxViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *boxScrollView;

//换衣盒
@property (nonatomic, strong) UITableView *myBoxTableView;

//购物车
@property (nonatomic, strong) UITableView *shoppingCartTableView;

//储存请求到的店铺
@property (nonatomic, strong) NSMutableArray *storeArray;

//储存选中的商品
@property (nonatomic, strong) NSMutableArray *selectArray;

@property (nonatomic, strong) CustomButton *allSelectBtn;

//底部结算栏
@property (nonatomic, strong) LHPackingBoxView *accrountView;

@property (nonatomic, strong) NSMutableArray *myBoxArray;

//判断其他页面有没有收藏
@property (nonatomic, assign) BOOL CollectionSuccess;

//判断其他页面有没有加入购物车
@property (nonatomic, assign) BOOL AddShoppingSuccess;


@end

@implementation LHMyBoxViewController
#pragma mark ---------------------- 懒加载 --------------------------
- (NSMutableArray *)myBoxArray {
    if (!_myBoxArray) {
        self.myBoxArray = [NSMutableArray new];
    }
    return _myBoxArray;
}

- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        self.selectArray = [NSMutableArray new];
    }
    return _selectArray;
}


- (NSMutableArray *)storeArray {
    if (!_storeArray) {
        self.storeArray = [NSMutableArray new];
    }
    return _storeArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if (self.selectArray.count > 0) {
//        for (LHCartGoodsModel *model in self.selectArray) {
//            model.isSelect = NO;
//        }
//        [self.selectArray removeAllObjects];
//    }
    //初始化显示状态
    //    _allSelectBtn.selected = NO;
    //    self.accrountView.allSelectBtn.selected = NO;
    //    [self countPrice];
    //    [self.shoppingCartTableView reloadData];


    
    //如果左滑右滑被收藏过, 在这里请求
    if (self.CollectionSuccess) {
        [self.myBoxArray removeAllObjects];
        [self requstMyBoxCartData];
        self.CollectionSuccess = NO;
    }
    //如果商品详情里添加购物车了, 就在这里请求
    if (self.AddShoppingSuccess) {
        [self.storeArray removeAllObjects];
        [self requestShoppingCartData];
        //请求过把状态改为No, 否则每次都会请求
        self.AddShoppingSuccess = NO;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CollectionSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AddShoppingCartSuccess" object:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    [self customNavBar];
    //如果左滑右滑没有收藏, 那么就在这里请求
    if (!self.CollectionSuccess) {
        [self requstMyBoxCartData];
    }
    //如果详情页没有添加购物车, 那就在这里请求
    if (!self.AddShoppingSuccess) {
        [self requestShoppingCartData];
    }
    //添加观察者, 如果再其他页面添加了收藏, 或是添加了购物车, 就在方法里改变BOOL值,
    //根据BOOL值的去请求, 避免在viewWillAppear里每次都请求数据 浪费流量,也避免其他地方添加了购物车或收藏,此页面没有请求.
    //作此操作, 提升了用户体验
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CollectionSuccessNotification) name:@"CollectionSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddShoppingCartSuccessNotification) name:@"AddShoppingCartSuccess" object:nil];
    
}


#pragma mark -----------------------  初始化UI控件 --------------------------------
- (void)setUI {
    CGFloat tabBarHeight = 49;
    if ([self.subPage isEqualToString:@"Rent"] || [self.subPage isEqualToString:@"New"]) {
        tabBarHeight = 0;
        self.boxScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-tabBarHeight)];
        self.boxScrollView.contentSize = CGSizeMake(kScreenWidth * 2, kScreenHeight-kNavBarHeight-tabBarHeight);
        self.boxScrollView.pagingEnabled = YES;
        self.boxScrollView.scrollEnabled = NO;
        [self.view addSubview:self.boxScrollView];
        self.boxScrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    } else {
        tabBarHeight = 49;
        self.boxScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-tabBarHeight)];
        self.boxScrollView.contentSize = CGSizeMake(kScreenWidth * 2, kScreenHeight-kNavBarHeight-tabBarHeight);
        self.boxScrollView.pagingEnabled = YES;
        self.boxScrollView.scrollEnabled = NO;
        [self.view addSubview:self.boxScrollView];
    }
    
    UIView *leftBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-tabBarHeight)];
    leftBgView.tag = kTag_BoxEmptyView;
    [self.boxScrollView addSubview:leftBgView];
    
    UIView *rightBgView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight- 64 -tabBarHeight)];
    rightBgView.tag = kTag_CartEmptyView;
    [self.boxScrollView addSubview:rightBgView];
    
    self.myBoxTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight- 64 -tabBarHeight-kAllBarHeight*kRatio) style:(UITableViewStylePlain)];
    self.myBoxTableView.delegate = self;
    self.myBoxTableView.dataSource = self;
    self.myBoxTableView.backgroundColor = kColor(246, 246, 246);
    self.myBoxTableView.tableFooterView = [[UIView alloc] init];
    [leftBgView addSubview:self.myBoxTableView];
    self.myBoxTableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshMyBoxTable)];
    self.myBoxTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshMyBoxTable)];
    
    self.shoppingCartTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight- 64 -tabBarHeight-kAllBarHeight*kRatio) style:(UITableViewStyleGrouped)];
    self.shoppingCartTableView.delegate = self;
    self.shoppingCartTableView.dataSource = self;
    self.shoppingCartTableView.backgroundColor = kColor(246, 246, 246);
    self.shoppingCartTableView.tableFooterView = [[UIView alloc] init];
    [rightBgView addSubview:self.shoppingCartTableView];
    self.shoppingCartTableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreShshoppingCartTable)];
    self.shoppingCartTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshShoppingCartTable)];
    
    [self.shoppingCartTableView registerClass:[LHCartHeaderView class] forHeaderFooterViewReuseIdentifier:@"LHCartHeaderView"];
    
    // ----------------------------------------------  打包 底栏  ----------------------------------
    LHPackingBoxView *packView = [[LHPackingBoxView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kNavBarHeight-tabBarHeight-kAllBarHeight*kRatio, kScreenWidth, kAllBarHeight*kRatio) packingStatusString:@"   随机打包三件给你" packingButtonTitle:nil];
    [packView.packingBtn setTitle:@"打包盒子" forState:(UIControlStateNormal)];
    //将点击事件分离出去, 此方法内仅处理UI事件
    [self packOrBackBoxAction:packView];
    [leftBgView addSubview:packView];
    
    //---------------------------------------------------  结算 底栏  --------------------------------
    self.accrountView = [[LHPackingBoxView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kNavBarHeight-tabBarHeight-kAllBarHeight*kRatio, kScreenWidth, kAllBarHeight*kRatio)];
    self.allSelectBtn = self.accrountView.allSelectBtn;
    [self.allSelectBtn addTarget:self action:@selector(selectAllBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.accrountView.priceLabel.attributedText = [self LHSetString:@"¥0.00"];
    [self goAccrountGoods:self.accrountView];
    [rightBgView addSubview:self.accrountView];
}

- (void)customNavBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    bgView.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:bgView];
    // 分隔线
    CALayer * layer = [CALayer layer];
    layer.frame = CGRectMake(0, 63.5, kScreenWidth, 0.5);
    layer.backgroundColor = HexColorInt32_t(DDDDDD).CGColor;
    [self.view.layer addSublayer:layer];
    
    LHSegmentControlView *segView = [[LHSegmentControlView alloc] initWithFrame:CGRectMake((kScreenWidth-150)/2, 20, 150, 42) titleArray:@[@"换衣盒", @"购物车"] titleFont:kFont(15) titleDefineColor:[UIColor blackColor] titleSelectedColor:[UIColor redColor]];
    [self segmentControlClickAction:segView];
    [bgView addSubview: segView];

    if ([self.subPage isEqualToString:@"New"]) {
        UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backBtn setImage:kImage(@"Back_Button") forState:(UIControlStateNormal)];
        backBtn.frame = CGRectMake(0, 20, 44, 44);
        [backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        [bgView addSubview:backBtn];
        
        //判断上个页面是点击哪个按钮进来的, 对应上相应的scrollView的偏移量
        for (UIView *btn in [segView subviews]) {
            if ([btn isKindOfClass:[UIButton class]]) {
                if (btn.tag == 1 + 3000) {
                    [(UIButton *)btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
                    [UIView animateWithDuration:0.25 animations:^{
                        CGPoint point = segView.sliderView.center;
                        point.x = segView.sliderView.center.x + 75;
                        segView.sliderView.center = point;
                    }];
                } else {
                    [(UIButton *)btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
                }
            }
        }
    } else if ([self.subPage isEqualToString:@"Rent"]) {
        UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backBtn setImage:kImage(@"Back_Button") forState:(UIControlStateNormal)];
        backBtn.frame = CGRectMake(0, 20, 44, 44);
        [backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        [bgView addSubview:backBtn];        
        self.boxScrollView.contentOffset = CGPointMake(0, 0);
    }
}


#pragma mark  ----------------   <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.myBoxTableView) {
        return 1;
    } else {
        return self.storeArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.myBoxTableView) {
        return self.myBoxArray.count;
    } else {
        LHCartStoreModel *model = self.storeArray[section];
        return model.products.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _myBoxTableView) {
        LHMyBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHMyBoxCell"];
        if (cell == nil) {
            cell = [[LHMyBoxCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LHMyBoxCell"];
        }
        cell.collectModel = self.myBoxArray[indexPath.row];
        
        return cell;
    } else {
        static NSString *cellID = @"LHShoppingCartCell";
        LHShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[LHShoppingCartCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
        }
        LHCartStoreModel *storeModel = self.storeArray[indexPath.section];
        LHCartGoodsModel *goodsModel = [storeModel.products objectAtIndex:indexPath.row];
        [self shoppingCartCellClickAction:cell storeModel:storeModel goodsModel:goodsModel indexPath:indexPath];
        [cell reloadDataWithModel:goodsModel];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.shoppingCartTableView) {
        LHCartHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LHCartHeaderView"];
        LHCartStoreModel *model = [self.storeArray objectAtIndex:section];
        view.title = model.shopname;
        [view.storeImageView sd_setImageWithURL:kURL(model.shoplogo) placeholderImage:kImage(@"")];
        view.isSelect = model.isSelect;
        //点击事件, 全选
        [self shoppingCartSectionHeaderAction:view storeModel:model];
        return view;
    }
    return nil;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.shoppingCartTableView) {
        return @"删除";
    } else {
        return @"取消收藏";
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80*kRatio;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.shoppingCartTableView) {
        return kFit(35);
    }
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.shoppingCartTableView) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该商品?" preferredStyle:1];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                LHCartStoreModel *storeModel = [self.storeArray objectAtIndex:indexPath.section];
                LHCartGoodsModel *goodsModel = [storeModel.products objectAtIndex:indexPath.row];
                [storeModel.products removeObjectAtIndex:indexPath.row];
                [self requestDeleteShoppingCartData:goodsModel];
                //    删除
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                if (storeModel.products.count == 0) {
                    [self.storeArray removeObjectAtIndex:indexPath.section];
                }
                
                //判断删除的商品是否已选择
                if ([self.selectArray containsObject:goodsModel]) {
                    //从已选中删除,重新计算价格
                    [self.selectArray removeObject:goodsModel];
                    [self countPrice];
                }
                NSInteger count = 0;
                for (LHCartStoreModel *storeModel in self.storeArray) {
                    count += storeModel.products.count;
                }
                
                if (self.selectArray.count == count) {
                    _allSelectBtn.selected = YES;
                } else {
                    _allSelectBtn.selected = NO;
                }
                
                if (count == 0) {
                    [self emptyShoppingCartView];
                }
                //如果删除的时候数据紊乱,可延迟0.5s刷新一下
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.shoppingCartTableView reloadData];
                });
                
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:okAction];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } else {
        //此处删除换衣盒数据
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该商品?" preferredStyle:1];
//        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil]];
//        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [self requestDeleteBoxGoods:self.myBoxArray[indexPath.row]];
            [self.myBoxArray removeObjectAtIndex:indexPath.row];
            if (self.myBoxArray.count == 0) {
                [self emptyLfeelBoxView];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.myBoxTableView reloadData];
            });
            
//        }]];
//        [self presentViewController:alert animated:YES completion:nil];
    }
}



#pragma mark  ------------------   Action -------------------

/**
 返回
 */
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

//去逛逛首页
- (void)handleGoHomeAction {
    self.tabBarController.selectedIndex = 0;
}
//去逛逛新品
- (void)handleGoBtnNewGoodsAction {
    self.tabBarController.selectedIndex = 1;
}


/**
 换衣盒和购物车切换

 @param segView segView
 */
- (void)segmentControlClickAction:(LHSegmentControlView *)segView {
    [segView clickTitleButtonBlock:^(NSInteger index) {
        if (index == 0) {
            [UIView animateWithDuration:0.3 animations:^{
                self.boxScrollView.contentOffset = CGPointMake(0, 0);
            }];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                self.boxScrollView.contentOffset = CGPointMake(kScreenWidth, 0);
            }];
        }
    }];
}

// --- 全选按钮点击事件
- (void)selectAllBtnAction:(CustomButton *)sender {
    sender.selected = !sender.selected;
    for (LHCartGoodsModel *model in self.selectArray) {
        model.isSelect = NO;
    }
    [self.selectArray removeAllObjects];
    if (sender.selected) {
        [sender.titleImageView setImage:kImage(@"MyBox_clicked")];
        NSLog(@"全选");
        for (LHCartStoreModel *storeModel in self.storeArray) {
            storeModel.isSelect = YES;
            for (LHCartGoodsModel *goodsModel in storeModel.products) {
                goodsModel.isSelect = YES;
                [self.selectArray addObject:goodsModel];
            }
        }
    } else {
        [sender.titleImageView setImage:kImage(@"MyBox_click_default")];
        NSLog(@"反选");
        for (LHCartStoreModel *storeModel in self.storeArray) {
            storeModel.isSelect = NO;
        }
    }
    [self.shoppingCartTableView reloadData];
    [self countPrice];
    
}

//换衣盒刷新
- (void)headerRefreshMyBoxTable {
    [self.myBoxArray removeAllObjects];
    [self requstMyBoxCartData];
}
//换衣盒刷新
- (void)footerRefreshMyBoxTable {
    
    
}
//刷新购物车
- (void)headerRefreShshoppingCartTable {
    [self.storeArray removeAllObjects];
    [self.selectArray removeAllObjects];
    self.accrountView.allSelectBtn.titleImageView.image = kImage(@"MyBox_click_default");
    self.accrountView.allSelectBtn.selected = YES;
    [self requestShoppingCartData];
    [self countPrice];
    
}
//购物车加载
- (void)footerRefreshShoppingCartTable {
    
    
}

/*
 打包盒子, 寄回盒子 点击事件
 */
- (void)packOrBackBoxAction:(LHPackingBoxView *)boxView {
    @weakify(self);
    [boxView clickPackingButtonBlock:^(NSString *packBtnTitle) {
        @strongify(self);
        NSLog(@"%@", packBtnTitle);
//        if ([packBtnTitle isEqualToString:@"打包盒子"]) {
//            
//            LHPackInfoViewController *packVC = [[LHPackInfoViewController alloc] init];
//            [self.navigationController pushViewController:packVC animated:YES];
//            
//        } else if ([packBtnTitle isEqualToString:@"寄回盒子"]) {
//            
//            
//        }
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
                [alertVC addAction:[UIAlertAction actionWithTitle:@"打包盒子" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"打包盒子");
                    LHPackInfoViewController *packVC = [[LHPackInfoViewController alloc] init];
                    [self.navigationController pushViewController:packVC animated:YES];
                }]];
                [alertVC addAction:[UIAlertAction actionWithTitle:@"寄回盒子" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    LHSendBackViewController *sendBack = [[LHSendBackViewController alloc] init];
                    [self.navigationController pushViewController:sendBack animated:YES];
                }]];
                [alertVC addAction:[UIAlertAction actionWithTitle:@"实名认证" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    LHCertificationViewController *cerVC = [[LHCertificationViewController alloc] init];
                    [self.navigationController pushViewController:cerVC animated:YES];
                }]];
                [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
                [self presentViewController:alertVC animated:YES completion:nil];
    }];
}


/**
 去结算

 @param accView 结算的View
 */
- (void)goAccrountGoods:(LHPackingBoxView *)accView {
    [accView goAccrountGoodsBlock:^{
        NSLog(@"去结算");
        if (self.selectArray.count == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"您还没有选中商品哦!"];
            });
        } else {
            LHAccountCenterViewController *accountVC = [[LHAccountCenterViewController alloc] init];
            accountVC.goodsModelArray = self.selectArray;
            
            [self.navigationController pushViewController:accountVC animated:YES];
        }
    }];
}

/**
 购物车cell的点击事件, 加商品, 减商品, 选中商品
 
 @param cell 购物车cell
 @param storeModel 店铺model
 @param goodsModel 商品model
 @param indexPath  cell坐标
 */
- (void)shoppingCartCellClickAction:(LHShoppingCartCell *)cell
                         storeModel:(LHCartStoreModel *)storeModel
                         goodsModel:(LHCartGoodsModel *)goodsModel
                          indexPath:(NSIndexPath *)indexPath {
    __block typeof(cell) wsCell = cell;
    //数量加
    [wsCell numberOfAddBlock:^(NSInteger number) {
        wsCell.number = number;
        goodsModel.count = number;
        
        [storeModel.products replaceObjectAtIndex:indexPath.row withObject:goodsModel];
        if ([self.selectArray containsObject:goodsModel]) {
            [self.selectArray removeObject:goodsModel];
            [self.selectArray addObject:goodsModel];
            [self countPrice];
        }
        [self requestUpdateShoppingCart:goodsModel Count:number];
    }];
    //数量减
    [wsCell numberOfSubBlock:^(NSInteger number) {
        wsCell.number = number;
        goodsModel.count = number;
        [storeModel.products replaceObjectAtIndex:indexPath.row withObject:goodsModel];
        if ([self.selectArray containsObject:goodsModel]) {
            [self.selectArray removeObject:goodsModel];
            [self.selectArray addObject:goodsModel];
            [self countPrice];
        }
        [self requestUpdateShoppingCart:goodsModel Count:number];
    }];
    
    //选中按钮
    [wsCell clickWithCellBlock:^(BOOL isClick) {
        goodsModel.isSelect = isClick;
        if (isClick) {
            //                NSLog(@"选了第%ld分区 第%ld行", indexPath.section,indexPath.row);
            [self.selectArray addObject:goodsModel];
            //                NSLog(@"%@", storeModel);
        } else {
            //                NSLog(@"取消了第%ld分区 第%ld行", indexPath.section,indexPath.row);
            [self.selectArray removeObject:goodsModel];
            
        }
        [self verityAllSelectState];
        [self verityGroupSelectState:indexPath.section];
        [self countPrice];
    }];
}

/**
 选中某个分区

 @param headerView 区头View
 @param storeModel 店铺model
 */
- (void)shoppingCartSectionHeaderAction:(LHCartHeaderView *)headerView
                             storeModel:(LHCartStoreModel *)storeModel {
    [headerView clickWithHeaderViewBlock:^(BOOL isClick) {
        //            NSLog(@"------------------------->>> %d", isClick);
        storeModel.isSelect = isClick;
        if (isClick) {
            //                NSLog(@"选了%ld分区", section);
            for (LHCartGoodsModel *goodsModel in storeModel.products) {
                goodsModel.isSelect = YES;
                if (![self.selectArray containsObject:goodsModel]) {
                    [self.selectArray addObject:goodsModel];
                }
            }
        } else {
            //                NSLog(@"取消了%ld分区", section);
            for (LHCartGoodsModel *goodsModel in storeModel.products) {
                goodsModel.isSelect = NO;
                if ([self.selectArray containsObject:goodsModel]) {
                    [self.selectArray removeObject:goodsModel];
                }
            }
        }
        //            NSLog(@"******%@", self.selectArray);
        [self verityAllSelectState];
        [self.shoppingCartTableView reloadData];
        [self countPrice];
    }];
}
//监测到有收藏, 就把收藏状态改为YES
- (void)CollectionSuccessNotification {
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~右滑收藏了~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    self.CollectionSuccess = YES;
    
}

/**
 添加购物车 或 下订单了, 就改变状态
 */
- (void)AddShoppingCartSuccessNotification {
    NSLog(@"-----------------添加购物车 或 下订单了了------------------");
    self.AddShoppingSuccess = YES;
}
#pragma mark  --------------  判断是否全选等    价格的计算  ----------------------
//某个分区是否全选
- (void)verityGroupSelectState:(NSInteger)section {
    // 判断某个区的商品是否全选
    LHCartStoreModel *tempShop = self.storeArray[section];
    // 是否全选标示符
    BOOL isShopAllSelect = YES;
    for (LHCartGoodsModel *model in tempShop.products) {
        // 当有一个为NO的是时候,将标示符置为NO,并跳出循环
        if (model.isSelect == NO) {
            isShopAllSelect = NO;
            break;
        }
    }
    LHCartHeaderView *header = (LHCartHeaderView *)[self.shoppingCartTableView headerViewForSection:section];
    header.isSelect = isShopAllSelect;
    tempShop.isSelect = isShopAllSelect;
}
/**
  *  计算已选中商品金额
 */
-(void)countPrice {
    double totlePrice = 0.0;
    for (LHCartGoodsModel *model in self.selectArray) {
        double price = [model.price_lfeel doubleValue];
        totlePrice += price*model.count;
    }
    NSString *string = [NSString stringWithFormat:@"￥%.2f",totlePrice];
    self.accrountView.priceLabel.attributedText = [self LHSetString:string];
}
//是否全选
- (void)verityAllSelectState {
    NSInteger count = 0;
    for (LHCartStoreModel *shop in self.storeArray) {
        count += shop.products.count;
    }
    if (self.selectArray.count == count) {
        _allSelectBtn.selected = YES;
        
        self.accrountView.allSelectBtn.selected = YES;
        self.accrountView.allSelectBtn.titleImageView.image = [UIImage imageNamed:@"MyBox_clicked"];
    } else {
        _allSelectBtn.selected = NO;
        self.accrountView.allSelectBtn.selected = NO;
        self.accrountView.allSelectBtn.titleImageView.image = [UIImage imageNamed:@"MyBox_click_default"];
    }
}




#pragma mark ---------------------- 请求数据  ----------------------------
//请求购物车数据
- (void)requestShoppingCartData {
    [LHNetworkManager requestForGetWithUrl:kShopppingCartList parameter:@{@"user_id": kUser_id} success:^(id reponseObject) {
        NSLog(@"购物车----> %@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            for (NSDictionary *dic in reponseObject[@"data"]) {
                LHCartStoreModel *model = [[LHCartStoreModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [model configerGoodsArrayWithArray:dic[@"products"]];
                [self.storeArray addObject:model];
            }
        }
        if (self.storeArray.count == 0) {
            [self emptyShoppingCartView];
        } else {
            if ([self.view viewWithTag:kTag_CartEmptyView+10]) {
                
                [[self.view viewWithTag:kTag_CartEmptyView+10] removeFromSuperview];
            }
        }
        NSLog(@"购物车里商品数量%lu", (unsigned long)self.storeArray.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.shoppingCartTableView.mj_header endRefreshing];
            [self.shoppingCartTableView reloadData];
            
        });
    } failure:^(NSError *error) {
        
    }];
}


//删除购物车
- (void)requestDeleteShoppingCartData:(LHCartGoodsModel *)model {
    [LHNetworkManager PostWithUrl:kDeleteShoppingCart parameter:@{@"spec_id": model.spec_id} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:@"删除成功"];
                [self.shoppingCartTableView reloadData];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"删除失败"];
            });
        }
    } failure:^(NSError *error) {
        
    }];
}

//更新购物车
- (void)requestUpdateShoppingCart:(LHCartGoodsModel *)model Count:(NSInteger)count{
    [LHNetworkManager PostWithUrl:kUpdateShoppingCart parameter:@{@"id": model.spec_id, @"count": @(count)} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"网络不好,请稍候再试!"];
            });
        }
    } failure:^(NSError *error) {
        
    }];
}


/*请求换衣盒数据
 *收藏列表
 *type 0 --> 购买的商品; 1 --> 租赁的商品
 */
- (void)requstMyBoxCartData {
    [self showProgressHUD];
    [LHNetworkManager requestForGetWithUrl:kCollectionListUrl parameter:@{@"user_id":kUser_id, @"type": @1} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            for (NSDictionary *dic in reponseObject[@"data"]) {
                LHCollectModel *model = [[LHCollectModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.myBoxArray addObject:model];
            }
        }
        if (self.myBoxArray.count == 0) {
            [self emptyLfeelBoxView];
        } else {
            if ([self.view viewWithTag:kTag_BoxEmptyView+20]) {
                [[self.view viewWithTag:kTag_BoxEmptyView+20] removeFromSuperview];
            }
        
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideProgressHUD];
            [self.myBoxTableView.mj_header endRefreshing];
            [self.myBoxTableView reloadData];
        });
    } failure:^(NSError *error) {
        
    }];
}
//删除收藏
- (void)requestDeleteBoxGoods:(LHCollectModel *)model {
    [LHNetworkManager PostWithUrl:kUncollectionGoodsUrl parameter:@{@"product_id": model.product_id, @"user_id": kUser_id, @"type": @1} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:@"删除成功"];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"删除失败"];
            });
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}






#pragma  mark ----------- >>>  富文本  <<< -------------------
- (NSMutableAttributedString*)LHSetString:(NSString*)string {
    NSString *text = [NSString stringWithFormat:@"总价:%@",string];
    NSMutableAttributedString *LHString = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange rang = [text rangeOfString:@"总价:"];
    [LHString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rang];
    [LHString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*kRatio] range:rang];
    return LHString;
}


#pragma mark ---------------  换衣盒 和 购物车为空的时候的展示  ------------------------

- (void)emptyShoppingCartView {
//    UIView *bottomView = [self.view viewWithTag:kTag_CartEmptyView];
//    [bottomView removeFromSuperview];
//    [self.shoppingCartTableView removeFromSuperview];
//    self.shoppingCartTableView = nil;
//    self.accrountView.hidden = YES;
    CGFloat tabBarHeight = 49;
    if ([self.subPage isEqualToString:@"Rent"] || [self.subPage isEqualToString:@"New"]) {
        tabBarHeight = 0;
    } else {
        tabBarHeight = 49;
    }
    UIView *bgView = [[UIView alloc] init];
    bgView.tag = kTag_CartEmptyView+10;
    bgView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-kNavBarHeight-tabBarHeight);
    bgView.backgroundColor = kColor(245, 245, 245);
    [self.boxScrollView addSubview:bgView];
    
    UIImageView *emptyImageView = [[UIImageView alloc] initWithImage:kImage(@"MyBox_Empty_ShoppintCart")];
    emptyImageView.frame = CGRectMake(100*kRatio, 40*kRatio, kScreenWidth-200*kRatio, kScreenWidth-200*kRatio);
    [bgView addSubview:emptyImageView];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenWidth-140*kRatio, kScreenWidth, 25)];
    textLabel.text = @"购物车还是空的哟~";
    textLabel.font = kFont(15*kRatio);
    textLabel.textColor = [UIColor lightGrayColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:textLabel];
    
    UIButton *goBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    goBtn.frame = CGRectMake(40*kRatio, kScreenHeight-kNavBarHeight-tabBarHeight - 100*kRatio, kScreenWidth-80*kRatio, 40*kRatio);
    [goBtn setTitle:@"去逛逛~" forState:(UIControlStateNormal)];
    [goBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    goBtn.layer.masksToBounds = YES;
    goBtn.layer.borderColor = [UIColor redColor].CGColor;
    goBtn.layer.borderWidth = 1;
    goBtn.layer.cornerRadius = 2;
    [goBtn addTarget:self action:@selector(handleGoBtnNewGoodsAction) forControlEvents:(UIControlEventTouchUpInside)];
    [bgView addSubview:goBtn];
}



- (void)emptyLfeelBoxView {
//    UIView *bottomView = [self.view viewWithTag:kTag_BoxEmptyView];
//    [bottomView removeFromSuperview];
//    [self.myBoxTableView removeFromSuperview];
//    self.myBoxTableView = nil;
    
    CGFloat tabBarHeight = 49;
    if ([self.subPage isEqualToString:@"Rent"] || [self.subPage isEqualToString:@"New"]) {
        tabBarHeight = 0;
    } else {
        tabBarHeight = 49;
    }
    UIView *bgView = [[UIView alloc] init];
    bgView.tag = kTag_BoxEmptyView+20;
    bgView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight-tabBarHeight);
    [self.boxScrollView addSubview:bgView];
    
    UIImageView *emptyImageView = [[UIImageView alloc] initWithImage:kImage(@"MyBox_Empty_MyBox")];
    emptyImageView.frame = CGRectMake(100*kRatio, 40*kRatio, kScreenWidth-200*kRatio, kScreenWidth-200*kRatio);
    [bgView addSubview:emptyImageView];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenWidth-140*kRatio, kScreenWidth, 25)];
    textLabel.text = @"换衣盒还是空的哟~";
    textLabel.font = kFont(15*kRatio);
    textLabel.textColor = [UIColor lightGrayColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:textLabel];
    
    UIButton *goBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    goBtn.frame = CGRectMake(40*kRatio, kScreenHeight-kNavBarHeight-tabBarHeight - 100*kRatio, kScreenWidth-80*kRatio, 40*kRatio);
    [goBtn setTitle:@"去逛逛~" forState:(UIControlStateNormal)];
    [goBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    goBtn.layer.masksToBounds = YES;
    goBtn.layer.borderColor = [UIColor redColor].CGColor;
    goBtn.layer.borderWidth = 1;
    goBtn.layer.cornerRadius = 2;
    [goBtn addTarget:self action:@selector(handleGoHomeAction) forControlEvents:(UIControlEventTouchUpInside)];
    [bgView addSubview:goBtn];
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
