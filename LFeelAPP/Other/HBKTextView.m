//
//  HBKTextView.m
//  TextViewPlaceholderDemo
//
//  Created by 黄冰珂 on 2017/3/8.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "HBKTextView.h"

@interface HBKTextView ()

- (void)textChanged:(NSNotification *)notification;

@end

@implementation HBKTextView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self makeView];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self makeView];
    }
    return self;
}

- (void)makeView {
    self.placeHolder = @"";
    self.placeHolderColor = [UIColor lightGrayColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    
}



- (void)textChanged:(NSNotification *)notification {
    if (self.placeHolder.length == 0) {
        return;
    }
    
    if (self.text.length == 0) {
        [self viewWithTag:999].alpha = 1;
    } else {
        [self viewWithTag:999].alpha = 0;
    }
}



- (void)drawRect:(CGRect)rect {
    if (self.placeHolder.length > 0) {
        if (_placeHolderLabel == nil) {
            self.placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, self.bounds.size.width-16, 0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeHolderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        _placeHolderLabel.text = self.placeHolder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    if (self.text.length == 0 && self.placeHolder.length > 0) {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
}




@end
