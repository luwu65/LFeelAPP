//
//  LHGoodsListViewController.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/22.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBaseViewController.h"
#import "LHNewGoodsModel.h"
@interface LHGoodsListViewController : LHBaseViewController

/*
 是否是热门推荐跳转过来的, 如果是热门推荐,请求的时候要加参数, 如果是点击分类进来的, 请求的时候拼接分类id 
 recommended 是否推荐 0 --> 不推荐; 1 --> 推荐
 */
@property (nonatomic, copy) NSString *isRecommend;


@property (nonatomic, strong) LHCategoryDetailListModel *listModel;




















@end
