//
//  LHShoppingCartModel.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/24.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBaseModel.h"

//-------------------   店铺 model  -------------------
@class LHCartGoodsModel;
@interface LHCartStoreModel : LHBaseModel

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, copy) NSString *id_;
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *sid;
@property (nonatomic, strong) NSMutableArray <LHCartGoodsModel *> *goodsModelArray;


- (void)configerGoodsArrayWithArray:(NSArray *)goodsArray;



@end



//---------------------- 商品model  -------------------
@interface LHCartGoodsModel : LHBaseModel


@property (nonatomic, assign) BOOL isSelect;

@property (copy,nonatomic)NSString *id_;
@property (copy,nonatomic)NSString *realPrice;
@property (copy,nonatomic)NSString *goodsType;

@property (assign,nonatomic)NSInteger count;
@property (copy,nonatomic)NSString *orginalPrice;
@property (copy,nonatomic)NSString *total;
@property (copy,nonatomic)NSString *userId;
@property (copy,nonatomic)NSString *sid;
@property (copy,nonatomic)NSString *goodsName;
@property (copy,nonatomic)NSString *shopId;
@property (copy,nonatomic)NSString *goodsId;
@property (copy,nonatomic)NSString *shopName;
@property (copy,nonatomic)NSString *categoryId;




@end
