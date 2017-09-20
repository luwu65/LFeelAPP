//
//  LHPackInfoView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseTypeBlock)();

@interface LHPackInfoView : UIView
/*衣服*/
@property (weak, nonatomic) IBOutlet UIButton *clothesBtn;

/*包包*/
@property (weak, nonatomic) IBOutlet UIButton *bagBtn;
/*配饰*/
@property (weak, nonatomic) IBOutlet UIButton *accBtn;

/*尺码*/
@property (weak, nonatomic) IBOutlet UIButton *sizeBtn;

@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (nonatomic, copy) ChooseTypeBlock clothesBlock;
@property (nonatomic, copy) ChooseTypeBlock shoesBlock;
@property (nonatomic, copy) ChooseTypeBlock bagBlock;
@property (nonatomic, copy) ChooseTypeBlock accBlock;


- (void)ChooseClothesBtnBlock:(ChooseTypeBlock)clothesBlock
                  bagBtnBlock:(ChooseTypeBlock)bagBlock
                  accBtnBlock:(ChooseTypeBlock)accBlock;



- (void)defaultChooseData:(UIButton *)sender sizeStr:(NSString *)sizeStr;


- (void)cancelDefault;



@end















