//
//  LHCertificationViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/31.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHCertificationViewController.h"

@interface LHCertificationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *realNameTF;
@property (weak, nonatomic) IBOutlet UITextField *IDCardTF;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation LHCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view rm_fitAllConstraint];
    [self setHBK_NavigationBar];
}



#pragma mark  ----------  UI ----------------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"实名认证" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    } rightFirst:@"提交" rightFirstBtnAction:^{
        
    }];
    self.hbk_navgationBar.rightFirstBtn.frame = CGRectMake(kScreenWidth-60, 31, 50, 25);
}



- (IBAction)tapPhotoAction:(UITapGestureRecognizer *)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [LHImagePickerViewController showInViewController:self libraryType:(LHImagePickerMediaTypeCamera) allowEdit:YES complete:^(UIImage *image) {
            [self requestUpDataPhoto:image];
        }];
        
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [LHImagePickerViewController showInViewController:self libraryType:(LHImagePickerMediaTypePhotoLibrary) allowEdit:YES complete:^(UIImage *image) {
            [self requestUpDataPhoto:image];
        }];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}


/// 上传头像
-(void)requestUpDataPhoto:(UIImage *)image {
    [LHNetworkManager uploadPOST:@"" parameters:@{} consImage:image success:^(id responObject) {
        
        
    } failure:^(NSError *error) {
        
    }];
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
