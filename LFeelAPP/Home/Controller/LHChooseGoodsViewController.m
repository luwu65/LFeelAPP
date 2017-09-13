//
//  LHChooseGoodsViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/20.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHChooseGoodsViewController.h"
#import "LHAddVipViewController.h"
#import "LHGoodsDetailViewController.h"
#import "LHHomeModel.h"
#import "LHDraggableCardContainer.h"
#import "LHDragCardView.h"
#import "LHFloatAnimationButton.h"
#import "LHLoginViewController.h"
@interface LHChooseGoodsViewController ()<LHDraggableCardContainerDelegate, LHDraggableCardContainerDataSource>

@property (nonatomic, strong) UILabel *cTitleLabel;//中文标题
@property (nonatomic, strong) UILabel *eTitleLabel;//英文标题
@property (nonatomic, strong) UIButton *unLikeBtn;//不喜欢
@property (nonatomic, strong) UIButton *likeBtn;//喜欢
@property (nonatomic, strong) UIButton *backBtn;//上一张
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger index;//记录点击滑到第几张了
@property (nonatomic, strong) LHDraggableCardContainer *container;

@property (nonatomic, strong) LHFloatAnimationButton * floatAnimationButton;
@property (nonatomic, strong) NSTimer * timer;

@end

@implementation LHChooseGoodsViewController
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self requestGoodsDataWithUrl];
    [self setUI];
    
    [self setHBK_NavigationBar];
    [self setAnimationButton];
}


#pragma mark  -------------  网络请求  -----------------------------
- (void)requestGoodsDataWithUrl {
    [self showProgressHUD];
    //, @"user_id": kUser_id
    [LHNetworkManager requestForGetWithUrl:kGoodsUrl parameter:@{@"id": self.themesModel.id_} success:^(id reponseObject) {
        NSLog(@"!!!!!!%@", reponseObject);
        if ([kSTR(reponseObject[@"isError"]) isEqualToString:@"0"]) {
            for (NSDictionary *dic in reponseObject[@"data"]) {
                for (NSDictionary *aDic in dic[@"value"]) {
                    //                    NSLog(@"~~~~~~`%@", aDic);
                    LHThemeGoodsModel *model = [[LHThemeGoodsModel alloc] init];
                    [model setValuesForKeysWithDictionary:aDic];
                    [self.dataArray addObject:model];
                }
            }
        }
        
        
        NSLog(@"------------------->>> %ld", self.dataArray.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideProgressHUD];
            if (self.dataArray.count > 0) {
                LHThemeGoodsModel *model = self.dataArray[self.index];
                self.cTitleLabel.text = model.brand_name ? @"" : model.brand_name;
                self.eTitleLabel.text = model.brand_name? @"" : model.brand_name;
            } else {
                [MBProgressHUD showError:@"暂无数据"];
            }
            [_container reloadCardContainer];
        });
    } failure:^(NSError *error) {
        
    }];
}


/**
 收藏
 
 @param model 收藏或取消收藏的模型
 */
- (void)requestCollectGoodsDataWithModel:(LHThemeGoodsModel *)model {
    //type 0 --> 购买的商品; 1 --> 租赁的商品
    [LHNetworkManager PostWithUrl:kCollectionGoodsUrl parameter:@{@"product_id": model.product_id, @"user_id": kUser_id, @"type": @1} success:^(id reponseObject) {
        NSLog(@"%@", reponseObject);
        if ([reponseObject[@"errorCode"] integerValue] == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:@"收藏成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CollectionSuccess" object:nil];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"收藏失败"];
            });
        }
    } failure:^(NSError *error) {
        
    }];
}




#pragma  mark -----------------  Action ------------------

//加入会员
- (void)addVipBtnAction {
    NSLog(@"加入会员");
    LHAddVipViewController *addVipVC = [[LHAddVipViewController alloc] init];
    [self.navigationController pushViewController:addVipVC animated:YES];
}


