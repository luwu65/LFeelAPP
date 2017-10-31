//
//  LHNewGoodsDetailViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/19.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHNewGoodsDetailViewController.h"
#import "LHCycleScrollView.h"
#import "LHGoodsCommentCell.h"
#import "LHGoodsCommentHeaderFooterView.h"
#import "LHAllCommentViewController.h"
#import "LHGoodsDetailModel.h"
#import "LHMyBoxViewController.h"
#import "LHAccountCenterViewController.h"
@interface LHNewGoodsDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *detailTableView;

//评论
@property (nonatomic, strong) NSMutableArray *commentArray;
//轮播图图片
@property (nonatomic, strong) NSMutableArray *cycleArray;

@property (nonatomic, strong) LHNewGoodsDetailCycleView *cycleView;

//产品参数
@property (nonatomic, strong) NSMutableArray *propertyArray;
//颜色
@property (nonatomic, strong) NSMutableArray *colorArray;
//尺码
@property (nonatomic, strong) NSMutableArray *sizeArray;
/**
 存储颜色和尺码的所有情况
 */
@property (nonatomic, strong) NSMutableArray *colorSizeArray;
/**
 存储选择的尺码和颜色
 */
@property (nonatomic, strong) NSMutableArray *chooseSizeArray;
@property (nonatomic, strong) NSMutableArray *chooseColorArray;
@property (nonatomic, copy) NSString *spec_id;

@property (nonatomic, strong) NSMutableDictionary *goodsInfoDic;


@end

@implementation LHNewGoodsDetailViewController

- (NSMutableDictionary *)goodsInfoDic {
    if (!_goodsInfoDic) {
        self.goodsInfoDic = [NSMutableDictionary new];
    }
    return _goodsInfoDic;
}

- (NSMutableArray *)chooseSizeArray {
    if (!_chooseSizeArray) {
        self.chooseSizeArray = [NSMutableArray new];
    }
    return _chooseSizeArray;
}

- (NSMutableArray *)chooseColorArray {
    if (!_chooseColorArray) {
        self.chooseColorArray = [NSMutableArray new];
    }
    return _chooseColorArray;
}

- (NSMutableArray *)colorSizeArray {
    if (!_colorSizeArray) {
        self.colorSizeArray = [NSMutableArray new];
    }
    return _colorSizeArray;
}

- (NSMutableArray *)cycleArray {
    if (!_cycleArray) {
        self.cycleArray = [NSMutableArray new];
    }
    return _cycleArray;
}

- (NSMutableArray *)commentArray {
    if (!_commentArray) {
        self.commentArray = [NSMutableArray new];
    }
    return _commentArray;
}

- (NSMutableArray *)propertyArray {
    if (!_propertyArray) {
        self.propertyArray = [NSMutableArray new];
    }
    return _propertyArray;
}

- (NSMutableArray *)colorArray {
    if (!_colorArray) {
        self.colorArray = [NSMutableArray new];
    }
    return _colorArray;
}

- (NSMutableArray *)sizeArray {
    if (!_sizeArray) {
        self.sizeArray = [NSMutableArray new];
    }
    return _sizeArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //从客服页面返回过来, 要隐藏掉navigationBar, 避免系统的navigationBar覆盖掉自定义的navigationBar
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self setHBK_NavigationBar];
    
    [self requestGoodsDetailData];
}

#pragma mark -------------------------  UI -------------------------
- (void)setUI {
    self.detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kIPhoneXBottomHeight) style:(UITableViewStyleGrouped)];
    self.detailTableView.dataSource = self;
    self.detailTableView.delegate = self;
    [self.view addSubview:self.detailTableView];
    
    self.cycleView = [[LHNewGoodsDetailCycleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*1.8) imageFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*1.2) placeHolderImage:kImage(@"")];
    
    self.cycleView.backgroundColor = [UIColor whiteColor];
    self.detailTableView.tableHeaderView = self.cycleView;
    [self cycleClickAction];
}

- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    kWeakSelf(self);
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"商品详情" leftFirst:@"Home_GoodsDetail_Back" leftFirstAction:^{
         kStrongSelf(self);
        [self.navigationController popViewControllerAnimated:YES];
    } rightFirst:@"Home_GoodsDetail_Service" rightFirstBtnAction:^{
        kStrongSelf(self);
        NSLog(@"客服");
        ZCProductInfo *productInfo = [ZCProductInfo new];
        //thumbUrl 缩略图地址
        productInfo.thumbUrl = @"";
        //  title 标题 (必填)
        productInfo.title = @"";
        //  desc 摘要
        productInfo.desc = @"";
        //  label 标签
        productInfo.label = @"运动";
        //  页面地址url（必填)
        productInfo.link = @"";
        [self openZCServiceWithProduct:productInfo];
        
    } rightSecond:@"MyBox_Detail_ShoppingCart" rightSecondBtnAction:^{
        LHMyBoxViewController *boxVC = [[LHMyBoxViewController alloc] init];
        boxVC.subPage = @"New";
        [self.navigationController pushViewController:boxVC animated:YES];
    } rightThird:@"Home_GoodsDetail_Share" rightThirdBtnAction:^{
        NSLog(@"分享");
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            NSLog(@"%ld-----------%@", (long)platformType, userInfo);
            [LHShareManager shareTitle:@"111" desc:@"222" url:@"https://www.baidu.com" image:nil Plantform:platformType completion:^(id result, NSError *error) {
                
            }];
        }];
       
    }];
    self.hbk_navgationBar.bgColor = [UIColor clearColor];
    self.hbk_navgationBar.deviderLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.hbk_navgationBar.titleLabel.textColor = [UIColor clearColor];
}


