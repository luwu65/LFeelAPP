//
//  LHPhotoGroupView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/9.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>


//typedef void(^ClickPhotoBlock)(NSInteger index);

@interface LHPhotoGroupView : UIView

//@property (nonatomic, copy) ClickPhotoBlock clickPhotoBlock;
//
//- (void)clickPhotoBlock:(ClickPhotoBlock)block;

/*
 缩略图数组
 */
@property (nonatomic, strong) NSArray *picUrlArray;


/*
 原图数组
 */
@property (nonatomic, strong) NSArray *picOrigUrlArray;



- (instancetype)initWithWidth:(CGFloat)width;























@end
