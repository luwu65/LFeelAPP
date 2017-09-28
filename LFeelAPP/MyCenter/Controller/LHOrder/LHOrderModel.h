//
//  LHOrderModel.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/18.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBaseModel.h"

@class LHOrderProductModel;
@interface LHOrderModel : LHBaseModel


@property (nonatomic, copy) NSString *addTime;

@property (nonatomic, copy) NSString *shop_logo;
@property (nonatomic, copy) NSString *order_no;
@property (nonatomic, copy) NSString *shopname;
@property (nonatomic, copy) NSString *shop_id;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *shop_price;
@property (nonatomic, copy) NSString *shop_count;

@property (nonatomic, copy) NSMutableArray<LHOrderProductModel *> *products;

- (void)configerGoodsArrayWithArray:(NSArray *)goodsArray;


@end




@interface LHOrderProductModel : LHBaseModel

@property (nonatomic, copy) NSString *brand_name;
@property (nonatomic, copy) NSString *shopname;
@property (nonatomic, copy) NSArray *property_value;
@property (nonatomic, copy) NSString *product_name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *brand_id;
@property (nonatomic, copy) NSString *product_id;
@property (nonatomic, copy) NSString *spec_id;
@property (nonatomic, copy) NSString *order_no;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *shop_id;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *nick_name;




@end













