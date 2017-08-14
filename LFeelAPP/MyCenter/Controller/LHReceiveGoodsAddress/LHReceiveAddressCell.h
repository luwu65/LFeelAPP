//
//  LHReceiveAddressCell.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/20.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SetDefaultBlock)(UIButton *sender);
typedef void(^EditAddressBlock)(UIButton *sender);
typedef void(^DeleteAddressBlock)(UIButton *sender);
@interface LHReceiveAddressCell : UITableViewCell





@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) UIButton *defaultBtn;

@property (nonatomic, copy) SetDefaultBlock setDefaultBlock;
- (void)setDefaultAddressBlock:(SetDefaultBlock)block;


@property (nonatomic, copy) EditAddressBlock editAddressBlock;
- (void)EditAddressBlock:(EditAddressBlock)block;


@property (nonatomic, copy) DeleteAddressBlock deleteAddressBlock;
- (void)deleteAddressBlock:(DeleteAddressBlock)block;





















@end
