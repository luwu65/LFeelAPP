//
//  LHUserInfoViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/20.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHUserInfoViewController.h"
#import "LHUserInfoCell.h"
#import "LHBWHPickView.h"
#import "LHCertificationViewController.h"
@interface LHUserInfoViewController ()<LHPickViewDelegate>


@property (nonatomic, strong) LHPickView *linePickView;

@property (nonatomic, strong) NSMutableArray *heightArray;//身高
@property (nonatomic, strong) NSMutableArray *weightArray;//体重
@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;

@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *BWHLabel;
@property (weak, nonatomic) IBOutlet UILabel *shoesLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
//实名认证
@property (weak, nonatomic) IBOutlet UILabel *certifationLabel;

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic, strong) LHBWHPickView *bwhPickView;

@property (nonatomic, copy) NSString *iconUrl;
//胸围
@property (nonatomic, copy) NSString *chest;
@property (nonatomic, copy) NSString *waist;
@property (nonatomic, copy) NSString *hip;

@end

@implementation LHUserInfoViewController {
    
    NSString *_ChooseID;
    
}
- (NSMutableArray *)weightArray {
    if (!_weightArray) {
        self.weightArray = [NSMutableArray new];
        for (int i = 35; i < 90; i++) {
            [_weightArray addObject:[NSString stringWithFormat:@"%dKG", i]];
        }
    }
    return _weightArray;
}
- (NSMutableArray *)heightArray {
    if (!_heightArray) {
        _heightArray = [NSMutableArray new];
        for (int i = 120; i < 196; i++) {
            [_heightArray addObject:[NSString stringWithFormat:@"%dCM", i]];
        }
    }
    return _heightArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view rm_fitAllConstraint];
    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.height/2;
    self.iconImageView.image = [UIImage imageNamed:@"MyCenter_headerIcon"];
    self.iconImageView.layer.masksToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureData];
    
    [self setHBK_NavigationBar];
    
    
}

#pragma mark ---------------- UI ----------------------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"个人信息" leftFirst:@"Back_Button" leftFirstAction:^{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"是否保存" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"否" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"是" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            [self requestSubmitUserInfoData];
        }]];
        [self presentViewController:alertVC animated:YES completion:nil];
    }];
}


- (void)createLineOnePickViewWithArray:(NSArray *)array {
    self.linePickView = [[LHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    self.linePickView.delegate = self;
    self.linePickView.toolbarTextColor = [UIColor blackColor];
    self.linePickView.toolbarBGColor = kColor(245, 245, 245);
    [self.linePickView show];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
        _bgView.tag = 999;
        _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleWindowAction)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (LHBWHPickView *)bwhPickView {
    if (!_bwhPickView) {
        self.bwhPickView = [LHBWHPickView creatView];
        self.bwhPickView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenWidth*0.8);
        @weakify(self);
        self.bwhPickView.SureBlock = ^(NSString *chest, NSString *waist, NSString *hip) {
//            NSLog(@"确定------胸围%@-----腰围%@-----臀围%@", chest, waist, hip);
            @strongify(self);
            self.chest = [NSString stringWithFormat:@"%@CM", chest];
            self.waist = [NSString stringWithFormat:@"%@CM", waist];;
            self.hip = [NSString stringWithFormat:@"%@CM", hip];
            self.BWHLabel.text = [NSString stringWithFormat:@"胸围%@CM-腰围%@CM-臀围%@CM", chest, waist, hip];
            self.BWHLabel.textColor = [UIColor blackColor];
            [self handleWindowAction];
        };
        self.bwhPickView.CancelBlock = ^{
            NSLog(@"取消");
            @strongify(self);
            [self handleWindowAction];
        };
    }
    return _bwhPickView;
}


- (void)showBWHPickView {
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    [self.bgView addSubview:self.bwhPickView];
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint point = self.bwhPickView.center;
        point.y = point.y-kScreenWidth*0.8;
        self.bwhPickView.center = point;
    } completion:^(BOOL finished) {
        
    }];
}



