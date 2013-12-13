//
//  ProgressIndicator.h
//  CircularProgressBar
//
//  Created by Mykola Denysyuk on 12/13/13.
//  Copyright (c) 2013 Mykola Denysyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressIndicator : UIControl

@property (nonatomic) NSUInteger numberOfItems;
// OR
@property (nonatomic, strong) NSArray* itemsCaption; // under item text

@property (nonatomic) UIColor* lineColor;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) UIEdgeInsets contentInsets;
@property (nonatomic) NSUInteger selectedItemAtIndex;

// NOTE: available UIControlStateNormal and UIControlStateSelected only!

- (void)setIndicatorBorderColor:(UIColor *)color forState:(UIControlState)state;
- (void)setIndicatorBackgroundColor:(UIColor *)color forState:(UIControlState)state;
- (void)setIndicatorTitleColor:(UIColor *)color forState:(UIControlState)state;
- (void)setIndicatorTitleFont:(UIFont *)font forState:(UIControlState)state;
- (void)setCaptionColor:(UIColor *)color forState:(UIControlState)state;
- (void)setCaptionFont:(UIFont *)font forState:(UIControlState)state;

+ (ProgressIndicator *)progressIndicatorWithFrame:(CGRect)frame andItemsCaption:(NSArray *)itemsCaption;

@end
