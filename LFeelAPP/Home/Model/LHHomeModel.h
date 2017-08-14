//
//  LHHomeModel.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/10.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBaseModel.h"

@interface LHHomeThemesModel : LHBaseModel

@property (nonatomic, copy) NSString *id_;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *theme_name_ch;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *theme_name_en;



@end
//--------------------------------------------------------------------------------

@interface LHHomeThemeGoodsModel : LHBaseModel


@property (nonatomic, copy) NSString *theme_id;
@property (nonatomic, strong) NSMutableArray *value;




@end


//--------------------------------------------------------------------------------

@interface LHThemeGoodsModel : LHBaseModel


@property (nonatomic, copy) NSString *product_id;
@property (nonatomic, copy) NSString *product_url;
@property (nonatomic, copy) NSString *brand_name;



@end








