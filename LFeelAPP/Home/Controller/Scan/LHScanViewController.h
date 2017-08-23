//
//  LHScanViewController.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/18.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBaseViewController.h"

@interface LHScanViewController : LHBaseViewController



//判断是从哪个页面跳转过来的
@property (nonatomic, copy) NSString *controller_ID;



@property (nonatomic, copy) void(^ScanContentBlock)(NSString *content);





















@end
