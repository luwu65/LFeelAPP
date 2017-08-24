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


@end

@implementation LHMyBoxViewController

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
    if (self.selectArray.count > 0) {
        for (LHCartGoodsModel *model in self.selectArray) {
            model.isSelect = NO;
        }
        [self.selectArray removeAllObjects];
    }
    
    //初始化显示状态
    _allSelectBtn.selected = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CollectionSuccess) name:@"CollectionSuccess" object:nil];

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CollectionSuccess" object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    [self customNavBar];
    [self requestShoppingCartData];
    [self requstMyBoxCartData];
    
//    [self requestShoppingCartData1];
    
    
}

- (void)CollectionSuccess {
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");


}
#pragma mark -----------------------  初始化UI控件 --------------------------------
- (void)setUI {
    __weak typeof(self) weakself = self;
    CGFloat tabBarHeight = 49;
    if (self.isSubPage) {
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
    
    
    self.shoppingCartTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight- 64 -tabBarHeight-kAllBarHeight*kRatio) style:(UITableViewStyleGrouped)];
    self.shoppingCartTableView.delegate = self;
    self.shoppingCartTableView.dataSource = self;
    self.shoppingCartTableView.backgroundColor = kColor(246, 246, 246);
    self.shoppingCartTableView.tableFooterView = [[UIView alloc] init];
    [rightBgView addSubview:self.shoppingCartTableView];
    
    [self.shoppingCartTableView registerClass:[LHCartHeaderView class] forHeaderFooterViewReuseIdentifier:@"LHCartHeaderView"];
    
    // ----------------------------------------------  打包 底栏  ----------------------------------
    LHPackingBoxView *packView = [[LHPackingBoxView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kNavBarHeight-tabBarHeight-kAllBarHeight*kRatio, kScreenWidth, kAllBarHeight*kRatio) packingStatusString:@"   随机打包三件给你" packingButtonTitle:@"打包盒子"];
    [packView clickPackingButtonBlock:^(NSString *packBtnTitle) {
//        LHPackInfoViewController *packVC = [[LHPackInfoViewController alloc] init];
//        NSLog(@"打包盒子");
//        [weakself.navigationController pushViewController:packVC animated:YES];
        
        LHSendBackViewController *sendBack = [[LHSendBackViewController alloc] init];
        [weakself.navigationController pushViewController:sendBack animated:YES];
        
    }];
    [leftBgView addSubview:packView];
    
    
    //---------------------------------------------------  结算 底栏  --------------------------------
    self.accrountView = [[LHPackingBoxView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kNavBarHeight-tabBarHeight-kAllBarHeight*kRatio, kScreenWidth, kAllBarHeight*kRatio)];
    self.allSelectBtn = self.accrountView.allSelectBtn;
    [self.allSelectBtn addTarget:self action:@selector(selectAllBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.accrountView.priceLabel.attributedText = [self LHSetString:@"¥0.00"];
    [self.accrountView goAccrountGoodsBlock:^{
        NSLog(@"去结算");
        LHAccountCenterViewController *accountVC = [[LHAccountCenterViewController alloc] init];
        [self.navigationController pushViewController:accountVC animated:YES];
        
    }];
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
    
    __weak typeof(self) weakself = self;
    LHSegmentControlView *segView = [[LHSegmentControlView alloc] initWithFrame:CGRectMake((kScreenWidth-150)/2, 20, 150, 42) titleArray:@[@"换衣盒", @"购物车"] titleFont:kFont(15) titleDefineColor:[UIColor blackColor] titleSelectedColor:[UIColor redColor]];
    [segView clickTitleButtonBlock:^(NSInteger index) {
        if (index == 0) {
            [UIView animateWithDuration:0.3 animations:^{
                weakself.boxScrollView.contentOffset = CGPointMake(0, 0);
            }];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                weakself.boxScrollView.contentOffset = CGPointMake(kScreenWidth, 0);
            }];
        }
    }];
    [bgView addSubview: segView];

    if (self.isSubPage) {
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
    }
}
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
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
        return model.goodsModelArray.count;
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
        LHCartGoodsModel *goodsModel = [storeModel.goodsModelArray objectAtIndex:indexPath.row];
        
        __block typeof(cell) wsCell = cell;
