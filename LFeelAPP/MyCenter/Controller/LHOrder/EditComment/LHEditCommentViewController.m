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

#define HeightEditView      (kScreenWidth-kFit(40))/3+kFit(140)

@interface LHEditCommentViewController ()

@property (nonatomic, strong) UIScrollView *bgScrollView;

@end

@implementation LHEditCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kColor(245, 245, 245);
    [self setHBK_NavigationBar];
    [self setUI];
    
//    [self configureDataWithModel:self.orderModel];
}

#pragma mark ---------------------  UI -------------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"评价" backAction:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    } rightFirst:@"提交" rightFirstBtnAction:^{
        for (int i = 0; i < self.orderModel.products.count; i ++) {
            LHAddCommentView *addView = (LHAddCommentView *)[self.view viewWithTag:5000 + i];
            NSLog(@"%@", addView.commentTextView.text);
        }
        
    }];
    self.hbk_navgationBar.rightFirstBtn.frame = CGRectMake(kScreenWidth-60, 27, 50, 30);
}

- (void)setUI {
    self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.bgScrollView.contentSize = CGSizeMake(kScreenWidth, (HeightEditView + 20)* self.orderModel.products.count);
    [self.view addSubview:self.bgScrollView];

    for (int i = 0; i < self.orderModel.products.count; i++) {
        NSLog(@"%.2lf------------%d", 20 + 20*i + ((kScreenWidth-kFit(40))/3+kFit(140))*i, i);
        LHOrderProductModel *model = self.orderModel.products[i];
        LHAddCommentView *commentView = [LHAddCommentView creatView];
        commentView.tag = 5000 + i;
        commentView.frame = CGRectMake(0, 20 + 20*i + ((kScreenWidth-kFit(40))/3+kFit(140))*i, kScreenWidth, HeightEditView);
        [commentView.goodsImageView sd_setImageWithURL:kURL(model.url) placeholderImage:kImage(@"")];
        kWeakSelf(self);
        commentView.ClickBlock = ^{
            NSLog(@"点击了%d", i);
            kStrongSelf(self);
            [self showAlertSheetViewWithTitle:nil first:@"拍照" second:@"从相册中选择" no:@"取消" firstHandler:^(UIAlertAction * _Nullable action) {
                [LHImagePickerViewController showInViewController:self libraryType:(LHImagePickerMediaTypeCamera) allowEdit:YES complete:^(UIImage *image) {
//                    [self requestUpDataPhoto:image];
                    
                }];
            } secondHandler:^(UIAlertAction * _Nullable action) {
                LHAddCommentView *comView = [self.view viewWithTag:5000+i];
                [self photoAlbumwithLHAddCommentView:comView];
            } noHandler:^(UIAlertAction * _Nullable action) {
                
            }];
        };
        [self.bgScrollView addSubview:commentView];
    }   
}




#pragma mark ----------------------- Action ------------------------
- (void)photoAlbumwithLHAddCommentView:(LHAddCommentView *)commentView {
//    kWeakSelf(self);
    [[LHPhotoPickManager sharedManager] getImagesInView:self maxCount:3 - commentView.photoArray.count successBlock:^(NSMutableArray<UIImage *> *images) {
//        kStrongSelf(self);
        if (commentView.photoArray.count != 0) {
            [commentView.photoArray addObjectsFromArray:images];
//            NSLog(@"------- >>>> %ld", self.secondView.photoArray.count);
            [commentView updateLayout];
        } else {
            commentView.photoArray = [NSMutableArray arrayWithArray:images];
        }
    }];
}





#pragma mark ------------------------ 网路请求 ---------------------

- (void)requestDataSubmitCommentWithModel:(LHOrderProductModel *)model {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:model.product_id forKey:@"product_id"];
    [dic setValue:@"" forKey:@"comment"];
    [dic setValue:@"" forKey:@"comment_pic_id0"];
    
    
    [LHNetworkManager PostWithUrl:kAddCommentUrl parameter:dic success:^(id reponseObject) {
       
        
        
    } failure:^(NSError *error) {
        
    }];
}
// 上传图片
-(void)requestUpDataPhoto:(UIImage *)image {
    [self showProgressHUDWithTitle:@"上传中~"];
    [LHNetworkManager uploadPOST:kUploadImageUrl parameters:nil consImage:image imageName:@"image" success:^(id responObject) {
        NSLog(@"%@", responObject);
        if ([responObject[@"errorCode"] integerValue] == 200) {
//            self.iconUrl = [NSString stringWithFormat:@"%@", responObject[@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideProgressHUD];
                [MBProgressHUD showSuccess:@"上传成功~"];
//                self.iconImageView.image = image;
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"上传失败"];
            });
        }
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
