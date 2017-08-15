//
//  LHPackInfoView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHPackInfoChooseView.h"

@implementation LHPackInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    [self rm_fitAllConstraint];
    
    [self.clothesBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    self.clothesBtn.backgroundColor = [UIColor whiteColor];
    self.clothesBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.clothesBtn.layer.borderWidth = 1;
    
    [self.shoesBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    self.shoesBtn.backgroundColor = [UIColor whiteColor];
    self.shoesBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.shoesBtn.layer.borderWidth = 1;
    
    [self.bagBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    self.bagBtn.backgroundColor = [UIColor whiteColor];
    self.bagBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bagBtn.layer.borderWidth = 1;
    
    [self.accBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    self.accBtn.backgroundColor = [UIColor whiteColor];
    self.accBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.accBtn.layer.borderWidth = 1;
    
    [self.sizeBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    [self.sizeBtn setTitle:@"NONE" forState:(UIControlStateNormal)];
}
+ (instancetype)creatView {
    return [self creatViewFromNibName:@"LHPackInfoChooseView" atIndex:0];
}
/*
 衣服
 */
- (IBAction)clothesBtn:(UIButton *)sender {
    [sender setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    sender.backgroundColor = [UIColor redColor];
    sender.layer.borderColor = [UIColor redColor].CGColor;
    
    [self.shoesBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    self.shoesBtn.backgroundColor = [UIColor whiteColor];
    self.shoesBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.shoesBtn.layer.borderWidth = 1;
    
    [self.bagBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    self.bagBtn.backgroundColor = [UIColor whiteColor];
    self.bagBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bagBtn.layer.borderWidth = 1;
    
    [self.accBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    self.accBtn.backgroundColor = [UIColor whiteColor];
    self.accBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.accBtn.layer.borderWidth = 1;
    
    
    if (self.clothesBlock) {
        self.clothesBlock();
    }
}

/*
 鞋子
 */
- (IBAction)shoesBtn:(UIButton *)sender {
    [sender setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    sender.backgroundColor = [UIColor redColor];
    sender.layer.borderColor = [UIColor redColor].CGColor;
    
    [self.clothesBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    self.clothesBtn.backgroundColor = [UIColor whiteColor];
    self.clothesBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.clothesBtn.layer.borderWidth = 1;
    
    [self.bagBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    self.bagBtn.backgroundColor = [UIColor whiteColor];
    self.bagBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bagBtn.layer.borderWidth = 1;
    
    [self.accBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    self.accBtn.backgroundColor = [UIColor whiteColor];
    self.accBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.accBtn.layer.borderWidth = 1;
    
    if (self.shoesBlock) {
        self.shoesBlock();
    }
}
/*
 包包
 */
- (IBAction)bagBtn:(UIButton *)sender {
    
    [sender setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    sender.backgroundColor = [UIColor redColor];
    sender.layer.borderColor = [UIColor redColor].CGColor;
    
    [self.clothesBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    self.clothesBtn.backgroundColor = [UIColor whiteColor];
    self.clothesBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.clothesBtn.layer.borderWidth = 1;
    
    [self.shoesBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    self.shoesBtn.backgroundColor = [UIColor whiteColor];
    self.shoesBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.shoesBtn.layer.borderWidth = 1;
    
    [self.accBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    self.accBtn.backgroundColor = [UIColor whiteColor];
    self.accBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.accBtn.layer.borderWidth = 1;
    
    [self.sizeBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    [self.sizeBtn setTitle:@"NONE" forState:(UIControlStateNormal)];
    
    if (self.bagBlock) {
        self.bagBlock();
    }
}
/*
 配饰
 */
- (IBAction)accBtn:(UIButton *)sender {
    [sender setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    sender.backgroundColor = [UIColor redColor];
    sender.layer.borderColor = [UIColor redColor].CGColor;
    
    [self.clothesBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    self.clothesBtn.backgroundColor = [UIColor whiteColor];
    self.clothesBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.clothesBtn.layer.borderWidth = 1;
    
    [self.shoesBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    self.shoesBtn.backgroundColor = [UIColor whiteColor];
    self.shoesBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.shoesBtn.layer.borderWidth = 1;
    
    [self.bagBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    self.bagBtn.backgroundColor = [UIColor whiteColor];
    self.bagBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bagBtn.layer.borderWidth = 1;

    [self.sizeBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    [self.sizeBtn setTitle:@"NONE" forState:(UIControlStateNormal)];
    
    if (self.accBlock) {
        self.accBlock();
    }
}

//----------------------------------------

- (void)ChooseClothesBtnBlock:(ChooseTypeBlock)clothesBlock
                shoesBtnBlock:(ChooseTypeBlock)shoesBlock
                  bagBtnBlock:(ChooseTypeBlock)bagBlock
                  accBtnBlock:(ChooseTypeBlock)accBlock {
    self.clothesBlock = clothesBlock;
    self.shoesBlock = shoesBlock;
    self.bagBlock = bagBlock;
    self.accBlock = accBlock;
}



@end














