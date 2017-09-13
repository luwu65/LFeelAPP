//
//  LHBWHPickView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/11.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface LHBWHPickView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *bwhPickView;


@property (nonatomic, copy) void(^CancelBlock)();
@property (nonatomic, copy) void(^SureBlock)(NSString *chest, NSString *waist, NSString *hip);



@end
