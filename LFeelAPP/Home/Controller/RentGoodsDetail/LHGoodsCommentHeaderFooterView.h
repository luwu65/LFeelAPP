//
//  LHGoodsCommentHeaderFooterView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/28.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHGoodsCommentHeaderView : UIView



@property (nonatomic, strong) UILabel *titleLabel;





@end







//----------------------------------------------------------------------------------------------


typedef void(^ClickAllBtnBlock)();
@interface LHGoodsCommentFooterView : UIView


@property (nonatomic, copy) ClickAllBtnBlock clickAllBtn;

@property (nonatomic, strong) UIButton *allCommentBtn;

- (void)clickAllBtn:(ClickAllBtnBlock)block;




@end
