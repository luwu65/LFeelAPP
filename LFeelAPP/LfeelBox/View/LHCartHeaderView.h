//
//  LHCartHeaderView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/24.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHShoppingCartModel.h"
typedef void(^ClickedBlock)(BOOL isClick);
@interface LHCartHeaderView : UITableViewHeaderFooterView



@property (nonatomic, strong) UIButton *clickBtn;
@property (nonatomic, strong) UIImageView *storeImageView;
@property (nonatomic, strong) UILabel *titleLabel;




@property (nonatomic, copy) ClickedBlock clickBlock;
- (void)clickWithHeaderViewBlock:(ClickedBlock)block;


@property (assign,nonatomic) BOOL isSelect;
@property (copy, nonatomic)  NSString *title;

@end
