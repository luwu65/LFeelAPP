//
//  LHBankCardModel.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/25.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBankCardModel.h"

@implementation LHBankCardModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_ = value;
    }
}








@end
