//
//  LHCategoryView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/21.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface LHCategoryView : UIView



/**
 分类列表
 */
@property (nonatomic, strong) UICollectionView *categoryCollectionView;


@property (nonatomic, strong) NSMutableArray *categoryListArray;



@property (nonatomic, copy) void(^ClickCategoryBlock)(NSInteger index);





































@end