//不喜欢
- (void)unLikeBtnAction {
//    [self stopAnimation];
    [_container movePositionWithDirection:LHDraggableDirectionLeft isAutomatic:YES];

    _index++;
    if (_index < self.dataArray.count) {
        LHThemeGoodsModel *model = self.dataArray[self.index];
        self.cTitleLabel.text = [model.brand_name isKindOfClass:[NSNull class]] ? @"" : model.brand_name;
        self.eTitleLabel.text = [model.brand_name isKindOfClass:[NSNull class]] ? @"" : model.brand_name;
    }
}
//喜欢
- (void)likeBtnAction {
//    [self startAnimation];
    if ([LHUserInfoManager isLoad]) {
        if (_index < self.dataArray.count) {
            NSLog(@"%ld", _index);
            LHThemeGoodsModel *model = self.dataArray[_index];
            if ([model.iscollection integerValue] == 0) {
                [self requestCollectGoodsDataWithModel:self.dataArray[_index]];
            }
        }
        [_container movePositionWithDirection:LHDraggableDirectionRight isAutomatic:YES];
        
        _index++;
        if (_index < self.dataArray.count) {
            LHThemeGoodsModel *model = self.dataArray[self.index];
            self.cTitleLabel.text = [model.brand_name isKindOfClass:[NSNull class]] ? @"" : model.brand_name;
            self.eTitleLabel.text = [model.brand_name isKindOfClass:[NSNull class]] ? @"" : model.brand_name;
        }
    } else {
        LHLoginViewController *loginVC = [[LHLoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}


//上一张
- (void)backBtnAction {
    
}

/**
 开始动画
 */
- (void)startAnimation {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self
                                                selector:@selector(startHeart) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 结束动画
 */
- (void)stopAnimation {
    [self.timer invalidate];
}

- (void) startHeart {
    [self.floatAnimationButton startRandom];
}



#pragma mark  ---------------------- UI 控件 -----------------
- (void)setUI {
    __weak typeof(self) weakSelf = self;
    _container = [[LHDraggableCardContainer alloc]init];
    _container.frame = self.view.bounds;
    _container.backgroundColor = [UIColor clearColor];
    _container.dataSource = self;
    _container.delegate = self;
    _container.canDraggableDirection = LHDraggableDirectionLeft | LHDraggableDirectionRight | LHDraggableDirectionUp | LHDraggableDirectionDown;
    [self.view addSubview:_container];
    
    //中文标题
    self.cTitleLabel = [[UILabel alloc] init];
    self.cTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_cTitleLabel];
    self.cTitleLabel.font = kFont(14*kRatio);
    [self.cTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(kNavBarHeight+10*kRatio);
        make.left.equalTo(weakSelf.view).offset(20);
        make.right.equalTo(weakSelf.view).offset(-20);
        make.height.mas_equalTo(25*kRatio);
    }];
    //英文标题
    self.eTitleLabel = [[UILabel alloc] init];
    self.eTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.eTitleLabel.font = kFont(14*kRatio);
    self.eTitleLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.eTitleLabel];
    [self.eTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.cTitleLabel.mas_bottom).offset(5*kRatio);
        make.left.equalTo(weakSelf.view).offset(20);
        make.right.equalTo(weakSelf.view).offset(-20);
        make.height.mas_equalTo(25*kRatio);
    }];
    
    //返回上一张
    self.backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:self.backBtn];
    [self.backBtn setImage:[UIImage imageNamed:@"Home_ChooseGoods_Back"] forState:(UIControlStateNormal)];
    [self.backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-20*kRatio);
        make.width.mas_equalTo(50*kRatio);
        make.height.mas_equalTo(50*kRatio);
    }];
    
    //不喜欢
    self.unLikeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:self.unLikeBtn];
    [self.unLikeBtn addTarget:self action:@selector(unLikeBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    //    [self.unLikeBtn setImage:[UIImage imageNamed:@"Home_ChooseGoods_unLike"] forState:(UIControlStateNormal)];
    [self.unLikeBtn setBackgroundImage:[UIImage imageNamed:@"Home_ChooseGoods_unLike"] forState:(UIControlStateNormal)];
    [self.unLikeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-20*kRatio);
        make.right.equalTo(weakSelf.backBtn.mas_left).offset(-50*kRatio);
        make.width.mas_equalTo(50*kRatio);
        make.height.mas_equalTo(50*kRatio);
    }];
    
    //喜欢
    self.likeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:self.likeBtn];
    [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"Home_ChooseGoods_Like"] forState:(UIControlStateNormal)];
    [self.likeBtn addTarget:self action:@selector(likeBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backBtn.mas_right).offset(50*kRatio);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-20*kRatio);
        make.width.mas_equalTo(50*kRatio);
        make.height.mas_equalTo(50*kRatio);
    }];
    
    UIButton *addVipBrn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [addVipBrn setTitle:@"加入会员" forState:(UIControlStateNormal)];
    addVipBrn.titleLabel.font = kFont(15);
    [addVipBrn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    addVipBrn.layer.borderColor = [UIColor redColor].CGColor;
    addVipBrn.layer.borderWidth = 1;
    addVipBrn.layer.cornerRadius = 3;
    addVipBrn.layer.masksToBounds = YES;
    [addVipBrn addTarget:self action:@selector(addVipBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:addVipBrn];
    [addVipBrn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_likeBtn.mas_top).offset(-15*kRatio);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30*kRatio);
    }];
}
- (void)setHBK_NavigationBar {
    //Home_service
    @weakify(self);
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:self.themesModel.theme_name_ch backAction:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    } rightFirst:@"Home_service" rightFirstBtnAction:^{
        @strongify(self);
        NSLog(@"客服");
        ZCProductInfo *productInfo = [ZCProductInfo new];
        //thumbUrl 缩略图地址
        productInfo.thumbUrl = @"";
        //  title 标题 (必填)
        productInfo.title = @"";
        //  desc 摘要
        productInfo.desc = @"";
        //  label 标签
            productInfo.label = @"运动";
        //  页面地址url（必填)
        productInfo.link = @"";
        
        [self openZCServiceWithProduct:productInfo];
    }];
}

