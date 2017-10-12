//
//  LHPhotoCommentCell.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/10/11.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHPhotoCommentCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;


@property (nonatomic, copy) void(^DeleteBlock)();




@end
