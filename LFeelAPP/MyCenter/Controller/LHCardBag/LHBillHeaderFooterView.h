//
//  LHBillHeaderFooterView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/20.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SelectBtnBlock)();

@interface LHBillHeaderView : UITableViewHeaderFooterView


@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UILabel *orderNumLabel;
@property (nonatomic, strong) UILabel *statusLabel;
- (void)selectAllBtnBlock:(SelectBtnBlock)block;



@end



#pragma mark  ----------------------------> 这是一条淫荡的分界线 <-----------------------------



@interface LHBillFooterView : UITableViewHeaderFooterView



@property (nonatomic, strong) UILabel *allPriceLabel;

@property (nonatomic, strong) UILabel *timeLabel;



@end
