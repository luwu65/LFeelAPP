//
//  LHMyOrderViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/16.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHMyOrderViewController.h"
#import "LHSegmentControlView.h"
@interface LHMyOrderViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UIScrollView *myOrderScrollView;
@property (nonatomic, strong) UITableView *allOrderTV;//全部订单
@property (nonatomic, strong) UITableView *payTV;//待付款
@property (nonatomic, strong) UITableView *sendTV;//待发货
@property (nonatomic, strong) UITableView *receiveTV;//待收货
@property (nonatomic, strong) UITableView *commentTV;//待评价

@end

@implementation LHMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self setHBK_NavigationBar];
}
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"我的订单" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ordercell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"ordercell"];
    }
    return cell;
}


- (void)setUI {
    NSInteger scrollHeight = kScreenHeight-kNavBarHeight-42;
    self.myOrderScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+42, kScreenWidth, scrollHeight)];
    self.myOrderScrollView.contentSize = CGSizeMake(0, kScreenWidth*5);
    self.myOrderScrollView.pagingEnabled = YES;
    [self.view addSubview:self.myOrderScrollView];

    self.allOrderTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, scrollHeight) style:(UITableViewStylePlain)];
    self.allOrderTV.delegate = self;
    self.allOrderTV.dataSource = self;
    [self.myOrderScrollView addSubview:self.allOrderTV];
    
    self.payTV = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, scrollHeight) style:(UITableViewStylePlain)];
    self.payTV.delegate = self;
    self.payTV.dataSource = self;
    [self.myOrderScrollView addSubview:self.payTV];
    
    self.sendTV = [[UITableView alloc] initWithFrame:CGRectMake(2*kScreenWidth, 0, kScreenWidth, scrollHeight) style:(UITableViewStylePlain)];
    self.sendTV.delegate = self;
    self.sendTV.dataSource = self;
    [self.myOrderScrollView addSubview:self.sendTV];
    
    self.commentTV = [[UITableView alloc] initWithFrame:CGRectMake(4*kScreenWidth, 0, kScreenWidth, scrollHeight) style:(UITableViewStylePlain)];
    self.commentTV.delegate = self;
    self.commentTV.dataSource = self;
    [self.myOrderScrollView addSubview:self.commentTV];
    
    __weak typeof(self) weakself = self;
    LHSegmentControlView *segView = [[LHSegmentControlView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, 44*kRatio) titleArray:@[@"全部", @"待付款", @"待发货", @"待收货", @"待评价"] titleFont:kFont(15) titleDefineColor:[UIColor blackColor] titleSelectedColor:[UIColor redColor]];
    [self.view addSubview:segView];
    
    self.receiveTV = [[UITableView alloc] initWithFrame:CGRectMake(3*kScreenWidth, 0, kScreenWidth, scrollHeight) style:(UITableViewStylePlain)];
    self.receiveTV.delegate = self;
    self.receiveTV.dataSource = self;
    [self.myOrderScrollView addSubview:self.receiveTV];
    

    [segView clickTitleButtonBlock:^(NSInteger index) {
        if (index == 0) {
            weakself.myOrderScrollView.contentOffset = CGPointMake(0, 0);
            
        } else if (index == 1){
            weakself.myOrderScrollView.contentOffset = CGPointMake(kScreenWidth, 0);
            
        } else if (index == 2) {
            weakself.myOrderScrollView.contentOffset = CGPointMake(2*kScreenWidth, 0);
            

        
        } else if (index == 3) {
            weakself.myOrderScrollView.contentOffset = CGPointMake(3*kScreenWidth, 0);

            
        } else if (index == 4) {
            weakself.myOrderScrollView.contentOffset = CGPointMake(4*kScreenWidth, 0);            
        }
    }];
    
    //判断上个页面是点击哪个按钮进来的, 对应上相应的scrollView的偏移量
    for (UIView *btn in [segView subviews]) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn.tag == self.index + 3000) {
                [(UIButton *)btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
            } else {
                [(UIButton *)btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            }
        }
    }
    if (self.index == 0) {

        self.myOrderScrollView.contentOffset = CGPointMake(0, 0);
    } else if (self.index == 1) {
      
        self.myOrderScrollView.contentOffset = CGPointMake(kScreenWidth, 0);
        [UIView animateWithDuration:0.25 animations:^{
            CGPoint point = segView.sliderView.center;
            point.x = segView.sliderView.center.x + kScreenWidth/5;
            segView.sliderView.center = point;
        }];
        
    } else if (self.index == 2) {
        self.myOrderScrollView.contentOffset = CGPointMake(2*kScreenWidth, 0);
        [UIView animateWithDuration:0.25 animations:^{
            CGPoint point = segView.sliderView.center;
            point.x = segView.sliderView.center.x + kScreenWidth/5*2;
            segView.sliderView.center = point;
        }];

    } else if (self.index == 3) {
        self.myOrderScrollView.contentOffset = CGPointMake(3*kScreenWidth, 0);
        [UIView animateWithDuration:0.25 animations:^{
            CGPoint point = segView.sliderView.center;
            point.x = segView.sliderView.center.x + kScreenWidth/5*3;
            segView.sliderView.center = point;
        }];

    } else if (self.index == 4) {
        self.myOrderScrollView.contentOffset = CGPointMake(4*kScreenWidth, 0);
        [UIView animateWithDuration:0.25 animations:^{
            CGPoint point = segView.sliderView.center;
            point.x = segView.sliderView.center.x + kScreenWidth/5*4;
            segView.sliderView.center = point;
        }];
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
