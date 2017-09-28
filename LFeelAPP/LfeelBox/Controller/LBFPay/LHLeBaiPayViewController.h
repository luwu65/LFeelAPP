//
//  LHLeBaiPayViewController.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/25.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBaseViewController.h"
#import "LHOrderModel.h"



@interface LHLeBaiPayViewController : LHBaseViewController











/**
 期数
 */
@property (nonatomic, assign) NSInteger count;




@property (nonatomic, strong) NSDictionary *orderDic;



//我的订单里发起支付, 就传订单model
@property (nonatomic, strong) LHOrderModel *orderModel;





@end