#pragma mark --------------------- LHPickViewDelegate ------------
//选中pickview走的回调
- (void)toobarDonBtnHaveClick:(LHPickView *)pickView resultString:(NSString *)resultString resultIndex:(NSInteger) index {
    if (pickView == self.linePickView) {
        NSLog(@"%@", resultString);
        if ([_ChooseID isEqualToString:@"height"]) {
            self.heightLabel.text = resultString;
            self.heightLabel.textColor = [UIColor blackColor];
        } else if ([_ChooseID isEqualToString:@"wight"]) {
            self.weightLabel.text = resultString;
            self.weightLabel.textColor = [UIColor blackColor];
        } else if ([_ChooseID isEqualToString:@"bwh"]) {
            self.BWHLabel.text = resultString;
            self.BWHLabel.textColor = [UIColor blackColor];
        } else if ([_ChooseID isEqualToString:@"shoes"]) {
            self.shoesLabel.text = [NSString stringWithFormat:@"%@码", resultString];
            self.shoesLabel.textColor = [UIColor blackColor];
        } else if ([_ChooseID isEqualToString:@"size"]) {
            self.sizeLabel.text = resultString;
            self.sizeLabel.textColor = [UIColor blackColor];
        }
    }
}

#pragma mark -------------- Action ---------------------
//头像
- (IBAction)iconBtn:(UIButton *)sender {
    NSLog(@"换头像");
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [LHImagePickerViewController showInViewController:self libraryType:(LHImagePickerMediaTypeCamera) allowEdit:YES complete:^(UIImage *image) {
            [self requestUpDataPhoto:image];
        }];
        
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"从相册获取照片" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [LHImagePickerViewController showInViewController:self libraryType:(LHImagePickerMediaTypePhotoLibrary) allowEdit:YES complete:^(UIImage *image) {
            [self requestUpDataPhoto:image];
        }];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];

}

//身高
- (IBAction)heightBtn:(UIButton *)sender {
    _ChooseID = @"height";
    [self createLineOnePickViewWithArray:self.heightArray];
}

//体重
- (IBAction)weightBtn:(UIButton *)sender {
    _ChooseID = @"wight";
    [self createLineOnePickViewWithArray:self.weightArray];
}

//三围
- (IBAction)bwhBtn:(UIButton *)sender {
    _ChooseID = @"bwh";
    NSLog(@"三围");
    [self showBWHPickView];
    
}

//鞋码
- (IBAction)shosBtn:(UIButton *)sender {
    _ChooseID = @"shoes";
    [self createLineOnePickViewWithArray:kShoesSize];

}

//尺码
- (IBAction)sizeBtn:(UIButton *)sender {
    _ChooseID = @"size";
    [self createLineOnePickViewWithArray:kClothesSize];
}

//实名认证
- (IBAction)realNameCertification:(UIButton *)sender {
    LHCertificationViewController *cerVC = [[LHCertificationViewController alloc] init];
    
    [self.navigationController pushViewController:cerVC animated:YES];
}

//提交
- (IBAction)submit:(UIButton *)sender {
    kVerifyText(self.nickNameTF.text.length, @"请输入昵称");
    if ([self.heightLabel.text isEqualToString:@"请选择身高"]) {
        [MBProgressHUD showError:@"请选择身高"];
        return ;
    }
    if ([self.weightLabel.text isEqualToString:@"请选择体重"]) {
        kShowError(@"请选择体重");
        return ;
    }
    if ([self.BWHLabel.text isEqualToString:@"请选择三围"]) {
        kShowError(@"请选择三围");
        return ;
    }
    if ([self.shoesLabel.text isEqualToString:@"请选择鞋码"]) {
        kShowError(@"请选择鞋码");
        return ;
    }
    if ([self.sizeLabel.text isEqualToString:@"请选择尺码"]) {
        kShowError(@"请选择身高");
        return ;
    }
    
    [self requestSubmitUserInfoData];
}

- (void)handleWindowAction {
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint point = self.bwhPickView.center;
        point.y = point.y + kScreenWidth*0.8;
        self.bwhPickView.center = point;
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self.bwhPickView removeFromSuperview];
        self.bwhPickView = nil;
        self.bgView = nil;
    }];
}