- (void)setAnimationButton {
    self.floatAnimationButton = [[LHFloatAnimationButton alloc]init];
    self.floatAnimationButton.frame = CGRectMake((self.view.frame.size.width-45)/2, (self.view.frame.size.height-45)/2, 45, 45);
    self.floatAnimationButton.images = @[[UIImage imageNamed:@"AnimationButton_01"],
                                         [UIImage imageNamed:@"AnimationButton_02"],
                                         [UIImage imageNamed:@"AnimationButton_03"]];
    self.floatAnimationButton.maxLeft = self.view.frame.size.width/2;
    self.floatAnimationButton.maxRight = self.view.frame.size.width/2;
    self.floatAnimationButton.duration = 1;
    
    [self.view addSubview:self.floatAnimationButton];
}


#pragma mark -------------------- YSLDraggableCardContainer DataSource
- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index {
//    NSDictionary *dict = _datas[index];
    LHDragCardView *view = [[LHDragCardView alloc]initWithFrame:CGRectMake(40*kRatio, 64 + 75*kRatio, kScreenWidth - 80*kRatio, kScreenHeight - 64 - 85*kRatio - 130*kRatio)];
    LHThemeGoodsModel *model = self.dataArray[index];
    view.goodsModel = model;
    return view;
}

- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index {
    return self.dataArray.count;
}