#pragma mark  -----------  <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.propertyArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LHGoodsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHGoodsCommentCell"];
        if (cell == nil) {
            cell = [[LHGoodsCommentCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LHGoodsCommentCell"];
            [cell setUIWithComment];
            cell.userNameLabel.text = @"139****4444";
            cell.heightLabel.text = @"身高172cm";
            cell.sizeLabel.text = @"常穿M";
            cell.buySizeLabel.text = @"这件S";
            cell.commentLabel.text = @"哈根哈萨克干哈开始哈噶关";
        }
        //    [cell setUINoComent];
        [cell adjustCellWithString:@"哈根哈萨克干哈开始哈噶关"];
        cell.photoGroupView.picUrlArray = @[@"http://testapp.gtax.cn/images/2016/11/05/812eb442b6a645a99be476d139174d3c.png!m90x90.png",@"http://testapp.gtax.cn/images/2016/11/09/64a62eaaff7b466bb8fab12a89fe5f2f.png!m90x90.png", @"https://testapp.gtax.cn/images/2016/09/30/ad0d18a937b248f88d29c2f259c14b5e.jpg!m90x90.jpg"];
        return cell;
    } else {
        static NSString *cellID = @"GoodsProperty";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        LHGoodsPropertyModel *model = self.propertyArray[indexPath.row];
        cell.textLabel.text = model.property_key;
        cell.detailTextLabel.text = model.property_value;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        if (indexPath.section == 0) {
            return [LHGoodsCommentCell cellHeightWithString:@"哈根哈萨克干哈开始哈噶关卡关"];
        } else {
            return 40;
        }
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 60;
    } else {
        return 60;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 80;
    } else {
        return CGFLOAT_MIN;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
        LHGoodsCommentHeaderView *headerView = [[LHGoodsCommentHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        headerView.titleLabel.text = @[@"精品评论", @"产品参数"][section];
        return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        kWeakSelf(self);
        LHGoodsCommentFooterView *footerView = [[LHGoodsCommentFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 95)];
        footerView.clickAllBtn = ^{
            kStrongSelf(self);
            LHAllCommentViewController *commentVC = [[LHAllCommentViewController alloc] init];
            commentVC.product_id = self.goodsInfoDic[@"id"];
            [self.navigationController pushViewController:commentVC animated:YES];
            NSLog(@"全部评论");
        };
        return footerView;
    } else {
        return nil;
    }
}

#pragma mark ------------ 网络请求  ---------------
//商品详情
- (void)requestGoodsDetailData {
    [self showProgressHUD];
    [LHNetworkManager requestForGetWithUrl:kGoodsDetailUrl parameter:@{@"id": self.listModel.product_id, @"user_id": kUser_id} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            for (NSDictionary *picdic in reponseObject[@"data"][@"product_pritures"]) {
                [self.cycleArray addObject:picdic[@"url"]];
            }
            LHGoodsInfoModel *model = [[LHGoodsInfoModel alloc] init];
            [model setValuesForKeysWithDictionary:(NSDictionary *)reponseObject[@"data"][@"productInfo"]];
            self.cycleView.repertoryLabel.text = [NSString stringWithFormat:@"库存%@件", model.remain];
            for (NSDictionary *dic in reponseObject[@"data"][@"property_value"]) {
                LHGoodsSizeColorModel *model = [[LHGoodsSizeColorModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.colorSizeArray addObject:model];
            }
            
            for (NSDictionary *dic in reponseObject[@"data"][@"properties"]) {
                if (!self.cycleView.colorTagView.categoryLabel.text) {
                    self.cycleView.colorTagView.categoryLabel.text = [NSString stringWithFormat:@"%@: ", dic[@"property_key"]];
                    for (NSString *str in dic[@"property_value"]) {
                        [self.colorArray addObject: str];
                    }
                    self.cycleView.colorArray = self.colorArray;
                } else {
                    self.cycleView.sizeTagView.categoryLabel.text = [NSString stringWithFormat:@"%@: ", dic[@"property_key"]];
                    for (NSString *str in dic[@"property_value"]) {
                        [self.sizeArray addObject: str];
                    }
                    self.cycleView.sizeArray = self.sizeArray;
                }
            }
            
           
            self.goodsInfoDic = reponseObject[@"data"][@"productInfo"];
            
            for (NSDictionary *dic in reponseObject[@"data"][@"product_property"]) {
                LHGoodsPropertyModel *model = [[LHGoodsPropertyModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.propertyArray addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cycleView.titleLabel.text = model.product_name;
                self.cycleView.rentCycleView.imageURLStringsGroup = self.cycleArray;
                self.cycleView.priceLabel.text = [NSString stringWithFormat:@"¥%@", model.price_lfeel];
                [self.detailTableView reloadData];
                [self hideProgressHUD];
            });
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}


/**
 加入购物车
 */
- (void)requestAddShoppingCartData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showProgressHUD];
    });
    [LHNetworkManager PostWithUrl:kAddshoppingCartUrl parameter:@{@"user_id": kUser_id, @"product_id": self.listModel.product_id, @"count": @1, @"spec_id": self.spec_id} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideProgressHUD];
        });
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:@"在购物车等着亲哦~"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AddShoppingCartSuccess" object:nil];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"加入购物车失败!"];
            });
        }
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
            if ([reponseObject[@"errorCode"] integerValue] == 200) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showSuccess:@"收藏成功"];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:@"收藏失败"];
                });
            }
        } else {
            if ([reponseObject[@"errorCode"] integerValue] == 200) {
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


#pragma mark ---------------- Action --------------------

/**
 对比选择的两个数组总的数据, 如果一样, 就确定了是哪一件商品
 */
- (void)compareColorSize {
    for (int i = 0; i < self.chooseSizeArray.count; i++) {
        for (int j = 0; j < self.chooseColorArray.count; j++) {
            if (self.chooseColorArray[j] == self.chooseSizeArray[i]) {
                self.spec_id = self.chooseSizeArray[i];
            }
        }
    }
}


- (void)cycleClickAction {
    kWeakSelf(self);
    //立即购买
    self.cycleView.ClickBuyNowBlock = ^{
        kStrongSelf(self);
        [self compareColorSize];
        if (self.spec_id) {
            NSLog(@"-------------------  %@  ------------%@------", self.spec_id, self.goodsInfoDic);
            LHAccountCenterViewController *accCenterVC = [[LHAccountCenterViewController alloc] init];
            accCenterVC.productInfoDic = self.goodsInfoDic;
            accCenterVC.spec_id = [NSString stringWithFormat:@"%@", self.spec_id];
            [self.navigationController pushViewController:accCenterVC animated:YES];
        } else {
            [MBProgressHUD showError:@"请选择尺码或颜色"];
        }
    };
    //加入购物车
    self.cycleView.AddShoppingCartBlock = ^{
        NSLog(@"加入购物车");
        kStrongSelf(self);
        [self compareColorSize];
        
        if (self.spec_id) {
            NSLog(@"-------------------  %@  ------------------", self.spec_id);
            [self requestAddShoppingCartData];
        } else {
            [MBProgressHUD showError:@"请选择尺码或颜色"];
        }
    };
    //选择颜色
    self.cycleView.colorTagView.ClickTagBlock = ^(NSInteger index) {
        kStrongSelf(self);
        [self.chooseColorArray removeAllObjects];
        for (LHGoodsSizeColorModel *model in self.colorSizeArray) {
            if ([model.property_value isEqualToString:self.colorArray[index]]) {
                NSLog(@"--------%ld", (long)model.spec_id);
                [self.chooseColorArray addObject:@(model.spec_id)];
            }
        }
    };
    //选择尺码
    self.cycleView.sizeTagView.ClickTagBlock = ^(NSInteger index) {
        kStrongSelf(self);
        [self.chooseSizeArray removeAllObjects];
        //遍历所有的颜色尺码的组合
        for (LHGoodsSizeColorModel *model in self.colorSizeArray) {
            //找到选择的尺码
            if ([model.property_value isEqualToString:self.sizeArray[index]]) {
                NSLog(@"========%ld", (long)model.spec_id);
                [self.chooseSizeArray addObject:@(model.spec_id)];
                
            }
        }
    };
    //收藏
    self.cycleView.ClickCollectBlock = ^{
       kStrongSelf(self);
        NSLog(@"收藏");
        
        
    };
}












#pragma mark ----- 滑动的时候改变导航栏的透明度
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.detailTableView) {
        CGFloat y = scrollView.contentOffset.y;
        if (y > 100) {
            self.hbk_navgationBar.deviderLayer.backgroundColor = HexColorInt32_t(DDDDDD).CGColor;
            [self.hbk_navgationBar.leftFirstBtn setImage:kImage(@"Back_Button") forState:(UIControlStateNormal)];
            [self.hbk_navgationBar.rightFirstBtn setImage:kImage(@"Home_service") forState:(UIControlStateNormal)];
            [self.hbk_navgationBar.rightSecondBtn setImage:kImage(@"MyBox_Detail_ShoppingCart_Scroll") forState:(UIControlStateNormal)];
            [self.hbk_navgationBar.rightThirdBtn setImage:kImage(@"Home_GoodsDetail_Share_scroll") forState:(UIControlStateNormal)];

        } else {
            [self.hbk_navgationBar.leftFirstBtn setImage:kImage(@"Home_GoodsDetail_Back") forState:(UIControlStateNormal)];
            [self.hbk_navgationBar.rightFirstBtn setImage:kImage(@"Home_GoodsDetail_Service") forState:(UIControlStateNormal)];
            [self.hbk_navgationBar.rightSecondBtn setImage:kImage(@"MyBox_Detail_ShoppingCart") forState:(UIControlStateNormal)];
            [self.hbk_navgationBar.rightThirdBtn setImage:kImage(@"Home_GoodsDetail_Share") forState:(UIControlStateNormal)];

            self.hbk_navgationBar.deviderLayer.backgroundColor = [UIColor clearColor].CGColor;
        }
        CGFloat alphy = y / 150.0 > 1.0 ? 1.0 : y / 150.0;
        self.hbk_navgationBar.bgColor = [UIColor colorWithWhite:1 alpha:alphy];
        self.hbk_navgationBar.titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alphy];
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
