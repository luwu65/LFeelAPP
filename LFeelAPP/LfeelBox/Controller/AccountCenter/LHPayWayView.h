//
//  LHPayWayView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/11.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ClickPayWayBlock)(NSInteger index);
@interface LHPayWayView : UIView<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>


@property (nonatomic, copy) ClickPayWayBlock clickPayBlock;
- (void)clickPayWayBlock:(ClickPayWayBlock)block;



@property (nonatomic,strong) UIView *bgView;
@property (nonatomic, strong) UITableView *payTableView;

- (void)remove;

- (void)show;
- (instancetype)initWithIndex:(NSInteger)index;


@end

@interface LHPayWayCell : UITableViewCell


@property (nonatomic, strong) UIImageView *payImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *clickImageView;



@end















