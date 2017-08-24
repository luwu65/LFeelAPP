//
//  LHDistributionTableView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/24.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHDistributionTableView.h"

@implementation LHDistributionTableView

- (void)didMoveToWindow {
    [super didMoveToWindow];
}

- (void)setContentOffset:(CGPoint)contentOffset {
    if (self.window) {
        [super setContentOffset:contentOffset];
    }
}
@end
