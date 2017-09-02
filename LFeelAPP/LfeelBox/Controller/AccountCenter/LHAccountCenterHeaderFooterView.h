//
//  LHAccountCenterHeaderFooterView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/31.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickHeaderViewBlock)();

@interface LHAccountCenterHeaderView : UIView

@property (nonatomic, copy) ClickHeaderViewBlock clickHeaderViewBlock;
- (void)clickHeaderViewBlock:(ClickHeaderViewBlock)block;

@property (nonatomic, strong) UIView *noAddressBgView;

@property (nonatomic, strong) UIView *addressBgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, assign) BOOL isUpdateFrame;

@end


#pragma mark  --------------------------------------


typedef void(^SelectedBlock)(UILabel *label);
typedef void(^HandleBlock)();

@interface LHAccountCenterFooterView : UIView

@property (nonatomic, copy) SelectedBlock payTypeBlock;
@property (nonatomic, copy) SelectedBlock cheaperCardBlock;
@property (nonatomic, copy) HandleBlock agreeBlock;

- (void)selectedCheaperCardBlock:(SelectedBlock)block;
- (void)selectedPayTypeBlock:(SelectedBlock)block;
- (void)handleAgreeBlock:(HandleBlock)block;
+ (instancetype)creatView;

//优惠券
@property (weak, nonatomic) IBOutlet UILabel *cheaperCardLabal;

//支付方式
@property (weak, nonatomic) IBOutlet UILabel *payTypeLabel;

//客户留言
@property (weak, nonatomic) IBOutlet UITextField *explainTF;

//共几件商品, 小计多少钱
@property (weak, nonatomic) IBOutlet UILabel *shopAllPriceLabel;

//乐荟商城租赁协议
@property (weak, nonatomic) IBOutlet UILabel *delegateLabel;


@end


#pragma mark  --------------------------------------
@interface LHAccountSectionHeaderView : UIView


@property (nonatomic, strong) UIImageView *storeImageView;
@property (nonatomic, strong) UILabel *titleLabel;


@end















