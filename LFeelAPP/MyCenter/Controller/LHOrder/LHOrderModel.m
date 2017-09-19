//
//  LHOrderModel.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/18.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHOrderModel.h"

@implementation LHOrderModel







- (void)configerGoodsArrayWithArray:(NSArray *)goodsArray {
    if (goodsArray.count > 0) {
        NSMutableArray *dataArray = [NSMutableArray new];
        for (NSDictionary *dic in goodsArray) {
            LHOrderProductModel *model = [[LHOrderProductModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [dataArray addObject:model];
        }
        _products = [dataArray mutableCopy];
    }
}




@end




@implementation LHOrderProductModel







@end
