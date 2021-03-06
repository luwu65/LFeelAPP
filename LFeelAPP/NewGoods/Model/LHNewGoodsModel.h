//
//  LHNewGoodsModel.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/16.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBaseModel.h"

@interface LHCategoryListModel : LHBaseModel

@property (nonatomic, copy) NSString *parent_id;
@property (nonatomic, copy) NSString *id_;
@property (nonatomic, copy) NSString *category_name;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *IndexOf;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *isrent;
@property (nonatomic, copy) NSString *recommend;

@end




@interface LHCategoryDetailListModel : LHBaseModel

@property (nonatomic, copy) NSString *parent_id;
@property (nonatomic, copy) NSString *id_;
@property (nonatomic, copy) NSString *category_name;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *IndexOf;
@property (nonatomic, copy) NSString *url;

@end


@interface LHGoodsListModel : LHBaseModel


@property (nonatomic, copy) NSString *product_id;
@property (nonatomic, copy) NSString *price_lfeel;
@property (nonatomic, copy) NSString *brand;
@property (nonatomic, copy) NSString *iscollection;
@property (nonatomic, copy) NSString *product_name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *category;



@end



@class LHGoodsSpecDetailModel;
@interface LHGoodsSpecModel : LHBaseModel


@property (nonatomic, copy) NSString *property_key;
@property (nonatomic, strong) NSArray<LHGoodsSpecDetailModel *> *property_value;



@end


@interface LHGoodsSpecDetailModel : LHBaseModel


@property (nonatomic, copy) NSString *property_value_id;
@property (nonatomic, copy) NSString *id_;
@property (nonatomic, copy) NSString *spec_id;
@property (nonatomic, copy) NSString *property_value;
@property (nonatomic, copy) NSString *property_key;




@end


@interface LHGoodsSizeColorModel : LHBaseModel

@property (nonatomic, assign) NSInteger spec_id;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *property_value;
@property (nonatomic, copy) NSString *remain;
@property (nonatomic, copy) NSString *property_value_id;

@end







