//
//  ScrollViewDelegate.h
//  Utils
//
//  Created by Mykola Denysyuk on 12/6/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ScrollViewScrollingBlock)(UIScrollView *scrollView);
typedef void(^ScrollViewDraggingWithVelocityToTargetOffsetBlock)(UIScrollView* scrollView, CGPoint velocity, CGPoint * targetOffset);
typedef void(^ScrollViewDraggingBlock)(UIScrollView* scrollView, BOOL willDecelerate);
typedef UIView*(^ScrollViewViewForZoomingBlock)(UIScrollView* scrollView);
typedef void(^ScrollViewZoomingBlock)(UIScrollView* scrollView, UIView* withView, CGFloat atScale);
typedef BOOL(^ScrollViewShouldScrollToTopBlock)(UIScrollView* scrollView);

@interface ScrollViewDelegate : NSObject <UIScrollViewDelegate>

- (id)initWithScrollView:(UIScrollView *)scrollView;
- (void)configureWithScrollView:(UIScrollView *)scrollView;

@property (readonly, nonatomic, setter=configureWithScrollView:) UIScrollView* scrollView;

@property (nonatomic, strong) UIView * defaultZoomingView;
@property (nonatomic, getter=isShouldScrollToTop) BOOL shouldScrollToTop;

@property (nonatomic, copy) ScrollViewScrollingBlock didScrollBlock; // any offset changes
@property (nonatomic, copy) ScrollViewScrollingBlock didZoomBlock; // any zoom scale changes
@property (nonatomic, copy) ScrollViewScrollingBlock willBeginDraggingBlock;// called on start of dragging (may require some time and or distance to move)
@property (nonatomic, copy) ScrollViewDraggingWithVelocityToTargetOffsetBlock willDraggingWithVelocityBlock; // called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
@property (nonatomic, copy) ScrollViewDraggingBlock didEndingWillDecelerateBlock; // called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
@property (nonatomic, copy) ScrollViewScrollingBlock willBeginDecelerating; // called on finger up as we are moving
@property (nonatomic, copy) ScrollViewScrollingBlock didEndDeceleratingBlock; // called when scroll view grinds to a halt
@property (nonatomic, copy) ScrollViewScrollingBlock didEndScrollingAnimation; // called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
@property (nonatomic, copy) ScrollViewViewForZoomingBlock viewForZoomingBlock; // return a view that will be scaled. if delegate returns nil, nothing happens
@property (nonatomic, copy) ScrollViewZoomingBlock willBeginZoomingBlock; // called before the scroll view begins zooming its content
@property (nonatomic, copy) ScrollViewZoomingBlock didEndZoomingBlock; // scale between minimum and maximum. called after any 'bounce' animations
@property (nonatomic, copy) ScrollViewShouldScrollToTopBlock shouldScrollToTopBlock; // return a yes if you want to scroll to the top. if not defined, assumes YES
@property (nonatomic, copy) ScrollViewScrollingBlock didScrollToTopBlock; // called when scrolling animation finished. may be called immediately if already at top

- (void)setDidScrollBlock:(ScrollViewScrollingBlock)didScrollBlock;
- (void)setDidZoomBlock:(ScrollViewScrollingBlock)didZoomBlock;
- (void)setWillBeginDraggingBlock:(ScrollViewScrollingBlock)willBeginDraggingBlock;
- (void)setWillDraggingWithVelocityBlock:(ScrollViewDraggingWithVelocityToTargetOffsetBlock)willDraggingWithVelocityBlock;
- (void)setDidEndingWillDecelerateBlock:(ScrollViewDraggingBlock)didEndingWillDecelerateBlock;
- (void)setWillBeginDecelerating:(ScrollViewScrollingBlock)willBeginDecelerating;
- (void)setDidEndScrollingAnimation:(ScrollViewScrollingBlock)didEndScrollingAnimation;
- (void)setViewForZoomingBlock:(ScrollViewViewForZoomingBlock)viewForZoomingBlock;
- (void)setWillBeginZoomingBlock:(ScrollViewZoomingBlock)willBeginZoomingBlock;
- (void)setDidEndZoomingBlock:(ScrollViewZoomingBlock)didEndZoomingBlock;
- (void)setShouldScrollToTopBlock:(ScrollViewShouldScrollToTopBlock)shouldScrollToTopBlock;
- (void)setDidScrollToTopBlock:(ScrollViewScrollingBlock)didScrollToTopBlock;

@end
