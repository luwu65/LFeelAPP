//
//  LHAddBankCardViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHAddBankCardViewController.h"

@interface LHAddBankCardViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *bankCard;
@property (weak, nonatomic) IBOutlet UITextField *IDCardTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *captchaTF;
@property (weak, nonatomic) IBOutlet UIButton *captchalBtn;

@end

@implementation LHAddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (void)setHBK_NavigationBar {
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"添加信用卡" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


//
- (IBAction)addAction:(UIButton *)sender {
    
    
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
