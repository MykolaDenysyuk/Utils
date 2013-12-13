//
//  ProgressIndicator.m
//  CircularProgressBar
//
//  Created by Mykola Denysyuk on 12/13/13.
//  Copyright (c) 2013 Mykola Denysyuk. All rights reserved.
//

#define MAX_EVENTS_COUNT 10 // current iOS7 UIControlState enum include only 6 states, use 10 to reserve

#import "ProgressIndicator.h"
#import <QuartzCore/QuartzCore.h>

@implementation ProgressIndicator
{
    NSMutableArray* _buttons;
    NSMutableArray* _labels;
    UIView* _line;
    
    NSMutableDictionary* _indicatorFonts;
    NSMutableDictionary* _indicatorBorderColors;
    NSMutableDictionary* _indicatorBackgroundColors;
    NSMutableDictionary* _indicatorTitleColors;
    NSMutableDictionary* _captionFonts;
    NSMutableDictionary* _captionColor;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _buttons = [NSMutableArray new];
        _labels = [NSMutableArray new];
        _line = [UIView new];
        _line.tag = NSNotFound;
        [self addSubview:_line];
        
        _itemSize = CGSizeMake(30, 30);
        _contentInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        
        [self setLineColor:[UIColor grayColor]];
    }
    return self;
}

+ (ProgressIndicator *)progressIndicatorWithFrame:(CGRect)frame andItemsCaption:(NSArray *)itemsCaption
{
    ProgressIndicator* indicator = [[ProgressIndicator alloc] initWithFrame:frame];
    indicator.itemsCaption = itemsCaption;
    return indicator;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self customLayoutSubviews];
}

- (void)customLayoutSubviews
{
    CGRect frame = self.bounds;
    
    int areaLength = frame.size.width - _contentInsets.left - _contentInsets.right - _itemSize.width;
    int beginX = _contentInsets.left + _itemSize.width/2;
    int between = areaLength/MAX(_numberOfItems-1, 1);
    
    for (int i = 0; i < _numberOfItems; i++) {
        UIButton* button = _buttons[i];
        button.frame = CGRectMake(0, 0, _itemSize.width, _itemSize.height);
        button.layer.cornerRadius = _itemSize.width/2;
        button.center = CGPointMake(beginX + between * i, _contentInsets.top + _itemSize.height/2);
        
        if (_labels.count > i) {
            UILabel* label = _labels[i];
            label.center = CGPointMake(button.center.x, button.frame.origin.y + button.frame.size.height + label.frame.size.height/2 + 1);
        }
    }
    
    _line.frame = CGRectMake(beginX, _contentInsets.top + _itemSize.height/2, areaLength, 1);
    [self sendSubviewToBack:_line];
}

#pragma mark - Setter:

- (void)setNumberOfItems:(NSUInteger)numberOfItems
{
    _numberOfItems = numberOfItems;
    [self add:numberOfItems buttonsWitCaptions:nil];
}

- (void)setItemsCaption:(NSArray *)itemsCaption
{
    _numberOfItems = itemsCaption.count;
    _itemsCaption = itemsCaption;
    
    [self add:itemsCaption.count buttonsWitCaptions:itemsCaption];
}

- (void)setSelectedItemAtIndex:(NSUInteger)selectedItemAtIndex
{
    _selectedItemAtIndex = selectedItemAtIndex;
    
    UIColor* indicatorBorderColor = [_indicatorBorderColors valueForKey:@(UIControlStateNormal).stringValue];
    UIFont* indicatorFont = [_indicatorFonts valueForKey:@(UIControlStateNormal).stringValue];
    UIColor* indicatorBackgroundColor = [_indicatorBackgroundColors valueForKey:@(UIControlStateNormal).stringValue];
    UIColor* titleColor = [_indicatorTitleColors valueForKey:@(UIControlStateNormal).stringValue];
    UIColor* captionColor = [_captionColor valueForKey:@(UIControlStateNormal).stringValue];
    UIFont* captionFont = [_captionFonts valueForKey:@(UIControlStateNormal).stringValue];
    
    UIColor* indicatorBorderColorSelected = [_indicatorBorderColors valueForKey:@(UIControlStateSelected).stringValue];
    UIFont* indicatorFontSelected = [_indicatorFonts valueForKey:@(UIControlStateSelected).stringValue];
    UIColor* indicatorBackgroundColorSelected = [_indicatorBackgroundColors valueForKey:@(UIControlStateSelected).stringValue];
    UIColor* titleColorSelected = [_indicatorTitleColors valueForKey:@(UIControlStateSelected).stringValue];
    UIColor* captionColorSelected = [_captionColor valueForKey:@(UIControlStateSelected).stringValue];
    UIFont* captionFontSelected = [_captionFonts valueForKey:@(UIControlStateSelected).stringValue];
    
    for (UIButton* indicator in _buttons) {
        if (indicator.tag == selectedItemAtIndex) {
            indicator.layer.borderColor = indicatorBorderColorSelected ? indicatorBorderColorSelected.CGColor : [UIColor darkGrayColor].CGColor;
            indicator.titleLabel.font = indicatorFontSelected ? indicatorFontSelected : [UIFont boldSystemFontOfSize:12];
            indicator.backgroundColor = indicatorBackgroundColorSelected ? indicatorBackgroundColorSelected : [UIColor darkGrayColor];
            [indicator setTitleColor:titleColorSelected?titleColorSelected:[UIColor whiteColor]
                            forState:UIControlStateNormal];
        }
        else
        {
            indicator.layer.borderColor = indicatorBorderColor ? indicatorBorderColor.CGColor : [UIColor grayColor].CGColor;
            indicator.titleLabel.font = indicatorFont ? indicatorFont : [UIFont systemFontOfSize:12];
            indicator.backgroundColor = indicatorBackgroundColor ? indicatorBackgroundColor : [UIColor whiteColor];
            [indicator setTitleColor:titleColor?titleColor:[UIColor darkGrayColor]
                            forState:UIControlStateNormal];
        }
    }
    
    for (UILabel* caption in _labels) {
        if (caption.tag == selectedItemAtIndex) {
            caption.font = captionFontSelected ? captionFontSelected : [UIFont boldSystemFontOfSize:10];
            caption.textColor = captionColorSelected ? captionColorSelected : [UIColor darkGrayColor];
        }
        else
        {
            caption.font = captionFont ? captionFont : [UIFont systemFontOfSize:10];
            caption.textColor = captionColor ? captionColor : [UIColor grayColor];
        }
        
        caption.text = _itemsCaption[caption.tag];
        [caption sizeToFit];
    }
}

