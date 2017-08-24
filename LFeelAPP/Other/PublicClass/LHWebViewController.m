
//
//  LHWebViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/18.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHWebViewController.h"

@interface LHWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation LHWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"www.baidu.com"]];
    [self.myWebView loadRequest:request];
    
    
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
