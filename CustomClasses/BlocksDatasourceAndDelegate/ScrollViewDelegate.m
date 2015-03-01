//
//  ScrollViewDelegate.m
//  Utils
//
//  Created by Mykola Denysyuk on 12/6/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import "ScrollViewDelegate.h"

@interface ScrollViewDelegate ()
{
    IBOutlet id _nibOutlet;
}
@end

@implementation ScrollViewDelegate

#pragma mark - Lifecycle:

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self configureWithScrollView:_nibOutlet];
}

- (id)initWithScrollView:(UIScrollView *)scrollView
{
    self = [super init];
    if (self) {
        [self configureWithScrollView:scrollView];
    }
    return self;
}

- (void)configureWithScrollView:(UIScrollView *)scrollView
{
}

#pragma mark - ScrollView delegate:

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0){
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if (self.viewForZoomingBlock) {
        return self.viewForZoomingBlock(scrollView);
    }
    return self.defaultZoomingView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    if (self.shouldScrollToTopBlock) {
        return self.shouldScrollToTopBlock(scrollView);
    }
    return self.isShouldScrollToTop;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    
}


@end
