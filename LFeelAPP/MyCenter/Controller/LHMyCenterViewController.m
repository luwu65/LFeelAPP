//
//  LHMyCenterViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHMyCenterViewController.h"
#import "LHOrderFormView.h"
#import "LHMyCenterCell.h"
#import "LHMyCenterHeaderView.h"
#import "LHMyOrderViewController.h"
#import "LHAddVipViewController.h"
#import "LHSettingViewController.h"
#import "LHReceiveAddressViewController.h"
#import "LHUserInfoViewController.h"
#import "LHCollectViewController.h"
#import "LHWebViewController.h"
#import "LHCardBagViewController.h"
#import "LHBoxHistoryViewController.h"
#import "LHDistributionViewController.h"

#import <Accelerate/Accelerate.h>
#import <UIImage+MultiFormat.h>

static NSString *myCenterCell = @"myCenterCell";
@interface LHMyCenterViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myCenterTableView;
@property (nonatomic, strong) LHMyCenterHeaderView *headerView;

@property (nonatomic, strong) NSMutableArray *cellTitleArray;
@property (nonatomic, strong) NSMutableArray *cellImageViewArray;
@property (nonatomic, strong) LHOrderFormView *orderAbooutView;
@end

@implementation LHMyCenterViewController

- (NSMutableArray *)cellImageViewArray {
    if (!_cellImageViewArray) {
        self.cellImageViewArray = [NSMutableArray arrayWithObjects:@"MyCenter_Bill", @"MyCenter_Card", @"MyCenter_Collect", @"MyCenter_History", @"MyCenter_Address", @"MyCenter_Setting", nil];
    }
    return _cellImageViewArray;
}
- (NSMutableArray *)cellTitleArray {
    if (!_cellTitleArray) {
        self.cellTitleArray = [NSMutableArray arrayWithObjects:@"我的订单", @"我的分销", @"我的卡包", @"我的收藏", @"我的盒子历史", @"收货地址", @"设置",nil];
    }
    return _cellTitleArray;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    //设置导航栏为透明的
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:kColor(255, 255, 255)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColor(245, 245, 245);

    
    [self setUI];
    
    
    [self setHBK_NavigationBar];
    
    [self configureDataForUser];
}

#pragma mark ---------------  UI ------------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"个人中心" rightFirst:@"加入会员" rightFirstBtnAction:^{
        NSLog(@"加入会员");
        LHAddVipViewController *addVip = [[LHAddVipViewController alloc] init];
        [self.navigationController pushViewController:addVip animated:YES];
    }];
    self.hbk_navgationBar.rightFirstBtn.frame = CGRectMake(kScreenWidth-70, 31, 60, 25);
    self.hbk_navgationBar.bgColor = [UIColor clearColor];
    self.hbk_navgationBar.deviderLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.hbk_navgationBar.titleLabel.textColor = [UIColor clearColor];
    self.hbk_navgationBar.rightFirstBtn.layer.cornerRadius = 2;
    self.hbk_navgationBar.rightFirstBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.hbk_navgationBar.rightFirstBtn.layer.borderWidth = 1;
    self.hbk_navgationBar.rightFirstBtn.layer.masksToBounds = YES;
    self.hbk_navgationBar.rightFirstBtn.titleLabel.font = kFont(13);
    [self.hbk_navgationBar.rightFirstBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
}

