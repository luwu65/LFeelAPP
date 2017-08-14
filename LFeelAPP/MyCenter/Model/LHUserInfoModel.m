//
//  LHUserInfoModel.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/19.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHUserInfoModel.h"
#import <objc/runtime.h>
@implementation LHUserInfoModel




- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_ = value;
    }
}




- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        //归档
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(ivars);
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            //反归档
            id value = [aDecoder decodeObjectForKey:key];
            //设置到成员变量身上
            [self setValue:value forKey:key];
            
        }
        free(ivars);
    }
    return self;
}

//- (void)encodeWithCoder:(NSCoder *)aCoder {
////    [aCoder encodeObject:_user_id forKey:@"user_id"];
////    [aCoder encodeObject:_token forKey:@"token"];
////    [aCoder encodeObject:_username forKey:@"username"];
//
//    
//    
//}
//- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super init]) {
////        _user_id = [aDecoder decodeObjectForKey:@"user_id"];
////        _token = [aDecoder decodeObjectForKey:@"token"];
////        _username = [aDecoder decodeObjectForKey:@"username"];
//    }
//    return self;
//    
//}



















@end