- (void)setLineColor:(UIColor *)lineColor
{
    _line.backgroundColor = lineColor;
}

- (void)setItemSize:(CGSize)itemSize
{
    _itemSize = itemSize;
    [self customLayoutSubviews];
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    _contentInsets = contentInsets;
    [self customLayoutSubviews];
}

#pragma mark - Customize UI

- (void)setIndicatorBorderColor:(UIColor *)color forState:(UIControlState)state
{
    if (_indicatorBorderColors == nil) {
        _indicatorBorderColors = [NSMutableDictionary dictionaryWithCapacity:MAX_EVENTS_COUNT];
    }
    
    [_indicatorBorderColors setValue:color
                              forKey:@(state).stringValue];
    [self setSelectedItemAtIndex:_selectedItemAtIndex];
}

- (void)setIndicatorBackgroundColor:(UIColor *)color forState:(UIControlState)state
{
    if (_indicatorBackgroundColors == nil) {
        _indicatorBackgroundColors = [NSMutableDictionary dictionaryWithCapacity:MAX_EVENTS_COUNT];
    }
    [_indicatorBackgroundColors setValue:color
                                  forKey:@(state).stringValue];
    [self setSelectedItemAtIndex:_selectedItemAtIndex];
}

- (void)setIndicatorTitleColor:(UIColor *)color forState:(UIControlState)state
{
    if (_indicatorTitleColors == nil) {
        _indicatorTitleColors = [NSMutableDictionary dictionaryWithCapacity:MAX_EVENTS_COUNT];
    }
    [_indicatorTitleColors setValue:color forKey:@(state).stringValue];
    [self setSelectedItemAtIndex:_selectedItemAtIndex];
}

- (void)setIndicatorTitleFont:(UIFont *)font forState:(UIControlState)state
{
    if (_indicatorFonts == nil) {
        _indicatorFonts = [NSMutableDictionary dictionaryWithCapacity:MAX_EVENTS_COUNT];
    }
    [_indicatorFonts setValue:font
                       forKey:@(state).stringValue];
    [self setSelectedItemAtIndex:_selectedItemAtIndex];
}

- (void)setCaptionColor:(UIColor *)color forState:(UIControlState)state
{
    if (_captionColor == nil) {
        _captionColor = [NSMutableDictionary dictionaryWithCapacity:MAX_EVENTS_COUNT];
    }
    [_captionColor setValue:color
                     forKey:@(state).stringValue];
    [self setSelectedItemAtIndex:_selectedItemAtIndex];
}

- (void)setCaptionFont:(UIFont *)font forState:(UIControlState)state
{
    if (_captionFonts == nil) {
        _captionFonts = [NSMutableDictionary dictionaryWithCapacity:MAX_EVENTS_COUNT];
    }
    [_captionFonts setValue:font
                     forKey:@(state).stringValue];
    [self setSelectedItemAtIndex:_selectedItemAtIndex];
}

#pragma mark - Control actions

- (void)didSelectItem:(UIButton *)itemButton
{
    [self setSelectedItemAtIndex:itemButton.tag];
}

#pragma mark - Helpers;

- (void)add:(NSUInteger)numberOfButtons buttonsWitCaptions:(NSArray *)captions
{
    for (UIView* subview in self.subviews) {
        if (subview != _line) {
            [subview removeFromSuperview];
        }
    }
    
    [_buttons removeLastObject];
    [_labels removeLastObject];
    
    _buttons = [NSMutableArray arrayWithCapacity:numberOfButtons];
    if (captions) {
        _labels = [NSMutableArray arrayWithCapacity:numberOfButtons];
    }
    
    for (int i = 0; i < numberOfButtons; i++)
    {
        UIButton* newButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
        newButtonItem.tag = i;
        newButtonItem.layer.borderWidth = 1.0f;
        [newButtonItem setTitle:@(i+1).stringValue forState:UIControlStateNormal];
        [_buttons addObject:newButtonItem];
        [self addSubview:newButtonItem];
        
        [newButtonItem addTarget:self
                          action:@selector(didSelectItem:)
                forControlEvents:UIControlEventTouchUpInside];
        
        if (captions.count > i) {
            UILabel* newCaptionLabel = [UILabel new];
            newCaptionLabel.tag = i;
            newCaptionLabel.backgroundColor = [UIColor clearColor];
            newCaptionLabel.textAlignment = NSTextAlignmentCenter;
            [self insertSubview:newCaptionLabel belowSubview:newButtonItem];
            [_labels addObject:newCaptionLabel];
        }
    }
    
    [self setSelectedItemAtIndex:_selectedItemAtIndex];
    
    [self customLayoutSubviews];
}

@end
