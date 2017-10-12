//
//  LHEditCommentViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/27.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHEditCommentViewController.h"
#import "LHAddCommentView.h"
#import "LHPhotoPickManager.h"

@interface LHEditCommentViewController ()

@property (nonatomic, strong) LHAddCommentView *addView;

@end

@implementation LHEditCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setHBK_NavigationBar];
    [self setFirstSubView];
    
}

#pragma mark ---------------------  UI -------------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"评价" backAction:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    } rightFirst:@"发表" rightFirstBtnAction:^{
        
        
    }];
    self.hbk_navgationBar.rightFirstBtn.frame = CGRectMake(kScreenWidth-60, 27, 50, 30);
}

- (void)setFirstSubView {
    self.addView = [LHAddCommentView creatView];
    self.addView.frame = CGRectMake(0, 64, kScreenWidth, (kScreenWidth-kFit(40))/3+kFit(140));
    kWeakSelf(self);
    self.addView.ClickBlock = ^{
        kStrongSelf(self);
        [[LHPhotoPickManager sharedManager] getImagesInView:self maxCount:3 - self.addView.photoArray.count successBlock:^(NSMutableArray<UIImage *> *images) {
//            NSLog(@"选中---->>>>> %@", images);
            kStrongSelf(self);
            if (self.addView.photoArray.count != 0) {
                [self.addView.photoArray addObjectsFromArray:images];
                NSLog(@"------- >>>> %ld", self.addView.photoArray.count);
                [self.addView updateLayout];
            } else {
                self.addView.photoArray = [NSMutableArray arrayWithArray:images];
            }
        }];
    };
    [self.view addSubview:self.addView];
}




#pragma mark ------------------------ 网路请求 ---------------------











































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