#pragma mark ----------------- 网络请求 ---------------
/// 上传头像
-(void)requestUpDataPhoto:(UIImage *)image {
    [self showProgressHUDWithTitle:@"上传中~"];
    [LHNetworkManager uploadPOST:kUploadImage parameters:nil consImage:image success:^(id responObject) {
        NSLog(@"%@", responObject);
        if ([responObject[@"errorCode"] integerValue] == 200) {
            self.iconUrl = [NSString stringWithFormat:@"%@", responObject[@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideProgressHUD];
                [MBProgressHUD showSuccess:@"上传成功~"];
                self.iconImageView.image = image;
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"上传失败"];
            });
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)requestSubmitUserInfoData {
    NSMutableDictionary *aDic = [NSMutableDictionary new];
    [aDic setValue:self.chest forKey:@"chest"];
    [aDic setValue:self.waist forKey:@"waist"];
    [aDic setValue:self.hip forKey:@"ass"];
    [aDic setValue:self.iconUrl forKey:@"head_url"];
    [aDic setValue:self.weightLabel.text forKey:@"weigh"];
    [aDic setValue:self.heightLabel.text forKey:@"height"];
    [aDic setValue:self.sizeLabel.text forKey:@"size"];
    [aDic setValue:self.nickNameTF.text forKey:@"nick_name"];
    [aDic setValue:self.shoesLabel.text forKey:@"shose"];
    [aDic setValue:(NSString *)kUser_id forKey:@"id"];

    [LHNetworkManager PostWithUrl:kUpdateUserInfo parameter:aDic success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            
            [LHUserInfoManager cleanUserInfo];
            LHUserInfoModel *model = [[LHUserInfoModel alloc] init];
            NSDictionary *dic = reponseObject[@"data"];
            [model setValuesForKeysWithDictionary:dic];
            [LHUserInfoManager saveUserInfoWithModel:model];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideProgressHUD];
                [MBProgressHUD showSuccess:@"修改成功~"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInfoSuccess" object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                });
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"提交失败"];
            });
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)configureData {
    LHUserInfoModel *model = [LHUserInfoManager getUserInfo];
    if (model.head_url) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.head_url] placeholderImage:[UIImage imageNamed:@""]];
    }
    self.nickNameTF.text = model.nick_name;
    if (model.height) {
        if ([model.height hasSuffix:@"CM"]) {
            self.heightLabel.text = [NSString stringWithFormat:@"%@", model.height];
        } else {
            self.heightLabel.text = [NSString stringWithFormat:@"%@CM", model.height];
        }
        self.heightLabel.textColor = [UIColor blackColor];
    }
   
    if (model.weigh) {
        if ([model.weigh hasSuffix:@"KG"]) {
            self.weightLabel.text = [NSString stringWithFormat:@"%@", model.weigh];
        } else {
            self.weightLabel.text = [NSString stringWithFormat:@"%@KG", model.weigh];
        }
        self.weightLabel.textColor = [UIColor blackColor];
    }
    
    if (model.waist || model.chest || model.ass) {
        if ([model.waist hasSuffix:@"CM"] || [model.ass hasSuffix:@"CM"] || [model.chest hasSuffix:@"CM"]) {
            self.BWHLabel.text = [NSString stringWithFormat:@"胸围%@-腰围%@-臀围%@", model.chest, model.waist, model.ass];
        } else {
            self.BWHLabel.text = [NSString stringWithFormat:@"胸围%@CM-腰围%@CM-臀围%@CM", model.chest, model.waist, model.ass];
        }
         self.BWHLabel.textColor = [UIColor blackColor];
    }
    if (model.shose) {
        self.shoesLabel.text = [NSString stringWithFormat:@"%@", model.shose];
        self.shoesLabel.textColor = [UIColor blackColor];
    }
    if (model.size) {
        self.sizeLabel.text = model.size;
        self.sizeLabel.textColor = [UIColor blackColor];
    }
    
    self.chest = model.chest;
    self.hip = model.ass;
    self.waist = model.waist;
    self.iconUrl = model.head_url;
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
