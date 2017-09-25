//
//  LHLeBaiPayView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/22.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>


// 定义没有返回值的block
typedef void (^VoidBlcok)(void);
@interface LHLeBaiView : UIView


@property (nonatomic,   copy) NSString * price;
@property (nonatomic, assign, readonly) NSInteger selectedStage;

- (void)setProtocalBlock:(VoidBlcok)pro nextBlock:(VoidBlcok)next;





@end



#pragma mark  --------------------  LeBaiPayView --------------
@interface LHLeBaiPayView : UIView

@property (nonatomic, weak) IBOutlet UITextField * name;
@property (weak, nonatomic) IBOutlet UITextField *identifyCardID;
@property (weak, nonatomic) IBOutlet UITextField *cardNum;
@property (weak, nonatomic) IBOutlet UITextField *month;
@property (weak, nonatomic) IBOutlet UITextField *year;
@property (weak, nonatomic) IBOutlet UITextField *cnv2;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *verify;
@property (weak, nonatomic) IBOutlet UITextView *remark;
@property (weak, nonatomic) IBOutlet UIButton *sendVerifyBtn;

- (void)setDidSendVerifyBlock:(VoidBlcok)send sureBlock:(VoidBlcok)sure;






@end





#pragma mark  --------------------  LeBaiPayAgainView --------------
@interface LHLeBaiPayAgainView : UIView


///  银行卡列表
//@property (nonatomic,   copy) NSArray<LFCardInfo *> * bankCardList;
//@property (nonatomic, strong, readonly) LFCardInfo * selectedCard;

@property (weak, nonatomic) IBOutlet CustomButton *cardBtn;
@property (weak, nonatomic) IBOutlet UITextField *month;
@property (weak, nonatomic) IBOutlet UITextField *year;
@property (weak, nonatomic) IBOutlet UITextField *cnv2;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *verify;
@property (weak, nonatomic) IBOutlet UITextView *remark;
@property (weak, nonatomic) IBOutlet UIButton *sendVerifyBtn;

- (void)setDidSendVerifyBlock:(VoidBlcok)send sureBlock:(VoidBlcok)sure addNewCardBlock:(VoidBlcok)add;





@end

