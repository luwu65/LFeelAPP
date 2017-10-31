//
//  LHLeBaiViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/25.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHLeBaiViewController.h"
#import "LHLeBaiPayViewController.h"
#import "LHLeBaiPayAgainViewController.h"
#import "LHPayResultsViewController.h"

@interface LHLeBaiViewController ()<LHPickViewDelegate>

/**
 商品金额
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

/**
 分期期数
 */
@property (weak, nonatomic) IBOutlet UILabel *countLabel;


/**
 每期金额
 */
@property (weak, nonatomic) IBOutlet UILabel *everyPriceLabel;

/**
 分期手续费
 */
@property (weak, nonatomic) IBOutlet UILabel *handingChargeLabel;

/**
 每一期扣款
 */
@property (weak, nonatomic) IBOutlet UILabel *everyChargeLabel;

/**
 往后每期扣款
 */
@property (weak, nonatomic) IBOutlet UILabel *laterChargeLabel;

/**
 产品分期总金额
 */
@property (weak, nonatomic) IBOutlet UILabel *allPriceLabel;

@property (nonatomic, strong) LHPickView *linePickView;


/**
 分期数
 */
@property (nonatomic, assign) NSInteger count;

//距离顶部的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end

@implementation LHLeBaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.topConstraint.constant = kNavBarHeight;
    [self setHBK_NavigationBar];
    if (self.orderModel) {
        [self configureDataWithPrice:[self.orderModel.shop_price floatValue] Count:6];
    } else {
        [self configureDataWithPrice:[self.orderDic[@"total_fee"] floatValue] Count:6];
        
    }
    
}

#pragma mark --------------------- UI ------------------------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"信用卡分期" backAction:^{
        [self showAlertViewWithTitle:@"确定放弃分期付款?" yesHandler:^(UIAlertAction * _Nullable action) {
            LHPayResultsViewController *resultVC = [[LHPayResultsViewController alloc] init];
            resultVC.resultDic = self.orderDic;
            resultVC.payType = 0;
            resultVC.payResultStr = @"0100";
            [self.navigationController pushViewController:resultVC animated:YES];
        } noHandler:^(UIAlertAction * _Nullable action) {
            
        }];
    }];
}
- (void)createLineOnePickViewWithArray:(NSArray *)array {
    self.linePickView = [[LHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    self.linePickView.delegate = self;
    self.linePickView.toolbarTextColor = [UIColor blackColor];
    self.linePickView.toolbarBGColor = kColor(245, 245, 245);
    [self.linePickView show];
}



#pragma mark ------------------- Action ---------------------
//选择分期  6/12期
- (IBAction)selectedCount:(UIButton *)sender {
    [self createLineOnePickViewWithArray:@[@"6期", @"12期"]];
}

/**
 下一步
 */
- (IBAction)nextButtonAction:(UIButton *)sender {
    LHLeBaiPayViewController *payVC = [[LHLeBaiPayViewController alloc] init];
    payVC.orderDic = self.orderDic;
    payVC.count = self.count;
    payVC.orderModel = self.orderModel;
    [self.navigationController pushViewController:payVC animated:YES];
}

- (void)configureDataWithPrice:(CGFloat)price Count:(NSInteger)count {
    self.count = count;
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f元", price];
    self.countLabel.text = [NSString stringWithFormat:@"%ld期", count];
    self.everyPriceLabel.text = [NSString stringWithFormat:@"%.2f", price/count];
    self.everyChargeLabel.text = [NSString stringWithFormat:@"%.2f", price/count];
    self.handingChargeLabel.text = @"0.00";
    self.laterChargeLabel.text = [NSString stringWithFormat:@"%.2f", price/count];
    self.allPriceLabel.text = [NSString stringWithFormat:@"%.2f", price];
}



#pragma mark --------------------- LHPickViewDelegate ------------
//选中pickview走的回调
- (void)toobarDonBtnHaveClick:(LHPickView *)pickView resultString:(NSString *)resultString resultIndex:(NSInteger) index {
    if (pickView == self.linePickView) {
//        NSLog(@"%@", resultString);
        if ([resultString isEqualToString:@"6期"]) {
            [self configureDataWithPrice:[self.orderDic[@"total_fee"] floatValue] Count:6];
        } else {
            [self configureDataWithPrice:[self.orderDic[@"total_fee"] floatValue] Count:12];
        }
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