- (void)setUI {
    self.myCenterTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49) style:(UITableViewStylePlain)];
    self.myCenterTableView.backgroundColor = [UIColor clearColor];
    self.myCenterTableView.dataSource = self;
    self.myCenterTableView.delegate = self;
    self.myCenterTableView.showsVerticalScrollIndicator = NO;
    self.myCenterTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.myCenterTableView];
    
     self.headerView = [[LHMyCenterHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200*kRatio)];
    self.headerView.bgImageView.backgroundColor = [UIColor whiteColor];
    [self.headerView clickIconBlock:^{
        LHUserInfoViewController *userInfoVC = [[LHUserInfoViewController alloc] init];
        [self.navigationController pushViewController:userInfoVC animated:YES];
    }];
    self.myCenterTableView.tableHeaderView = _headerView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    footerView.backgroundColor = kColor(245, 245, 245);
    UIButton *callBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [callBtn setTitle:@"客服热线: 020-37889773" forState:(UIControlStateNormal)];
    callBtn.frame = CGRectMake(80, 20, kScreenWidth-160, 40);
    [callBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    callBtn.titleLabel.font = kFont(14);
    [callBtn addTarget:self action:@selector(callBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [footerView addSubview:callBtn];
    self.myCenterTableView.tableFooterView = footerView;
    
    [self.myCenterTableView registerNib:[UINib nibWithNibName:@"LHMyCenterCell" bundle:nil] forCellReuseIdentifier:@"LHMyCenterCell"];
}

//创建 --待付款, 待发货, 待收货, 待评论视图
- (LHOrderFormView *)createOrderAbooutView {
    self.orderAbooutView = [[LHOrderFormView alloc] initWithFrame:CGRectMake(1, 1, kScreenWidth-2, 68) imageNameArray:@[@"MyCenter_waitPay", @"MyCenter_waitSend", @"MyCenter_waitReceive", @"MyCenter_waitComment"] titleArray:@[@"待付款", @"待发货", @"待收货", @"待评论"]];
    CustomButton *btn = (CustomButton *)[self.orderAbooutView viewWithTag:5002];
    btn.badgeValue = @"1";
    [self clickOrderBtnAction];
    
    return _orderAbooutView;
}


#pragma mark -------------  UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 1;
    } else if (section == 2) {
        return 3;
    } else {
        return 2;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"MyLehuiOrderAboutCell"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = self.cellTitleArray[indexPath.row];
                cell.detailTextLabel.text = @"查看更多订单";
                cell.detailTextLabel.font = kFont(14*kRatio);
                cell.textLabel.font = kFont(14*kRatio);
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        } else {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"MyLehuiOrderAboutCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell addSubview:[self createOrderAbooutView]];
            }
            return cell;
        }
        
    } else {
        LHMyCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHMyCenterCell" forIndexPath:indexPath];
        cell.titleLabel.font = kFont(14*kRatio);
        if (1 == indexPath.section) {
            cell.titleLabel.text = self.cellTitleArray[indexPath.row+1];
            cell.picImageView.image = [UIImage imageNamed:self.cellImageViewArray[indexPath.row]];
            
        } else if(2 == indexPath.section){
            cell.titleLabel.text = self.cellTitleArray[indexPath.row+2];
            cell.picImageView.image = [UIImage imageNamed:self.cellImageViewArray[indexPath.row+1]];
            
        } else if (3 == indexPath.section) {
            cell.titleLabel.text = self.cellTitleArray[indexPath.row+5];
            cell.picImageView.image = [UIImage imageNamed:self.cellImageViewArray[indexPath.row+4]];
            
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        return kFit(65);
    } else {
        return kFit(50);
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return kFit(15);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        LHMyOrderViewController *orderVC = [[LHMyOrderViewController alloc] init];
        orderVC.index = 0;
        [self.navigationController pushViewController:orderVC animated:YES];
    } else if (indexPath.section == 1) {
        LHDistributionViewController *disVC = [[LHDistributionViewController alloc] init];
        [self.navigationController pushViewController:disVC animated:YES];
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            //卡包
            LHCardBagViewController *cardBagVC = [[LHCardBagViewController alloc] init];
            [self.navigationController pushViewController:cardBagVC animated:YES];
        } else  if (indexPath.row == 1){
            //收藏
            LHCollectViewController *collectVC = [[LHCollectViewController alloc] init];
            [self.navigationController pushViewController:collectVC animated:YES];
        } else {
            LHBoxHistoryViewController *boxVC = [[LHBoxHistoryViewController alloc] init];
            [self.navigationController pushViewController:boxVC animated:YES];
        }
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            LHReceiveAddressViewController *receiveVC = [[LHReceiveAddressViewController alloc] init];
            [self.navigationController pushViewController:receiveVC animated:YES];
            return;
        } else {
            //设置
            LHSettingViewController *settingVC = [[LHSettingViewController alloc] init];
            [self.navigationController pushViewController:settingVC animated:YES];
        }
    }

}



#pragma mark ----------------- Action -----------------------

/**
 打电话
 */
- (void)callBtnAction {
    //拨打客服电话
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://020-37889773"] options:@{} completionHandler:nil];
}

/*
 点击--->待付款, 待发货, 待收货, 待评论
 */
- (void)clickOrderBtnAction {
    [self.orderAbooutView clickCustomButton:^(NSInteger index) {
        LHMyOrderViewController *orderVC = [[LHMyOrderViewController alloc] init];
        orderVC.index = index+1;
        [self.navigationController pushViewController:orderVC animated:YES];
    }];
}

#pragma mark -------------------- 赋值 -------------------

- (void)configureDataForUser {
   LHUserInfoModel *model = [LHUserInfoManager getUserInfo];
    if (model.head_url) {
        [_headerView.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.head_url] placeholderImage:kImage(@"MyCenter_headerIcon")];
        _headerView.bgImageView.image = [self headerBgBlurImageWithURLString:model.head_url withBlurNumber:0.5];
    } else {
        _headerView.iconImageView.image = kImage(@"MyCenter_headerIcon");
        _headerView.bgImageView.image = [self boxblurImage:kImage(@"BgImage") withBlurNumber:0.5];
    }
    
    
    if (model.nick_name) {
        [_headerView.nameButton setTitle:model.nick_name forState:(UIControlStateNormal)];
    } else {
        NSString *phone = [NSString stringWithFormat:@"%@****%@", [model.username substringToIndex:3], [model.username substringFromIndex:7]];
        [_headerView.nameButton setTitle:phone forState:(UIControlStateNormal)];
    }
}

#pragma mark ---------------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    CGFloat y = offset.y;
    if (offset.y < 0) {
        CGRect rect =self.headerView.frame;
        rect.origin.y = offset.y;
        rect.size.height =CGRectGetHeight(rect)-offset.y;
        self.headerView.bgImageView.frame = rect;
        self.headerView.clipsToBounds=NO;
    }
    CGFloat alphy = y / 150 > 1.0 ? 1.0 : y / 150;
    self.hbk_navgationBar.bgColor = [UIColor colorWithRed:256 green:0 blue:0 alpha:alphy];
    self.hbk_navgationBar.titleLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:alphy];
}

#pragma mark --------------------- 高斯模糊 --------------------
- (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
}

- (UIImage *)headerBgBlurImageWithURLString:(NSString *)urlString withBlurNumber:(CGFloat)blur {
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage sd_imageWithData:data];
    return [self boxblurImage:image withBlurNumber:blur];
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
