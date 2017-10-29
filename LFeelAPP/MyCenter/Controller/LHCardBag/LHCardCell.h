//
//  LHCardCell.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/19.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHBankCardModel.h"
@interface LHCardCell : UITableViewCell

@property (nonatomic, strong) UIImageView *bankImageView;
@property (nonatomic, strong) UILabel *bankLabel;
@property (nonatomic, strong) UILabel *bankClassLabel;
@property (nonatomic, strong) UILabel *bankNumLabel;
@property (nonatomic, strong) UIButton *cancelBtn;


@property (nonatomic, strong) LHBankCardModel *bankModel;

@property (nonatomic, copy) void (^DeleteBlock)();

@end




@interface LHAddCardCell : UITableViewCell


@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImageView *addImageView;
@property (nonatomic, strong) UILabel *addLabel;




@end


@interface LHCheaperCardCell : UITableViewCell


@property (nonatomic, strong) UILabel *cardClassLabel;//卡的类型
@property (nonatomic, strong) UILabel *balanceRMBLabel;//余额
@property (nonatomic, strong) UILabel *commentLabel;//优惠券描述
@property (nonatomic, strong) UILabel *allRMBLabel;//总额
@property (nonatomic, strong) UILabel *timeLabel;//有效期


@end

@interface LHBillCardCell : UITableViewCell

@property (nonatomic, strong) UIImageView *billImageView;
@property (nonatomic, strong) UILabel  *titleLabel;




@end

