#pragma mark ---------------------- YSLDraggableCardContainer Delegate
- (void)cardContainerView:(LHDraggableCardContainer *)cardContainerView didEndDraggingAtIndex:(NSInteger)index draggableView:(UIView *)draggableView draggableDirection:(LHDraggableDirection)draggableDirection {    
    if (draggableDirection == LHDraggableDirectionLeft) {
        NSLog(@"--------------- >>>  左");
        [cardContainerView movePositionWithDirection:draggableDirection isAutomatic:NO];
        _index++;
        if (_index < self.dataArray.count) {
            LHThemeGoodsModel *model = self.dataArray[self.index];
            self.cTitleLabel.text = [model.brand_name isKindOfClass:[NSNull class]] ? @"" : model.brand_name;
            self.eTitleLabel.text = [model.brand_name isKindOfClass:[NSNull class]] ? @"" : model.brand_name;
        }
    }
    
    if (draggableDirection == LHDraggableDirectionRight) {
        NSLog(@"--------------- >>>  右");
        if ([LHUserInfoManager isLoad]) {
            if (_index < self.dataArray.count) {
                NSLog(@"%ld", _index);
                LHThemeGoodsModel *model = self.dataArray[_index];
                if ([model.iscollection integerValue] == 0) {
                    [self requestCollectGoodsDataWithModel:self.dataArray[_index]];
                }
            }//        [self startAnimation];
            [cardContainerView movePositionWithDirection:draggableDirection isAutomatic:NO];
            _index++;
            if (_index < self.dataArray.count) {
                LHThemeGoodsModel *model = self.dataArray[self.index];
                self.cTitleLabel.text = [model.brand_name isKindOfClass:[NSNull class]] ? @"" : model.brand_name;
                self.eTitleLabel.text = [model.brand_name isKindOfClass:[NSNull class]] ? @"" : model.brand_name;
            }
        } else {
            LHLoginViewController *loginVC = [[LHLoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
        }
    }
    if (draggableDirection == LHDraggableDirectionUp) {
        NSLog(@"--------------- >>>  上");
        if ([LHUserInfoManager isLoad]) {
            if (_index < self.dataArray.count) {
                NSLog(@"%ld", _index);
                LHThemeGoodsModel *model = self.dataArray[_index];
                if ([model.iscollection integerValue] == 0) {
                    [self requestCollectGoodsDataWithModel:self.dataArray[_index]];
                }
            }
            [cardContainerView movePositionWithDirection:draggableDirection isAutomatic:NO];
            _index++;
            if (_index < self.dataArray.count) {
                LHThemeGoodsModel *model = self.dataArray[self.index];
                self.cTitleLabel.text = [model.brand_name isKindOfClass:[NSNull class]] ? @"" : model.brand_name;
                self.eTitleLabel.text = [model.brand_name isKindOfClass:[NSNull class]] ? @"" : model.brand_name;
            }
        } else {
            LHLoginViewController *loginVC = [[LHLoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
        }
    }
    if (draggableDirection == LHDraggableDirectionDown) {
        NSLog(@"--------------- >>>  下");
        
        [cardContainerView movePositionWithDirection:draggableDirection isAutomatic:NO];
        _index++;
        if (_index < self.dataArray.count) {
            LHThemeGoodsModel *model = self.dataArray[self.index];
            self.cTitleLabel.text = [model.brand_name isKindOfClass:[NSNull class]] ? @"" : model.brand_name;
            self.eTitleLabel.text = [model.brand_name isKindOfClass:[NSNull class]] ? @"" : model.brand_name;
        }
    }    
}

- (void)cardContainderView:(LHDraggableCardContainer *)cardContainderView updatePositionWithDraggableView:(UIView *)draggableView draggableDirection:(LHDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio {
    LHDragCardView *view = (LHDragCardView *)draggableView;
    if (draggableDirection == LHDraggableDirectionDefault) {
        view.unlikeImageView.alpha = 0;
        view.likeImageView.alpha = 0;
        view.unlikeImageView.alpha = widthRatio*3;
        view.likeImageView.alpha = widthRatio*3;
    }
    if (draggableDirection == LHDraggableDirectionLeft) {
        view.unlikeImageView.alpha = widthRatio*3;
    }
    if (draggableDirection == LHDraggableDirectionRight) {
        view.likeImageView.alpha = widthRatio*3;
    }
    if (draggableDirection == LHDraggableDirectionUp) {
        view.likeImageView.alpha = heightRatio*3;
    }
    if (draggableDirection == LHDraggableDirectionDown) {
        view.unlikeImageView.alpha = heightRatio*3;
    }
}

- (void)cardContainerViewDidCompleteAll:(LHDraggableCardContainer *)container; {
//    [self showAlertViewWithTitle:@"滑完了"];
    self.cTitleLabel.text = @"";
    self.eTitleLabel.text = @"";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [container reloadCardContainer];
    });
}
//点击事件
- (void)cardContainerView:(LHDraggableCardContainer *)cardContainerView didSelectAtIndex:(NSInteger)index draggableView:(UIView *)draggableView {
    LHGoodsDetailViewController *detailVC = [[LHGoodsDetailViewController alloc] init];
    detailVC.goodsModel = self.dataArray[index];
    
    [self.navigationController pushViewController:detailVC animated:YES];
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
