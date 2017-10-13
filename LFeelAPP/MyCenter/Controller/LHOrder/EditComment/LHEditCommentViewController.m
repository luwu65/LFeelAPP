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

@property (nonatomic, strong) LHAddCommentView *firstView;
@property (nonatomic, strong) LHAddCommentView *secondView;
@property (nonatomic, strong) LHAddCommentView *thirdView;

@property (nonatomic, strong) UIScrollView *bgScrollView;


@end

@implementation LHEditCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kColor(245, 245, 245);
    [self setHBK_NavigationBar];
    [self setUI];
    
    [self configureDataWithModel:self.orderModel];
}

#pragma mark ---------------------  UI -------------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"评价" backAction:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    } rightFirst:@"提交" rightFirstBtnAction:^{
        
        
    }];
    self.hbk_navgationBar.rightFirstBtn.frame = CGRectMake(kScreenWidth-60, 27, 50, 30);
}

- (void)setUI {
    self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    if (self.orderModel.products.count == 1) {
        self.bgScrollView.contentSize = CGSizeMake(kScreenWidth, HeightEditView);
        [self setFirstSubView];
    } else if (self.orderModel.products.count == 2) {
        self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
        self.bgScrollView.contentSize = CGSizeMake(kScreenWidth, HeightEditView*2);
        [self.view addSubview:self.bgScrollView];
        [self setFirstSubView];
        [self setSecondSubView];
    } else if (self.orderModel.products.count == 3) {
        self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
        self.bgScrollView.contentSize = CGSizeMake(kScreenWidth, HeightEditView*3);
        [self setFirstSubView];
        [self setSecondSubView];
    }
    [self.view addSubview:self.bgScrollView];
}


- (void)setFirstSubView {
    self.firstView = [LHAddCommentView creatView];
    self.firstView.frame = CGRectMake(0, 0, kScreenWidth, (kScreenWidth-kFit(40))/3+kFit(140));
    kWeakSelf(self);
    self.firstView.ClickBlock = ^{
        kStrongSelf(self);
        [self showAlertSheetViewWithTitle:nil first:@"拍照" second:@"从相册选择照片" no:@"取消" firstHandler:^(UIAlertAction * _Nullable action) {
            [LHImagePickerViewController showInViewController:self libraryType:(LHImagePickerMediaTypeCamera) allowEdit:YES complete:^(UIImage *image) {
                [self.firstView.photoArray addObject: image];
                [self.firstView updateLayout];
            }];
        } secondHandler:^(UIAlertAction * _Nullable action) {
            
            [self photoAlbumwithLHAddCommentView:self.firstView];
            
        } noHandler:^(UIAlertAction * _Nullable action) {
            
        }];
    };
    [self.bgScrollView addSubview:self.firstView];
}

- (void)setSecondSubView {
    self.secondView = [LHAddCommentView creatView];
    self.secondView.frame = CGRectMake(0, (kScreenWidth-kFit(40))/3+kFit(140)+10, kScreenWidth, (kScreenWidth-kFit(40))/3+kFit(140));
    kWeakSelf(self);
    self.secondView.ClickBlock = ^{
        kStrongSelf(self);
         [self showAlertSheetViewWithTitle:nil first:@"拍照" second:@"从相册选择照片" no:@"取消" firstHandler:^(UIAlertAction * _Nullable action) {
             [LHImagePickerViewController showInViewController:self libraryType:(LHImagePickerMediaTypeCamera) allowEdit:YES complete:^(UIImage *image) {
                 [self.secondView.photoArray addObject: image];
                 [self.secondView updateLayout];
             }];
             
         } secondHandler:^(UIAlertAction * _Nullable action) {
             [self photoAlbumwithLHAddCommentView:self.secondView];
         } noHandler:^(UIAlertAction * _Nullable action) {
             
         }];
    };
    [self.bgScrollView addSubview:self.secondView];
}

- (void)setThirdSubView {
    self.thirdView = [LHAddCommentView creatView];
    self.thirdView.frame = CGRectMake(0, (kScreenWidth-kFit(40))/3+kFit(140)+20, kScreenWidth, (kScreenWidth-kFit(40))/3+kFit(140));
    kWeakSelf(self);
    self.thirdView.ClickBlock = ^{
        kStrongSelf(self);
        [self showAlertSheetViewWithTitle:nil first:@"拍照" second:@"从相册选择照片" no:@"取消" firstHandler:^(UIAlertAction * _Nullable action) {
            [LHImagePickerViewController showInViewController:self libraryType:(LHImagePickerMediaTypeCamera) allowEdit:YES complete:^(UIImage *image) {
                [self.thirdView.photoArray addObject: image];
                [self.thirdView updateLayout];
            }];
            
        } secondHandler:^(UIAlertAction * _Nullable action) {
            [self photoAlbumwithLHAddCommentView:self.secondView];
        } noHandler:^(UIAlertAction * _Nullable action) {
            
        }];
    };
    [self.bgScrollView addSubview:self.thirdView];
}


#pragma mark ----------------------- Action ------------------------
- (void)photoAlbumwithLHAddCommentView:(LHAddCommentView *)commentView {
    kWeakSelf(self);
    [[LHPhotoPickManager sharedManager] getImagesInView:self maxCount:3 - commentView.photoArray.count successBlock:^(NSMutableArray<UIImage *> *images) {
        kStrongSelf(self);
        if (commentView.photoArray.count != 0) {
            [commentView.photoArray addObjectsFromArray:images];
            NSLog(@"------- >>>> %ld", self.secondView.photoArray.count);
            [commentView updateLayout];
        } else {
            commentView.photoArray = [NSMutableArray arrayWithArray:images];
        }
    }];
}


- (void)configureDataWithModel:(LHOrderModel *)model {
    if (model.products.count == 1) {
        LHOrderProductModel *pModel = model.products.firstObject;
        [self.firstView.goodsImageView sd_setImageWithURL:kURL(pModel.url) placeholderImage:kImage(@"")];
    } else if (model.products.count == 2) {
        LHOrderProductModel *aModel = model.products.firstObject;
        [self.firstView.goodsImageView sd_setImageWithURL:kURL(aModel.url) placeholderImage:kImage(@"")];
        
        LHOrderProductModel *bModel = model.products.lastObject;
        [self.secondView.goodsImageView sd_setImageWithURL:kURL(bModel.url) placeholderImage:kImage(@"")];
    } else if (model.products.count == 3) {
        LHOrderProductModel *aModel = model.products[0];
        [self.firstView.goodsImageView sd_setImageWithURL:kURL(aModel.url) placeholderImage:kImage(@"")];
        
        LHOrderProductModel *bModel = model.products[1];
        [self.secondView.goodsImageView sd_setImageWithURL:kURL(bModel.url) placeholderImage:kImage(@"")];
        
        LHOrderProductModel *cModel = model.products[2];
        [self.secondView.goodsImageView sd_setImageWithURL:kURL(cModel.url) placeholderImage:kImage(@"")];
    }
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
