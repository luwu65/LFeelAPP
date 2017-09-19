//
//  LHMyOrderViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/16.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHMyOrderViewController.h"
#import "LHOrderListTableViewController.h"
#import "LHTitleSliderView.h"

#define kScrollHeight kScreenHeight-kNavBarHeight-kFit(44)
@interface LHMyOrderViewController ()<UIScrollViewDelegate>



@property (nonatomic, strong) UIScrollView *myOrderScrollView;
@property (nonatomic, strong) LHTitleSliderView *titleView;

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
    self.myOrderScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+kFit(44), kScreenWidth, kScrollHeight)];
    self.myOrderScrollView.contentSize = CGSizeMake(kScreenWidth*self.titleArray.count, kScrollHeight);
    self.myOrderScrollView.pagingEnabled = YES;
    self.myOrderScrollView.delegate = self;
    self.myOrderScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.myOrderScrollView];

    for (int i = 0; i < self.titleArray.count; i++) {
        LHOrderListTableViewController *orderTVC = [[LHOrderListTableViewController alloc] initWithStyle:(UITableViewStyleGrouped)];
        orderTVC.type = i;
        [self addChildViewController:orderTVC];
    }
}

- (void)setSegmentControl {
    @weakify(self);
    self.titleView = [[LHTitleSliderView alloc] init];
    [self.view addSubview:self.titleView];
    self.titleView.backgroundColor = [UIColor whiteColor];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(64);
        make.height.mas_equalTo(kFit(44));
    }];
    _titleView.titles  = self.titleArray;
    _titleView.selectedIndex = self.index;
    _titleView.buttonSelected = ^(NSInteger index){
        @strongify(self);
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.myOrderScrollView setContentOffset:CGPointMake(kScreenWidth * index, 0)];
        }];
        [self setOrderTableViewWithIndex:index];
    };
    
    [self judgeClickIndex:self.index isScroll:NO];
}


/**
 判断点击了哪个seg
 @param index 点击了第几个
 */
- (void)judgeClickIndex:(NSInteger)index isScroll:(BOOL)isScroll {
    if (!isScroll) {
        [self.myOrderScrollView setContentOffset:CGPointMake(kScreenWidth * index, 0)];
    }
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
- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView {
    if (scrollView == self.myOrderScrollView) {
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        NSInteger pageNum = contentOffsetX / kScreenWidth + 0.5;
        self.titleView.selectedIndex = pageNum;
        [self judgeClickIndex:pageNum isScroll:YES];
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
