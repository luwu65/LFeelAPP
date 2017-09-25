//
//  LHPayResultsViewController.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/18.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBaseViewController.h"

@interface LHPayResultsViewController : LHBaseViewController



/**
 支付结果状态码
 */
@property (nonatomic, copy) NSString *payResultStr;

//付款完成的订单号等信息
@property (nonatomic, copy) NSDictionary *resultDic;

//付款类型
@property (nonatomic, assign) NSInteger payType;


















@end
