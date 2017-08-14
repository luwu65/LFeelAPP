//
//  LHShoppingCartCell.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/14.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHShoppingCartModel.h"

typedef void(^NumberOfChangeBlock)(NSInteger number);
typedef void(^ClickedBlock)(BOOL isClick);

@interface LHShoppingCartCell : UITableViewCell


//宝贝失效显示"失效", 没有失效显示"宝贝已下架"
@property (nonatomic, strong) UIButton *clickBtn;

@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UILabel *titleLabel;
//显示颜色, 尺码等
@property (nonatomic, strong) UILabel *sizeColorLabel;
//如果没下架, 就显示价格, 如果下架了就显示"宝贝已下架"
@property (nonatomic, strong) UILabel *priceLabel;


//宝贝失效了, 隐藏下面三个按钮
@property (nonatomic, strong) UIButton *subBtn;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIButton *addBtn;






@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) BOOL isClick;



@property (nonatomic, copy) NumberOfChangeBlock numberOfAddBlock;
@property (nonatomic, copy) NumberOfChangeBlock numberSubBlock;
@property (nonatomic, copy) ClickedBlock clickBlock;

- (void)numberOfAddBlock:(NumberOfChangeBlock)block;

- (void)numberOfSubBlock:(NumberOfChangeBlock)block;

- (void)clickWithCellBlock:(ClickedBlock)block;




//@property (nonatomic, strong) LHCartGoodsModel *goodsModel;

- (void)reloadDataWithModel:(LHCartGoodsModel *)goodsModel;

























@end
