//
//  LHAddressModel.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/1.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHAddressModel.h"

@implementation LHAddressModel








- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_ = value;
    }
}




















@end
