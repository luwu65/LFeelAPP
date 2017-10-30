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


//警告
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;

//提示
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@property (nonatomic, copy) NSString *phoneUrl;

@end

@implementation LHCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view rm_fitAllConstraint];
    [self setHBK_NavigationBar];
    
    [self configureData];
    
    
    //isreal 0->待审核
    if ([[LHUserInfoManager getUserInfo].isreal integerValue] == 1) {//审核中
        self.warningLabel.text = @"审核中, 不可更改...";
        [self.hbk_navgationBar.rightFirstBtn setTitle:@"审核中" forState:(UIControlStateNormal)];
        self.hbk_navgationBar.rightFirstBtn.userInteractionEnabled = NO;
        [self closeUserInteractionEnabled];
    } else if ([[LHUserInfoManager getUserInfo].isreal integerValue] == 2) {//通过
        self.warningLabel.text = @"已完成实名认证,不可更改!";
        self.hbk_navgationBar.rightFirstBtn.hidden = YES;
        [self closeUserInteractionEnabled];

    } else if ([[LHUserInfoManager getUserInfo].isreal integerValue] == 3) {//审核驳回
        self.warningLabel.text = @"请重新实名认证!";
        
        
    }   
}



#pragma mark  ----------  UI ----------------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"实名认证" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    } rightFirst:@"提交" rightFirstBtnAction:^{
        kVerifyText(self.realNameTF.text, @"请输入姓名");
        kIDCard(self.IDCardTF.text, @"请输入正确身份证号");
        kVerifyText(self.phoneUrl.length, @"请上传身份证照片");
        [self requestCertificationData];
    }];
    self.hbk_navgationBar.rightFirstBtn.frame = CGRectMake(kScreenWidth-60, 0, 50, 44);
}


#pragma mark ---------------- Action -----------------
- (IBAction)tapPhotoAction:(UITapGestureRecognizer *)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    kWeakSelf(self);
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        kStrongSelf(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [LHImagePickerViewController showInViewController:self libraryType:(LHImagePickerMediaTypeCamera) allowEdit:YES complete:^(UIImage *image) {
                [self requestUploadIDCardPhotoData:image];
                
            }];
        });
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"从相册选择照片" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        kStrongSelf(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [LHImagePickerViewController showInViewController:self libraryType:(LHImagePickerMediaTypePhotoLibrary) allowEdit:YES complete:^(UIImage *image) {
                [self requestUploadIDCardPhotoData:image];
            }];
        });
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}



/**
 图片转base64

 @param image 图片
 @return base64字符串
 */
- (NSString *)imageToBase64:(UIImage *)image {
    NSData * data = [UIImagePNGRepresentation(image) base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return [NSString stringWithUTF8String:[data bytes]];
    
}

#pragma mark ------------------ 网络请求 ------------------
//提交
- (void)requestCertificationData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showProgressHUDWithTitle:@"提交中"];
    });
    [LHNetworkManager PostWithUrl:kCertificationUrl parameter:@{@"real_name": self.realNameTF.text, @"id_num": self.IDCardTF.text, @"user_id": kUser_id, @"id_positive": self.phoneUrl} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [LHUserInfoManager cleanUserInfo];
                LHUserInfoModel *model = [[LHUserInfoModel alloc] init];
                [model setValuesForKeysWithDictionary:reponseObject[@"data"]];
                [LHUserInfoManager saveUserInfoWithModel:model];
                
                [self hideProgressHUD];
                [MBProgressHUD showSuccess:@"已提交实名认证"];
                [self.navigationController popViewControllerAnimated:YES];
            });
            self.realNameTF.userInteractionEnabled = NO;
            self.IDCardTF.userInteractionEnabled = NO;
            self.photoImageView.userInteractionEnabled = NO;
            [self.hbk_navgationBar.rightFirstBtn setTitle:@"审核中" forState:(UIControlStateNormal)];
            self.hbk_navgationBar.rightFirstBtn.userInteractionEnabled = NO;
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideProgressHUD];
                [MBProgressHUD showError:@"提交失败"];
            });
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)requestUploadIDCardPhotoData:(UIImage *)image {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showProgressHUDWithTitle:@"上传中..."];
    });
    [LHNetworkManager uploadPOST:kUploadImageUrl parameters:@{} consImage:image imageName:@"certification" success:^(id responObject) {
        NSLog(@"%@", responObject);
        if ([responObject[@"errorCode"] integerValue] == 200) {
            self.phoneUrl = responObject[@"data"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideProgressHUD];
                [MBProgressHUD showSuccess:@"上传成功"];
                self.photoImageView.image = image;
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideProgressHUD];
            });
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)configureData {
    LHUserInfoModel *model = [LHUserInfoManager getUserInfo];
    self.realNameTF.text = model.real_name;
    self.IDCardTF.text = model.id_num;
    [self.photoImageView sd_setImageWithURL:kURL(model.id_positive) placeholderImage:kImage(@"MyBox_Certification")];
    
    NSLog(@"%@------------%@--------------%@", model.real_name, model.id_num, model.id_positive);
}

- (void)closeUserInteractionEnabled {
    self.realNameTF.userInteractionEnabled = NO;
    self.IDCardTF.userInteractionEnabled = NO;
    self.photoImageView.userInteractionEnabled = NO;
    self.hbk_navgationBar.rightFirstBtn.userInteractionEnabled = NO;
    self.hintLabel.hidden = YES;
    
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
