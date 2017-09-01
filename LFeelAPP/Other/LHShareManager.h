//
//  LHShareManager.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/1.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHShareManager : NSObject



+ (void)shareTitle:(NSString *)title
              desc:(NSString *)desc
               url:(NSString *)url
             image:(id)image
         Plantform:(UMSocialPlatformType)type
        completion:(UMSocialRequestCompletionHandler)completion;














@end
