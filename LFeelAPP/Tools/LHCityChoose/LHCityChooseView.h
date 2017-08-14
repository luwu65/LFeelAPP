//
//  LHCityChooseView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/21.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedHandle)(NSString * province, NSString * city, NSString * area);

@interface LHCityChooseView : UIView

@property(nonatomic, copy) SelectedHandle selectedBlock;
@end
