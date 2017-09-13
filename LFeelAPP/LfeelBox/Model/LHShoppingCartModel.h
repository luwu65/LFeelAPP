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

@property (nonatomic, copy) NSString *shopname;
@property (nonatomic, copy) NSString *shoplogo;
@property (nonatomic, strong) NSMutableArray <LHCartGoodsModel *> *products;


- (void)configerGoodsArrayWithArray:(NSArray *)goodsArray;



@end



//---------------------- 购物车商品model  -------------------
@interface LHCartGoodsModel : LHBaseModel

@property (nonatomic, assign) BOOL isSelect;

@property (copy,nonatomic) NSString *remain;
@property (copy,nonatomic) NSString *shopname;
@property (copy,nonatomic) NSString *brand_name;
@property (copy,nonatomic) NSString *id_;
@property (assign,nonatomic) NSInteger count;
@property (copy,nonatomic) NSString *price_lfeel;
@property (copy,nonatomic) NSString *make_in;
@property (copy,nonatomic) NSString *shop_id;
@property (copy,nonatomic) NSString *user_id;
@property (copy,nonatomic) NSString *url;
@property (copy,nonatomic) NSString *spec_id;
@property (nonatomic, copy) NSString *product_id;

@property (copy,nonatomic) NSString *product_name;
@property (strong,nonatomic) NSMutableArray *property_value;

@property (copy,nonatomic) NSString *shoppingcar_id;


@end

#pragma mark --------------- 结算中心 --------------------
@interface LHAccountGoodsModel : LHBaseModel

@property (nonatomic, copy) NSString *remain;
@property (nonatomic, copy) NSString *brand_name;
@property (nonatomic, copy) NSArray *property_value;
@property (nonatomic, copy) NSString *id_;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *spec_id;
@property (nonatomic, copy) NSString *price_lfeel;
@property (nonatomic, copy) NSString *shop_id;
@property (nonatomic, copy) NSString *product_name;
@property (nonatomic, copy) NSString *product_id;


@end



@class LHAccountGoodsModel;
@interface LHAccountStoreModel : LHBaseModel

@property (nonatomic, copy) NSString *id_;
@property (nonatomic, assign) CGFloat shop_total_money;
@property (nonatomic, copy) NSString *product_count;
@property (nonatomic, copy) NSString *shoplogo;
@property (nonatomic, copy) NSString *shopname;
@property (nonatomic, strong) NSMutableArray <LHAccountGoodsModel *> *products;

- (void)configerGoodsArrayWithArray:(NSArray *)goodsArray;



@end
