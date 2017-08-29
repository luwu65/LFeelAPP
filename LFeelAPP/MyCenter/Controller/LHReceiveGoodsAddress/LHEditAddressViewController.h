//
//  LHEditAddressViewController.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/20.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBaseViewController.h"
#import "LHAddressModel.h"
@interface LHEditAddressViewController : LHBaseViewController



//地址
@property (nonatomic, strong) LHAddressModel *addressModel;


@property (nonatomic, copy) void (^SubmitBlock)();





















@end
