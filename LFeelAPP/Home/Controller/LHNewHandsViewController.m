//
//  LHNewHandsViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/16.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHNewHandsViewController.h"
#import "LHTextCell.h"
#import "LHAddVipViewController.h"
@interface LHNewHandsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *questionArray;

@property (nonatomic, strong) NSMutableArray *contentArray;

@end

@implementation LHNewHandsViewController


- (NSMutableArray *)questionArray {
    if (!_questionArray) {
        self.questionArray = [NSMutableArray arrayWithObjects:
                              @"1. 什么是乐荟包年（半年）会员服务",
                              @"2. 我收到的服饰是全新的吗?",
                              @"3. 乐荟的服饰是否是正品?",
                              @"4. 乐荟的服饰是如何清洗的?",
                              @"5. 哪些城市可以使用乐荟的服务?",
                              @"6. 如何更换使用乐荟盒子?",
                              @"7. 往返的邮费是到付吗?",
                              @"8. 我下单后，多久可以收到衣服?",
                              @"9. 我手上可以同时持有几个乐荟盒子?",
                              @"10. 下单后能更改我的订单吗?",
                              @"11. 如果衣服损坏或丢失，我该怎么做?",
                              @"12. 会员期如何计算?",
                              @"13. 会员到期后，何时归还时装箱?",
                              @"14. 不需要下单时，我该如何归还手上的衣箱?",
                              @"15. 我把私人物品随时装箱寄回了，我该怎么办?", nil];
    }
    return _questionArray;
}

