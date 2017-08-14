//
//  LHGoodsDetailModel.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/11.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBaseModel.h"


@interface LHGoodsInfoModel : LHBaseModel

@property (nonatomic, copy) NSString *style;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *price_lfeel;
@property (nonatomic, copy) NSString *collection_times;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *anti_fake;
@property (nonatomic, copy) NSString *suit;
@property (nonatomic, copy) NSString *price_market;
@property (nonatomic, copy) NSString *category_name;
@property (nonatomic, copy) NSString *source_from;
@property (nonatomic, copy) NSString *product_name;
@property (nonatomic, copy) NSString *publish_time;
@property (nonatomic, copy) NSString *rent_times;
@property (nonatomic, copy) NSString *brand_id;
@property (nonatomic, copy) NSString *expiration_date;
@property (nonatomic, copy) NSString *make_in;
@property (nonatomic, copy) NSString *brandName;
@property (nonatomic, copy) NSString *shopname;
@property (nonatomic, copy) NSString *id_;
@property (nonatomic, copy) NSString *season;
@property (nonatomic, copy) NSString *product_no;
@property (nonatomic, copy) NSString *buy_times;
@property (nonatomic, copy) NSString *remain;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *category_id;
@property (nonatomic, copy) NSString *shop_id;

@end


@interface LHGoodsPropertyModel : LHBaseModel

@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *property_key;
@property (nonatomic, copy) NSString *property_value;
@property (nonatomic, copy) NSString *id_;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *property_id;
@property (nonatomic, copy) NSString *property_value_id;


@end


@interface LHGoodsCommentModel : LHBaseModel







@end