//        wsCell.sizeColorLabel.text = @"XL 红色";
        //数量加
        [wsCell numberOfAddBlock:^(NSInteger number) {
            wsCell.number = number;
            goodsModel.count = number;
            
            [storeModel.goodsModelArray replaceObjectAtIndex:indexPath.row withObject:goodsModel];
            if ([self.selectArray containsObject:goodsModel]) {
                [self.selectArray removeObject:goodsModel];
                [self.selectArray addObject:goodsModel];
                [self countPrice];
            }
        }];
        //数量减
        [wsCell numberOfSubBlock:^(NSInteger number) {
            wsCell.number = number;
            goodsModel.count = number;
            [storeModel.goodsModelArray replaceObjectAtIndex:indexPath.row withObject:goodsModel];
            if ([self.selectArray containsObject:goodsModel]) {
                [self.selectArray removeObject:goodsModel];
                [self.selectArray addObject:goodsModel];
                [self countPrice];
            }
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
            NSLog(@"_____________________________%ld", self.selectArray.count);
        }];
        [cell reloadDataWithModel:goodsModel];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.shoppingCartTableView) {
        LHCartHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LHCartHeaderView"];
        LHCartStoreModel *model = [self.storeArray objectAtIndex:section];
        view.title = model.shopName;
        view.isSelect = model.isSelect;
//        __weak typeof(self) weakSelf = self;
        [view clickWithHeaderViewBlock:^(BOOL isClick) {
            NSLog(@"------------------------->>> %d", isClick);
            model.isSelect = isClick;
            if (isClick) {
                NSLog(@"选了%ld分区", section);
                for (LHCartGoodsModel *goodsModel in model.goodsModelArray) {
                    goodsModel.isSelect = YES;
                    if (![self.selectArray containsObject:goodsModel]) {
                        [self.selectArray addObject:goodsModel];
                    }
                }
            } else {
                NSLog(@"取消了%ld分区", section);
                for (LHCartGoodsModel *goodsModel in model.goodsModelArray) {
                    goodsModel.isSelect = NO;
                    if ([self.selectArray containsObject:goodsModel]) {
                        [self.selectArray removeObject:goodsModel];
                    }
                }
            }
            NSLog(@"******%@", self.selectArray);
            [self verityAllSelectState];
            [tableView reloadData];
            [self countPrice];
        }];
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
        return 35*kRatio;
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
                LHCartGoodsModel *goodsModel = [storeModel.goodsModelArray objectAtIndex:indexPath.row];
                [storeModel.goodsModelArray removeObjectAtIndex:indexPath.row];
                //    删除
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                if (storeModel.goodsModelArray.count == 0) {
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
                    count += storeModel.goodsModelArray.count;
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
//                [self performSelector:@selector(reloadTable) withObject:nil afterDelay:0.5];
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


#pragma mark ---------------  换衣盒 和 购物车为空的时候的展示  ------------------------

- (void)emptyShoppingCartView {
    UIView *bottomView = [self.view viewWithTag:kTag_CartEmptyView];
    [bottomView removeFromSuperview];
    [self.shoppingCartTableView removeFromSuperview];
    self.shoppingCartTableView = nil;
    
    CGFloat tabBarHeight = 49;
    if (self.isSubPage) {
        tabBarHeight = 0;
    } else {
        tabBarHeight = 49;
    }
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-kNavBarHeight-tabBarHeight);
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
    UIView *bottomView = [self.view viewWithTag:kTag_BoxEmptyView];
    [bottomView removeFromSuperview];
    [self.myBoxTableView removeFromSuperview];
    self.myBoxTableView = nil;
    
    CGFloat tabBarHeight = 49;
    if (self.isSubPage) {
        tabBarHeight = 0;
    } else {
        tabBarHeight = 49;
    }
    UIView *bgView = [[UIView alloc] init];
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

#pragma mark  ------------------   Action -------------------

//去逛逛首页
- (void)handleGoHomeAction {
    self.tabBarController.selectedIndex = 0;
}
//去逛逛新品
- (void)handleGoBtnNewGoodsAction {
    self.tabBarController.selectedIndex = 1;
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
            for (LHCartGoodsModel *goodsModel in storeModel.goodsModelArray) {
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



#pragma mark  --------------  判断是否全选等    价格的计算  ----------------------
- (void)verityGroupSelectState:(NSInteger)section {
    // 判断某个区的商品是否全选
    LHCartStoreModel *tempShop = self.storeArray[section];
    // 是否全选标示符
    BOOL isShopAllSelect = YES;
    for (LHCartGoodsModel *model in tempShop.goodsModelArray) {
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
        double price = [model.realPrice doubleValue];
        totlePrice += price*model.count;
    }
    NSString *string = [NSString stringWithFormat:@"￥%.2f",totlePrice];
    self.accrountView.priceLabel.attributedText = [self LHSetString:string];
}

- (void)verityAllSelectState {
    NSInteger count = 0;
    for (LHCartStoreModel *shop in self.storeArray) {
        count += shop.goodsModelArray.count;
    }
    if (self.selectArray.count == count) {
        _allSelectBtn.selected = YES;
    } else {
        _allSelectBtn.selected = NO;
    }
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



#pragma mark ---------------------- 请求数据  ----------------------------
//请求购物车数据
- (void)requestShoppingCartData {
    //先填充假数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ShopCarNew" ofType:@"plist" inDirectory:nil];
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
    for (NSDictionary *aDic in dic[@"data"]) {
        NSLog(@"-----%@", aDic);
        LHCartStoreModel *model = [[LHCartStoreModel alloc] init];
        [model setValuesForKeysWithDictionary:aDic];
        [model configerGoodsArrayWithArray:aDic[@"items"]];
        [self.storeArray addObject:model];
    }
    [self.shoppingCartTableView reloadData];
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
            if (reponseObject[@"data"]) {
                for (NSDictionary *dic in reponseObject[@"data"]) {
                    LHCollectModel *model = [[LHCollectModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.myBoxArray addObject:model];
                }
            } else {
                [self emptyLfeelBoxView];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideProgressHUD];
            [self.myBoxTableView reloadData];
        });
    } failure:^(NSError *error) {
        
    }];
}

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

- (void)requestShoppingCartData1 {
   LHUserInfoModel *model = [LHUserInfoManager getUserInfo];
    [LHNetworkManager requestForGetWithUrl:@"shoppingcar/getcardata?" parameter:@{@"user_id": model.id_} success:^(id reponseObject) {
        NSLog(@"购物车----> %@", reponseObject);
        
        
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
