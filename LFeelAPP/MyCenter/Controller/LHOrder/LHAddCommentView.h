//
//  LHAddCommentView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/10/10.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHAddCommentView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet HBKTextView *commentTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *commentCollectionView;

@end
