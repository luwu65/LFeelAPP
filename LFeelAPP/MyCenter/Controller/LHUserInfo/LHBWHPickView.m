//
//  LHBWHPickView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/11.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBWHPickView.h"


@interface LHBWHPickView ()

@property (nonatomic, strong) NSMutableArray *dataArray;




@end

@implementation LHBWHPickView
{
    NSString *string;
    NSString *string1;
    NSString *string2;

    
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray new];
        for (int i = 60; i < 120; i++) {
            [self.dataArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _dataArray;
}


//取消
- (IBAction)cancel:(UIBarButtonItem *)sender {
    if (self.CancelBlock) {
        self.CancelBlock();
    }
}

//确定
- (IBAction)sure:(UIBarButtonItem *)sender {
    
    if (!string) {
        string = [self.dataArray objectAtIndex:self.dataArray.count/2];
    }
    if (!string1) {
        string1 = [self.dataArray objectAtIndex:self.dataArray.count/2];
    }
    if (!string2) {
        string2 = [self.dataArray objectAtIndex:self.dataArray.count/2];
    }
    
    if (self.SureBlock) {
        self.SureBlock(string, string1, string2);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
//    [self rm_fitAllConstraint];
    self.bwhPickView.dataSource = self;
    self.bwhPickView.delegate = self;
    [self.bwhPickView selectRow:self.dataArray.count/2 inComponent:0 animated:YES];
    [self.bwhPickView selectRow:self.dataArray.count/2 inComponent:1 animated:YES];
    [self.bwhPickView selectRow:self.dataArray.count/2 inComponent:2 animated:YES];

}

+ (instancetype)creatView {
    return [self creatViewFromNibName:@"LHBWHPickView" atIndex:0];
}


#pragma mark  ---------------
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.dataArray.count;
}

-(NSString * )pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataArray[row];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews) {
        if (singleLine.frame.size.height < 1) {
            singleLine.backgroundColor = HexColorInt32_t(ffffff);
        }
    }
    //设置文字的属性
    UILabel *genderLabel = [UILabel new];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    genderLabel.text = self.dataArray[row];
    genderLabel.textColor = HexColorInt32_t(333333);
    genderLabel.backgroundColor = HexColorInt32_t(fffffff);
    
    return genderLabel;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component { 
    if (component == 0) {
        string = [self.dataArray objectAtIndex:row];
    }else if (component == 1){
        string1 = [self.dataArray objectAtIndex:row];
    }else if (component == 2){
        string2 = [self.dataArray objectAtIndex:row];
    }
}












@end
