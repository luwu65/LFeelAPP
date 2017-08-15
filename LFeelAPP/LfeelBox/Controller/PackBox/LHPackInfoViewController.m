//
//  LHPackInfoViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/31.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHPackInfoViewController.h"
#import "LHPackInfoView.h"
@interface LHPackInfoViewController ()

@end

@implementation LHPackInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    [self setHBK_NavigationBar];
}


#pragma mark  ------------- UI -------------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"完善信息" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)setupUI {
    UIView *defaultView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kFit(35))];
    defaultView.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:defaultView];
    
    CustomButton *defaultBtn = [[CustomButton alloc] initWithFrame:CGRectMake(kScreenWidth-kFit(100), 0, kFit(80), kFit(35)) imageFrame:CGRectMake(0, 0, kFit(35), kFit(35)) imageName:@"" titleLabelFrame:CGRectMake(kFit(35), 0, kFit(45), kFit(35)) title:@"默认" titleColor:[UIColor blackColor] titleFont:15];
    [defaultView addSubview:defaultBtn];
    
//    LHPackInfoView *firstView = [LHPackInfoView creatView];
//    firstView.frame = CGRectMake(0, 64+kFit(35), kScreenWidth, kFit(45));
//    [self.view addSubview:firstView];
    
//    LHPackInfoView *secondView = [LHPackInfoView creatView];
//    secondView.frame = CGRectMake(0, 64+kFit(35)+kFit(45), kScreenWidth, kFit(45));
//    [self.view addSubview:secondView];
//    
//    LHPackInfoView *thirdView = [LHPackInfoView creatView];
//    thirdView.frame = CGRectMake(0, 64+kFit(35)+kFit(45)*2, kScreenWidth, kFit(45));
//    [self.view addSubview:thirdView];
    
    
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
