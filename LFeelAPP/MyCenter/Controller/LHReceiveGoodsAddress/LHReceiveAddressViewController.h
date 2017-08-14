//
//  LHReceiveAddressViewController.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/20.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBaseViewController.h"
#import "LHAddressModel.h"

typedef void(^ClickAddressBlock)(LHAddressModel *model);

@interface LHReceiveAddressViewController : LHBaseViewController



@property (nonatomic, copy) ClickAddressBlock addressBlock;

- (void)clickAddressBlock:(ClickAddressBlock)block;






@end
