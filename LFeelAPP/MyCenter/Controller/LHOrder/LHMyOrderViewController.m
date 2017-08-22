//
//  LHMyOrderViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/16.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHMyOrderViewController.h"
#import "LHSegmentControlView.h"
#import "LHOrderListTableViewController.h"

#define kScrollHeight kScreenHeight-kNavBarHeight-42
@interface LHMyOrderViewController ()///<UIScrollViewDelegate>



@property (nonatomic, strong) UIScrollView *myOrderScrollView;
@property (nonatomic, strong) LHSegmentControlView *segView;
@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation LHMyOrderViewController
- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        self.titleArray = [NSMutableArray arrayWithObjects:@"全部", @"待付款", @"待发货", @"待收货", @"待评价", nil];
    }
    return _titleArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    [self setScrollViewUI];
    [self setSegmentControl];
   
    [self setHBK_NavigationBar];
}


#pragma mark ------------- UI -------------

- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:self.titleArray[self.index] backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)setScrollViewUI {
    self.myOrderScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+42, kScreenWidth, kScrollHeight)];
    self.myOrderScrollView.contentSize = CGSizeMake(kScreenWidth*self.titleArray.count, kScrollHeight);
    self.myOrderScrollView.pagingEnabled = YES;
//    self.myOrderScrollView.delegate = self;
    self.myOrderScrollView.showsHorizontalScrollIndicator = NO;
    self.myOrderScrollView.scrollEnabled = NO;
    [self.view addSubview:self.myOrderScrollView];

    for (int i = 0; i < self.titleArray.count; i++) {
        LHOrderListTableViewController *orderTVC = [[LHOrderListTableViewController alloc] initWithStyle:(UITableViewStyleGrouped)];
        [self addChildViewController:orderTVC];
    }
}

- (void)setSegmentControl {
    @weakify(self);
    self.segView = [[LHSegmentControlView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, 44*kRatio) titleArray:self.titleArray titleFont:kFont(15) titleDefineColor:[UIColor blackColor] titleSelectedColor:[UIColor redColor]];
    [self.view addSubview:self.segView];

    [self.segView clickTitleButtonBlock:^(NSInteger index) {
        [UIView animateWithDuration:0.25 animations:^{
            @strongify(self);
            [self.myOrderScrollView setContentOffset:CGPointMake(kScreenWidth * index, 0)];
        }];
        [self setOrderTableViewWithIndex:index];
        
    }];
    
    [self judgeClickIndex:self.index isScroll:NO];
}


/**
 判断点击了哪个seg
 @param index 点击了第几个
 */
- (void)judgeClickIndex:(NSInteger)index isScroll:(BOOL)isScroll {
    @weakify(self);
    //判断点击了哪个seg
    for (UIView *btn in [self.segView subviews]) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn.tag == index + 3000) {
                [(UIButton *)btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
            } else {
                [(UIButton *)btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            }
        }
    }
    if (!isScroll) {
        [self.myOrderScrollView setContentOffset:CGPointMake(kScreenWidth * index, 0)];
    }
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self);
        CGPoint point = self.segView.sliderView.center;
        point.x = self.segView.sliderView.center.x + kScreenWidth/self.titleArray.count * index;
        self.segView.sliderView.center = point;
    }];
    [self setOrderTableViewWithIndex:index];

}

- (void)setOrderTableViewWithIndex:(NSInteger)index {
    self.hbk_navgationBar.titleLabel.text = self.titleArray[index];
    LHOrderListTableViewController *orderView = self.childViewControllers[index];
    if (!orderView.isViewLoaded) {
        orderView.view.frame = CGRectMake(index * kScreenWidth, 0, kScreenWidth, kScrollHeight);
        orderView.type = index;
        [self.myOrderScrollView addSubview:orderView.view];
    } else {
        if (orderView.isNeedRefresh) {
            [orderView reloadData];
        }
    }
}

//刷新子控制器
 //needRefresh 是否需要刷新
//- (void)makeAllControllerNeedRefreshNeedImmediately:(BOOL)immediately {
//    for (LHOrderListTableViewController* vc in self.childViewControllers) {
//        vc.needRefresh = YES;
//    }
//    if (immediately) {
//        LHOrderListTableViewController* vc = self.childViewControllers[self.index];
//        [vc reloadData];
//    }
//}

#pragma mark -------------------- UIScrollViewDelegate ------------------
//- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView {
//    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
//    if (self.index == index) {
//        return;
//    }
//    NSLog(@"%ld", index);
//    self.hbk_navgationBar.titleLabel.text = self.titleArray[index];
//
//    [self judgeClickIndex:index isScroll:YES];
//
//}
//- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
//    if (scrollView != self.myOrderScrollView) {
//        return;
//    }
//    CGFloat x = scrollView.contentOffset.x;
//    if (x <= 0 || x >= kScreenWidth * self.titleArray.count) {
//        return;
//    }
//}






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
