//
//  LHNewGoodsModel.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/16.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHNewGoodsModel.h"

@implementation LHCategoryListModel



- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_ = value;
    }
}



@end


@implementation LHCategoryDetailListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_ = value;
    }
}





@end




@implementation LHGoodsListModel

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    if ([key isEqualToString:@"id"]) {
//        self.id_ = value;
//    }
//}





@end




@implementation LHGoodsSpecModel

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    if ([key isEqualToString:@"id"]) {
//        self.id_ = value;
//    }
//}





@end


@implementation LHGoodsSpecDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_ = value;
    }
}





@end


@implementation LHGoodsSizeColorModel







@end

