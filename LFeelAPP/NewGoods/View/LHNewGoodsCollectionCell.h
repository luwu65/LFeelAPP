//
//  LHNewGoodsCollectionCell.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHNewGoodsModel.h"

typedef void(^CollecitonButtonBlock)(BOOL isClick);

@interface LHNewGoodsCollectionCell : UICollectionViewCell






@property (nonatomic, copy) CollecitonButtonBlock collectionBtnBlock;

@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lfeelPriceLabel;


- (void)handleCollecitonBtnAction:(CollecitonButtonBlock)block;



@property (nonatomic, strong) LHGoodsListModel *listModel;











@end
