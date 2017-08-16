//
//  LHNewGoodsCell.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHNewGoodsModel.h"
@interface LHNewGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



@property (nonatomic, strong) LHCategoryListModel *listModel;














@end
