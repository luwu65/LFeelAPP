//
//  LHLeBaiViewController.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/25.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBaseViewController.h"
#import "LHOrderModel.h"
@interface LHLeBaiViewController : LHBaseViewController

//结束中心跳转, 立即购买, 购买会员, 传的商品信息
@property (nonatomic, strong) NSDictionary *orderDic;


//我的订单里发起支付, 就传订单号, 价格--->> 传订单模型
@property (nonatomic, strong) LHOrderModel *orderModel;




@end
