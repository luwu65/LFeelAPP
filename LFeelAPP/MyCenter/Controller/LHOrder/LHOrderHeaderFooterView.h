//
//  LHOrderHeaderFooterView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/21.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHOrderHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIImageView *shopImageview;
@property (nonatomic, strong) UILabel *shopLabel;
@property (nonatomic, strong) UILabel *statusLabel;






@end





@interface LHOrderFooterView : UITableViewHeaderFooterView


@property (nonatomic, strong) UILabel *allLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, copy) void (^ClickBtnBlock)(UIButton *sender);
//@property (nonatomic, copy) void (^ClickRightBtnBlock)(UIButton *sender);

@property (nonatomic, strong) UIView *bottomView;


@end




