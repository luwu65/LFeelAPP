//
//  LHGoodsDetailModel.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/11.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHGoodsDetailModel.h"

@implementation LHGoodsInfoModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_ = value;
    }
}
@end
@implementation LHGoodsPropertyModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_ = value;
    }
}
@end


@implementation LHGoodsCommentModel



@end
