//
//  LHDistributionViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/24.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHDistributionViewController.h"
#import "LHDistributionHeaderView.h"
#import "LHTitleSliderView.h"
#import "LHDistributionTableView.h"
#define kHeaderViewHeight    kFit(200)
#define kTitleHeight         kFit(40)

@interface LHDistributionViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) LHDistributionTableView *agentTableView;//代理商

@property (nonatomic, strong) LHDistributionTableView *userTableView;//用户

@property (nonatomic, strong) LHDistributionTableView *detailTableView;//明细

@property (nonatomic, strong) LHScrollView *getScrollView;

@property (nonatomic, strong) LHDistributionHeaderView *disHeaderView;

@property (nonatomic, strong) LHTitleSliderView *titleView;



@end

@implementation LHDistributionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self setHeaderView];
    [self setHBK_NavigationBar];
    
    
}

- (void)setHBK_NavigationBar {
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"分销收益" leftFirst:@"Login_Back_write" leftFirstAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    } rightFirst:@"提现" rightFirstBtnAction:^{
        NSLog(@"提现");
        
        
        
    }];
    self.hbk_navgationBar.rightFirstBtn.frame = CGRectMake(kScreenWidth-60, 31, 50, 25);
    self.hbk_navgationBar.bgColor = [UIColor clearColor];
    self.hbk_navgationBar.deviderLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.hbk_navgationBar.titleLabel.textColor = [UIColor clearColor];
    self.hbk_navgationBar.rightFirstBtn.layer.cornerRadius = 2;
    self.hbk_navgationBar.rightFirstBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.hbk_navgationBar.rightFirstBtn.layer.borderWidth = 1;
    self.hbk_navgationBar.rightFirstBtn.layer.masksToBounds = YES;
    self.hbk_navgationBar.rightFirstBtn.titleLabel.font = kFont(15);
    [self.hbk_navgationBar.rightFirstBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
}

- (void)setUI {
    self.getScrollView = [[LHScrollView alloc] init];
    [self.view addSubview:self.getScrollView];
    self.getScrollView.delaysContentTouches = NO;
    self.getScrollView.pagingEnabled = YES;
    self.getScrollView.showsVerticalScrollIndicator   = NO;
    self.getScrollView.showsHorizontalScrollIndicator = NO;
    self.getScrollView.delegate = self;
    self.getScrollView.contentSize = CGSizeMake(kScreenWidth*3, 0);
    
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, 0, kHeaderViewHeight+kTitleHeight);
    
    self.agentTableView = [[LHDistributionTableView alloc] init];
    self.agentTableView.delegate = self;
    self.agentTableView.dataSource = self;
    self.agentTableView.backgroundColor = kColor(245, 245, 245);
    self.agentTableView.tableFooterView = [[UIView alloc] init];
    [self.getScrollView addSubview:self.agentTableView];
    [self.agentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.getScrollView);
        make.width.mas_equalTo(kScreenWidth);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.agentTableView.tableHeaderView = headerView;
//    [self.agentTableView registerNib:[UINib nibWithNibName:@"LFDistributionCell" bundle:nil] forCellReuseIdentifier:@"LFDistributionCell"];
    
    self.userTableView = [[LHDistributionTableView alloc] init];
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
    self.userTableView.backgroundColor = kColor(245, 245, 245);
    self.userTableView.tableFooterView = [[UIView alloc] init];
    [self.getScrollView addSubview:self.userTableView];
    [self.userTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.getScrollView).offset(kScreenWidth);
        make.width.equalTo(self.agentTableView);
        make.top.bottom.equalTo(self.agentTableView);
    }];
    self.userTableView.tableHeaderView = headerView;
//    [self.userTableView registerNib:[UINib nibWithNibName:@"LFDistributionCell" bundle:nil] forCellReuseIdentifier:@"LFDistributionCell"];
    
    self.detailTableView = [[LHDistributionTableView alloc] initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    self.detailTableView.backgroundColor = kColor(245, 245, 245);
    self.detailTableView.tableFooterView = [[UIView alloc] init];
    [self.getScrollView addSubview:self.detailTableView];
    [self.detailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.getScrollView).offset(kScreenWidth * 2);
        make.width.equalTo(self.agentTableView);
        make.top.bottom.equalTo(self.agentTableView);
    }];
    self.detailTableView.tableHeaderView = headerView;
//    [self.detailTableView registerNib:[UINib nibWithNibName:@"LFDetailRMBCell" bundle:nil] forCellReuseIdentifier:@"LFDetailRMBCell"];
    
}

- (void)setHeaderView {
    self.disHeaderView = [LHDistributionHeaderView creatView];
    self.disHeaderView.frame = CGRectMake(0, 0, kScreenWidth, kHeaderViewHeight+kTitleHeight);
    [self.view addSubview:self.disHeaderView];

    self.titleView = [[LHTitleSliderView alloc] init];
    [self.disHeaderView addSubview:self.titleView];
    self.titleView.backgroundColor = [UIColor whiteColor];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.disHeaderView);
        make.bottom.equalTo(self.disHeaderView.mas_bottom);
        make.height.mas_equalTo(kTitleHeight);
    }];
    [self.getScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(self.disHeaderView.mas_top);
    }];
    
    _titleView.titles  = @[@"分销商", @"用户", @"明细"];
    _titleView.selectedIndex = 0;
    @weakify(self);
    _titleView.buttonSelected = ^(NSInteger index){
        @strongify(self);
        [self.getScrollView setContentOffset:CGPointMake(kScreenWidth * index, 0) animated:YES];
    };
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"aaa"];
    }
    cell.backgroundColor = kRandomColor;
    return cell;
}


#pragma mark --------------------- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.getScrollView) {
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        NSInteger pageNum = contentOffsetX / kScreenWidth + 0.5;
        self.titleView.selectedIndex = pageNum;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.getScrollView || !scrollView.window) {
        return;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat originY = 0;
    CGFloat otherOffsetY = 0;
    if (offsetY <= kHeaderViewHeight-64) {
        originY = -offsetY;
        if (offsetY < 0) {
            otherOffsetY = 0;
        } else {
            otherOffsetY = offsetY;
        }
    } else {
        originY = -kHeaderViewHeight+64;
        otherOffsetY = kHeaderViewHeight+64;
    }
    self.disHeaderView.frame = CGRectMake(0, originY, kScreenWidth, kHeaderViewHeight+kTitleHeight);
    for ( int i = 0; i < self.titleView.titles.count; i++ ) {
        if (i != self.titleView.selectedIndex) {
            UITableView *contentView = self.getScrollView.subviews[i];
            CGPoint offset = CGPointMake(0, otherOffsetY);
            if ([contentView isKindOfClass:[UITableView class]]) {
                if (contentView.contentOffset.y < kHeaderViewHeight || offset.y < kHeaderViewHeight) {
                    [contentView setContentOffset:offset animated:NO];
                    self.getScrollView.offset = offset;
                }
            }
        }
    }
    
    CGPoint offset = scrollView.contentOffset;
    CGFloat y = offset.y;
    CGFloat alphy = y / 150 > 1.0 ? 1.0 : y / 150;
    self.hbk_navgationBar.bgColor = [UIColor colorWithRed:256 green:0 blue:0 alpha:alphy];
    self.hbk_navgationBar.titleLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:alphy];
    
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
