//
//  LHAccountCenterCell.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/31.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHShoppingCartModel.h"



@interface LHAccountGoodsCell : UITableViewCell



@property (strong, nonatomic) UIImageView *goodsImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *sizeLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *numLabel;


//@property (nonatomic, strong) LHCartGoodsModel *goodsModel;


- (void)reloadDataWithModel:(LHAccountGoodsModel *)goodsModel;





@end

