//
//  LHCardHeaderView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/19.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickCardHeaderBlock)(BOOL isClick);


@interface LHCardHeaderView : UITableViewHeaderFooterView



@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *openImageView;


@property (nonatomic, assign) BOOL isClick;



- (void)clickCardHeaderBlock:(ClickCardHeaderBlock)block;
























@end
