//
//  LHUserInfoViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/20.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHUserInfoViewController.h"
#import "LHUserInfoCell.h"
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

@end

@implementation LHUserInfoViewController
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
    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.height/2;
    self.iconImageView.image = [UIImage imageNamed:@"MyCenter_headerIcon"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setHBK_NavigationBar];
}

#pragma mark ---------------- UI ----------------------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"个人信息" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


- (void)createLineOnePickViewWithArray:(NSArray *)array {
    self.linePickView = [[LHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    self.linePickView.delegate = self;
    self.linePickView.toolbarTextColor = [UIColor blackColor];
    self.linePickView.toolbarBGColor = kColor(245, 245, 245);
    [self.linePickView show];
}

#pragma mark --------------------- LHPickViewDelegate ------------
//选中pickview走的回调
- (void)toobarDonBtnHaveClick:(LHPickView *)pickView resultString:(NSString *)resultString resultIndex:(NSInteger) index {
    if (pickView == self.linePickView) {
        NSLog(@"%@", resultString);
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
    [self createLineOnePickViewWithArray:self.heightArray];
}

//体重
- (IBAction)weightBtn:(UIButton *)sender {
    [self createLineOnePickViewWithArray:self.weightArray];
}

//三围
- (IBAction)bwhBtn:(UIButton *)sender {
    NSLog(@"三围");

}

//鞋码
- (IBAction)shosBtn:(UIButton *)sender {
    [self createLineOnePickViewWithArray:kShoesSize];

}

//尺码
- (IBAction)sizeBtn:(UIButton *)sender {
    [self createLineOnePickViewWithArray:kClothesSize];
}


#pragma mark ----------------- 网络请求 ---------------
/// 上传头像
-(void)requestUpDataPhoto:(UIImage *)image {
    [LHNetworkManager uploadPOST:@"" parameters:@{} consImage:image success:^(id responObject) {
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.iconImageView.image = image;
        });
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
