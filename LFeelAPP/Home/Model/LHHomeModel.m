//
//  LHHomeModel.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/10.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHHomeModel.h"

@implementation LHHomeThemesModel



- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_ = value;
    }
}



@end



//--------------------------------------------------------------------------------

@implementation LHHomeThemeGoodsModel


//- (NSMutableArray *)value {
//    if (!_value) {
//        self.value = [NSMutableArray new];
//    }
//    return _value;
//}


@end


//--------------------------------------------------------------------------------

@implementation LHThemeGoodsModel






@end
