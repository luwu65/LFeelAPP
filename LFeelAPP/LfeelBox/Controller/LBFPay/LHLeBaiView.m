//
//  LHLeBaiPayView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/22.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHLeBaiView.h"

@interface LHLeBaiView ()<LHPickViewDelegate>


@property (nonatomic, strong) LHPickView *linePickView;

@property (nonatomic, strong) NSArray * titles;

@end

@implementation LHLeBaiView {
    /// 金额
    __weak IBOutlet UILabel *_amount;
    /// 分期期数
    __weak IBOutlet UILabel *_stagesCount;
    /// 分期view
    __weak IBOutlet UIView *_stagesView;
    
    /// 每期
    __weak IBOutlet UILabel *_everyMoney;
    // 手续费
    __weak IBOutlet UILabel *_handlingCharge;
    // 第一次
    __weak IBOutlet UILabel *_firstMoney;
    /// 往后每期
    __weak IBOutlet UILabel *_otherEveryMoney;
    /// 总金额
    __weak IBOutlet UILabel *_totalMoney;
    
    __weak IBOutlet UILabel *_protocal;
    
    void(^_sta)(NSInteger index) ;
    VoidBlcok _proBlock;
    VoidBlcok _nextBlock;
    
}




- (IBAction)LeBaiAction:(UIButton *)sender {
    [self createLineOnePickViewWithArray:@[@"6期", @"12期"]];
}
- (IBAction)nextPageAction:(UIButton *)sender {
    if (_nextBlock) {
        _nextBlock();
    }
}
- (void)setProtocalBlock:(VoidBlcok)pro nextBlock:(VoidBlcok)next {
    _proBlock = pro;
    _nextBlock = next;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self rm_fitAllConstraint];

}

- (void)setPrice:(NSString *)price {
    _price = [price copy];
    double priceDouble = price.doubleValue / 100.0;
    _amount.text = [NSString stringWithFormat:@"￥%.2f", priceDouble];
    
    _totalMoney.text = [_amount.text substringFromIndex:1];
    double every = priceDouble / _selectedStage;
    NSString * p = stringWithDouble(every);
    _everyMoney.text = p;
    _firstMoney.text = p;
    _otherEveryMoney.text = p;
}

- (NSArray *)titles {
    if (!_titles) {
        NSMutableArray * arr = @[].mutableCopy;
        for (int i = 1; i < 3; i++) {
            [arr addObject:[NSString stringWithFormat:@"%zd期", i * 6]];
        }
        _titles = arr.copy;
    }
    return _titles;
}
+ (instancetype)creatView {
    return [self creatViewFromNibName:@"LHLeBaiView" atIndex:0];
}
- (void)createLineOnePickViewWithArray:(NSArray *)array {
    self.linePickView = [[LHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    self.linePickView.delegate = self;
    self.linePickView.toolbarTextColor = [UIColor blackColor];
    self.linePickView.toolbarBGColor = kColor(245, 245, 245);
    [self.linePickView show];
}

#pragma mark --------------------- LHPickViewDelegate ------------
//选中pickview走的回调
- (void)toobarDonBtnHaveClick:(LHPickView *)pickView resultString:(NSString *)resultString resultIndex:(NSInteger) index {
    if (pickView == self.linePickView) {
        NSLog(@"%@", resultString);
        _stagesCount.text = [NSString stringWithFormat:@"%@", resultString];
    }
}


@end


#pragma mark ----------------------------------------------------------------------------------------------------------



@implementation LHLeBaiPayView {
    
    __weak IBOutlet UILabel *_placeHolder;
    VoidBlcok _send;
    VoidBlcok _sure;
    
}

+ (instancetype)creatView {
    return [self creatViewFromNibName:@"LHLeBaiPayView" atIndex:1];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self rm_fitAllConstraint];
    
    @weakify(self);
    [_remark.rac_textSignal subscribeNext:^(NSString * x) {
        @strongify(self);
        self->_placeHolder.hidden = x.length > 0;
    }];

}

- (IBAction)_sure:(id)sender {
    //    SLAssert(_name.hasText, @"请填写持卡人姓名");
    //    SLAssert(_identifyCardID.hasText, @"请填写持卡人身份证号");
    //    SLAssert(_cardNum.hasText, @"请填写信用卡卡号");
    //    SLAssert(_month.hasText, @"请填写月份");
    //    SLAssert(_year.hasText, @"请填写年份");
    //    SLAssert(_cnv2.hasText, @"请输入卡背面最后三位数字");
    //    SLAssert(_phone.hasText, @"请输入预留手机号码");
    //    SLAssert(_phone.text.validateMobile, @"手机号码格式不正确")
    //    SLAssert(_verify.hasText, @"请输入验证码");
    if (_sure) {
        _sure();
    }
}

- (IBAction)_didClickSendVerify:(id)sender {
    //    SLAssert(_phone.hasText, @"请输入预留手机号码");
    //    SLAssert(_phone.text.validateMobile, @"手机号码格式不正确")
    if (_send) {
        _send();
    }
}

- (void)setDidSendVerifyBlock:(VoidBlcok)send sureBlock:(VoidBlcok)sure {
    _send = send; _sure = sure;
}


@end


#pragma mark ----------------------------------------------------------------------------------------------------------


@interface LHLeBaiPayAgainView ()<LHPickViewDelegate>


@property (nonatomic, strong) LHPickView *linePickView;



@end


@implementation LHLeBaiPayAgainView {
    
    __weak IBOutlet UILabel *_placeHolder;
    VoidBlcok _send;
    VoidBlcok _sure;
    VoidBlcok _add;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self rm_fitAllConstraint];
    
    @weakify(self);
    [_remark.rac_textSignal subscribeNext:^(NSString * x) {
        @strongify(self);
        self->_placeHolder.hidden = x.length > 0;
    }];
    
   
}

- (IBAction)_didClickSendVerify:(id)sender {
    //    SLAssert(_phone.hasText, @"请输入预留手机号码");
    //    SLAssert(_phone.text.validateMobile, @"手机号码格式不正确")
//    BLOCK_SAFE_RUN(_send);
    if (_send) {
        _send();
    }
}

- (void)setDidSendVerifyBlock:(VoidBlcok)send sureBlock:(VoidBlcok)sure addNewCardBlock:(VoidBlcok)add {
    _send = send;
    _sure = sure;
    _add = add;
}



+ (instancetype)creatView {
    return [self creatViewFromNibName:@"LHLeBaiPayAgainView" atIndex:2];
}

- (IBAction)_selectCard:(id)sender {


}
















@end
