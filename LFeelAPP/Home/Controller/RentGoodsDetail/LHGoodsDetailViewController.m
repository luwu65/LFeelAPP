//
//  LHGoodsDetailViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/26.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHGoodsDetailViewController.h"
#import "LHCycleScrollView.h"
#import "LHGoodsCommentCell.h"
#import "LHGoodsCommentHeaderFooterView.h"
#import "LHAllCommentViewController.h"
#import "LHGoodsDetailModel.h"
#import "LHMyBoxViewController.h"
@interface LHGoodsDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *detailTableView;


@property (nonatomic, strong) NSMutableArray *commentArray;
@property (nonatomic, strong) NSMutableArray *cycleArray;

@property (nonatomic, strong) LHRentGoodsDetailCycleView *cycleView;
@end

@implementation LHGoodsDetailViewController
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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

#pragma mark --------------------- UI -----------------------
- (void)setUI {
    self.detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:(UITableViewStyleGrouped)];
    self.detailTableView.dataSource = self;
    self.detailTableView.delegate = self;
    [self.view addSubview:self.detailTableView];
    
    self.cycleView = [[LHRentGoodsDetailCycleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*1.2 + kFit(125)) imageFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*1.2) placeHolderImage:kImage(@"")];

    [self cycleClickAction:self.cycleView];
    self.cycleView.backgroundColor = [UIColor whiteColor];
    self.detailTableView.tableHeaderView = self.cycleView;
}

- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    @weakify(self);
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"商品详情" leftFirst:@"Home_GoodsDetail_Back" leftFirstAction:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    } rightFirst:@"Home_GoodsDetail_Service" rightFirstBtnAction:^{
        @strongify(self);
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
        
    } rightSecond:@"Home_GoodsDetail_Box" rightSecondBtnAction:^{
        LHMyBoxViewController *myBoxVC = [[LHMyBoxViewController alloc] init];
        myBoxVC.subPage = @"Rent";
        [self.navigationController pushViewController:myBoxVC animated:YES];
        
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
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 0) {
//        return 1;
//    } else {
//        return 5;
//    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
        LHGoodsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHGoodsCommentCell"];
        if (cell == nil) {
            cell = [[LHGoodsCommentCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LHGoodsCommentCell"];
            [cell setUIWithComment];
            cell.userNameLabel.text = @"139****4444";
            cell.heightLabel.text = @"身高172cm";
            cell.sizeLabel.text = @"常穿M";
            cell.buySizeLabel.text = @"这件S";
            cell.commentLabel.text = @"哈根哈萨克干哈开始哈噶关卡关卡关卡噶哈根哈萨克干哈开始哈噶关哈根哈萨哈根哈萨克干哈开始哈噶关卡关卡关卡噶哈根哈萨克干哈开始哈噶关哈根哈萨";
        }
//    [cell setUINoComent];
    [cell adjustCellWithString:@"哈根哈萨克干哈开始哈噶关卡关卡关卡噶哈根哈萨克干哈开始哈噶关哈根哈萨哈根哈萨克干哈开始哈噶关卡关卡关卡噶哈根哈萨克干哈开始哈噶关哈根哈萨"];
    cell.photoGroupView.picUrlArray = @[@"http://testapp.gtax.cn/images/2016/11/05/812eb442b6a645a99be476d139174d3c.png!m90x90.png",
                                        @"http://testapp.gtax.cn/images/2016/11/09/64a62eaaff7b466bb8fab12a89fe5f2f.png!m90x90.png",
                                        @"https://testapp.gtax.cn/images/2016/09/30/ad0d18a937b248f88d29c2f259c14b5e.jpg!m90x90.jpg"];
    cell.photoGroupView.picUrlArray = [NSMutableArray new];
        return cell;
//     }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        return 300;
//    } else {
//        return 40;
//    }
    return [LHGoodsCommentCell cellHeightWithString:@"哈根哈萨克干哈开始哈噶关卡关卡关卡噶哈根哈萨克干哈开始哈噶关哈根哈萨哈根哈萨克干哈开始哈噶关卡关卡关卡噶哈根哈萨克干哈开始哈噶关哈根哈萨"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section == 1) {
//        return 60;
//    } else {
//        return 0;
//    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 95;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LHGoodsCommentHeaderView *headerView = [[LHGoodsCommentHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    headerView.titleLabel.text = @"精品评论";
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    @weakify(self);
    LHGoodsCommentFooterView *footerView = [[LHGoodsCommentFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 95)];
    footerView.clickAllBtn = ^{
        @strongify(self);
        LHAllCommentViewController *commentVC = [[LHAllCommentViewController alloc] init];
        [self.navigationController pushViewController:commentVC animated:YES];
        NSLog(@"全部评论");
    };
    return footerView;
}

#pragma mark ------------ 网络请求  ---------------
- (void)requestGoodsDetailData {
    [self showProgressHUD];
    [LHNetworkManager requestForGetWithUrl:@"product/findproduct?" parameter:@{@"id": self.goodsModel.product_id} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            for (NSDictionary *picdic in reponseObject[@"data"][@"product_pritures"]) {
                [self.cycleArray addObject:picdic[@"url"]];
            }
            LHGoodsInfoModel *model = [[LHGoodsInfoModel alloc] init];
            [model setValuesForKeysWithDictionary:(NSDictionary *)reponseObject[@"data"][@"productInfo"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cycleView.titleLabel.text = model.product_name;
                self.cycleView.rentCycleView.imageURLStringsGroup = self.cycleArray;
                self.cycleView.sizeArray = kClothesSize;
                self.cycleView.tagView.categoryLabel.text = @"尺码:";
                self.cycleView.titleLabel.text = @"新款宝宝哈哈哈哈哈哈";
                [self.detailTableView reloadData];
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideProgressHUD];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark  -------------- Action ----------------
//点击事件
- (void)cycleClickAction:(LHRentGoodsDetailCycleView *)cycleView {
    //选择尺码等
    self.cycleView.tagView.ClickTagBlock = ^(NSInteger index) {
        NSLog(@"%ld", (long)index);
    };
    //点击轮播图图片
    [self.cycleView clickCycleBlock:^(NSInteger index) {
        
    }];
    //点击加入我的盒子
    self.cycleView.AddMyBoxBlock = ^(UIButton *sender) {
        NSLog(@"加入我的收藏");
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
            [self.hbk_navgationBar.rightSecondBtn setImage:kImage(@"Home_GoodsDetail_Box_scroll") forState:(UIControlStateNormal)];
            [self.hbk_navgationBar.rightThirdBtn setImage:kImage(@"Home_GoodsDetail_Share_scroll") forState:(UIControlStateNormal)];

        } else {
            [self.hbk_navgationBar.leftFirstBtn setImage:kImage(@"Home_GoodsDetail_Back") forState:(UIControlStateNormal)];
            [self.hbk_navgationBar.rightFirstBtn setImage:kImage(@"Home_GoodsDetail_Service") forState:(UIControlStateNormal)];
            [self.hbk_navgationBar.rightSecondBtn setImage:kImage(@"Home_GoodsDetail_Box") forState:(UIControlStateNormal)];
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
