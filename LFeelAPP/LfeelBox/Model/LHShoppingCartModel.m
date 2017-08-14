//
//  LHShoppingCartModel.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/24.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHShoppingCartModel.h"


//-------------------   店铺 model  -------------------
@implementation LHCartStoreModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_ = value;
    }
}


//- (NSMutableArray<LHCartGoodsModel *> *)goodsModelArray {
//    if (!_goodsModelArray) {
//        self.goodsModelArray = [NSMutableArray new];
//    }
//    return _goodsModelArray;
//}


- (void)configerGoodsArrayWithArray:(NSArray *)goodsArray {
    if (goodsArray.count > 0) {
        NSMutableArray *dataArray = [NSMutableArray new];
        for (NSDictionary *dic in goodsArray) {
            LHCartGoodsModel *model = [[LHCartGoodsModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [dataArray addObject:model];
        }
        _goodsModelArray = [dataArray mutableCopy];
    }
}


@end





//---------------------- 商品model  -------------------
@implementation LHCartGoodsModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_ = value;
    }
}






@end
