//
//  LHAllCommentViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/28.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHAllCommentViewController.h"

@interface LHAllCommentViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *allTableView;



@end

@implementation LHAllCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
    
    
    [self setHBK_NavigationBar];
}

- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"全部评论" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}



- (void)setUI {
    self.allTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.allTableView.delegate = self;
    self.allTableView.dataSource = self;
    [self.view addSubview:self.allTableView];
    
    
}

#pragma  mark ----------- <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"allCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"allCell"];
    }
    return cell;
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