- (NSMutableArray *)contentArray {
    if (!_contentArray) {
        self.contentArray = [NSMutableArray arrayWithObjects:
                             @"    在乐荟APP支付年费成为包年（半年）会员，可以在会员期内更换乐荟全部服饰，每次选择3件，不限更换次数、不限持有时间，直到会员期结束。",
                             @"    乐荟会不定时上新，这部分时装是全新的，所以服饰供会员共享使用。乐荟对所有服饰质量严格把控，保持类全新状态，任何损坏、磨损、污损、起毛的服饰即刻下架。",
                             @"    乐荟所有服饰均为平台买手通过正规渠道当季订货、采购或与品牌直接合作。无个人闲置服饰、山寨品牌服饰。",
                             @"    乐荟为全部进、出库服饰、礼服及配饰等提供五星级的专业清洗与保养服务，采用第五代专业设备，经过12道工序，能够做到细菌和衣物的彻底分离。除部分不能干洗的面料外，绝大多数衣物采用干洗，完全符合国际最新干洗ISO8230标准。第五代设备实现清洗、消毒、烘干、过滤全封闭一体式操作，避免空间操作中的二次污染。服饰在清洗到再次寄出的过程中，会有四道质检，确保衣物状态如新。",
                             @"    乐荟目前的配送范围已覆盖国际范围，即使身在国外也可享受到乐荟的服务。",
                             @"    距离上一次下单48小时后，，你即可在乐荟上提交新的订单。用户把需更换的衣物装进乐荟盒子，以到付的方式，原路返回，仓库收到盒子，确认衣物无明显损耗后，以到付的方式寄出相应数量的衣物给客户。",
                             @"    所有往返邮费都是到付的，由于商品单价较高，到付更有保障。",
                             @"    每日17点整为当日截止配货时间。每天17点前下单快递会在当天发出，顺丰邮寄，一般收货时间为1－3天。",
                             @"    每个用户手上只能持有一个乐荟盒子，用户更换衣物须把原来的盒子寄回，仓库才会把用户须更换的衣物寄出。",
                             @"    请您下单前反复确认自己的订单内容及地址电话信息无误。下单后则无法更改订单内的商品，以及接收地址、电话等信息。",
                             @"    日常穿衣过程中出现的正常损耗，无需赔偿。但如果衣服严重损坏或者丢失，请第一时间联系客服，根据衣服的市场价值、损坏的程度进行赔偿。",
                             @"    会员期从在乐荟支付成为会员后，即日起计算。",
                             @"    过期后不续费，请在到期前后三天内寄回乐荟盒子。",
                             @"    请进入乐荟APP的“时装箱”页面，点击“送还这个时装箱”按钮即可直接预约快递上门取衣。退件寄出后请务必保留物流凭证（运单及短信），以防快递丢失你的时装箱，乐荟也将实时跟踪订单状态。",
                             @"    请您在第一时间与乐荟商城客服联系。请注意：请您于归还衣物前注意整理并取出在衣物中的或附着在衣物上的私人物品。如因您在还衣时未能取出该等私人物品而造成该等私人物品损坏、遗失或导致您遭受任何其他损失，乐荟对该等损失均不承担任何责任。", nil];
    }
    return _contentArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (_index == 0) {
        [self setUIWithNewHands];
        self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"新手指导" backAction:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else if (_index == 1) {
        [self setUIWithClean];
        self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"清洗报告" backAction:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else if (_index == 2){
        [self setUIWithNewHandsUnderstand];
        self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"会员权利" backAction:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else if (_index == 3) {
        [self setUIWithRentStep];
        self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"租用流程" backAction:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}




//新手指导
- (void)setUIWithNewHands {
    LHScrollView *scrollView = [[LHScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-kNavBarHeight) imageArray:@[@"NewHands_01", @"NewHands_02", @"NewHands_03", @"NewHands_04", @"NewHands_05"]];
    [self.view addSubview:scrollView];
    
    UIButton *addVipBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [addVipBtn setTitle:@"加入乐荟会员" forState:(UIControlStateNormal)];
    [addVipBtn setTitleColor:kColor(255, 49, 64) forState:(UIControlStateNormal)];
    addVipBtn.layer.borderColor = kColor(255, 49, 64).CGColor;
    addVipBtn.layer.borderWidth = 1;
    [addVipBtn addTarget:self action:@selector(addVipBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    addVipBtn.frame = CGRectMake((kScreenWidth-150)/2, kScreenHeight-40*kRatio-40-kNavBarHeight, 150, 40*kRatio);
    scrollView.subviews.lastObject.userInteractionEnabled = YES;
    [scrollView.subviews.lastObject addSubview:addVipBtn];
    
}

- (void)addVipBtnAction {
    NSLog(@"加入会员");
    LHAddVipViewController *addVipVC = [[LHAddVipViewController alloc] init];
    [self.navigationController pushViewController:addVipVC animated:YES];
}


//清理
- (void)setUIWithClean {
    LHScrollView *scrollView = [[LHScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-kNavBarHeight) imageArray:@[@"HomeClean_01", @"HomeClean_02", @"HomeClean_03", @"HomeClean_04"]];
    [self.view addSubview:scrollView];
}


//租用流程
- (void)setUIWithRentStep {
    LHScrollView *scrollView = [[LHScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-kNavBarHeight) imageArray:@[@"RentStep_01", @"RentStep_02"]];
    [self.view addSubview:scrollView];
}



//新手须知
- (void)setUIWithNewHandsUnderstand {
    UITableView *understandTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-kNavBarHeight) style:(UITableViewStylePlain)];
    understandTableView.dataSource = self;
    understandTableView.delegate = self;
    [self.view addSubview:understandTableView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Home_Understand"]];
    imageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth*2/3);
    understandTableView.tableHeaderView = imageView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld", (unsigned long)self.questionArray.count);
    return self.questionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHTextCell"];
    if (cell == nil) {
        cell = [[LHTextCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LHTextCell"];
    }
    cell.titleLabel.text = self.questionArray[indexPath.row];
    cell.contentLabel.text = self.contentArray[indexPath.row];
    [cell adjustCellWithString:self.contentArray[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"!!!!!!%lf", [LHTextCell cellHeightWithString:self.contentArray[indexPath.row]]);
    return [LHTextCell cellHeightWithString:self.contentArray[indexPath.row]];
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
