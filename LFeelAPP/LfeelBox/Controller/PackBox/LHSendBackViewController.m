//
//  LHSendBackViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHSendBackViewController.h"

@interface LHSendBackViewController ()
/*新名*/
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
/*电话*/
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
/*快递单号*/
@property (weak, nonatomic) IBOutlet UITextField *expressNumTF;
/*数量*/
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
/*备注*/
@property (weak, nonatomic) IBOutlet UITextField *remarkTF;

@end

@implementation LHSendBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view rm_fitAllConstraint];
    [self setHBK_NavigationBar];
}
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;

    @weakify(self);
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"寄回盒子" backAction:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    } rightFirst:@"Home_Camera" rightFirstBtnAction:^{
        
        
    }];
}

//选择数量

- (IBAction)sendBackCountAction:(UIButton *)sender {
    
    
    
}

//提交
- (IBAction)submitAction:(UIButton *)sender {
    

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
