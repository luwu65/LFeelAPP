//
//  LHDraggableCardContainer.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/27.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHDraggableCardContainer;

typedef NS_OPTIONS(NSInteger, LHDraggableDirection) {
    LHDraggableDirectionDefault     = 0,
    LHDraggableDirectionLeft        = 1 << 0,
    LHDraggableDirectionRight       = 1 << 1,
    LHDraggableDirectionUp          = 1 << 2,
    LHDraggableDirectionDown        = 1 << 3
};


@protocol LHDraggableCardContainerDataSource <NSObject>

- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index;
- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index;

@end

@protocol LHDraggableCardContainerDelegate <NSObject>

- (void)cardContainerView:(LHDraggableCardContainer *)cardContainerView
    didEndDraggingAtIndex:(NSInteger)index
            draggableView:(UIView *)draggableView
       draggableDirection:(LHDraggableDirection)draggableDirection;

@optional
- (void)cardContainerViewDidCompleteAll:(LHDraggableCardContainer *)container;

- (void)cardContainerView:(LHDraggableCardContainer *)cardContainerView
         didSelectAtIndex:(NSInteger)index
            draggableView:(UIView *)draggableView;

- (void)cardContainderView:(LHDraggableCardContainer *)cardContainderView updatePositionWithDraggableView:(UIView *)draggableView draggableDirection:(LHDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio;

@end

@interface LHDraggableCardContainer : UIView

/**
 *  default is YSLDraggableDirectionLeft | YSLDraggableDirectionRight
 */
@property (nonatomic, assign) LHDraggableDirection canDraggableDirection;
@property (nonatomic, weak) id <LHDraggableCardContainerDataSource> dataSource;
@property (nonatomic, weak) id <LHDraggableCardContainerDelegate> delegate;

/**
 *  reloads everything from scratch. redisplays card.
 */
- (void)reloadCardContainer;

- (void)movePositionWithDirection:(LHDraggableDirection)direction isAutomatic:(BOOL)isAutomatic;
- (void)movePositionWithDirection:(LHDraggableDirection)direction isAutomatic:(BOOL)isAutomatic undoHandler:(void (^)())undoHandler;

- (UIView *)getCurrentView;


@end
