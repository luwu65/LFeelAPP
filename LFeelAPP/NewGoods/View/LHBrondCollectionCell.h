//
//  LHBrondCollectionCell.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHNewGoodsModel.h"
@interface LHBrondCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;


@property (nonatomic, strong) LHCategoryDetailListModel *listModel;


@end
