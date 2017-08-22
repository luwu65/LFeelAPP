//
//  LHOrderListTableViewController.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/22.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBaseViewController.h"

@interface LHOrderListTableViewController : UITableViewController



@property (nonatomic, assign) NSInteger type;


///是否需要刷新数据
@property (nonatomic , assign ,getter=isNeedRefresh) BOOL needRefresh;


- (void)reloadData;



























@end
