//
//  CustomPickerView.m
//  
//
//  Created by Mykola Denysyuk on 8/4/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import "CustomPickerView.h"

@interface CustomPickerView ()
{
    __weak IBOutlet UIButton *_increaseButton;
    __weak IBOutlet UIButton *_decreaseButton;
    __weak IBOutlet UILabel *_titleLabel;
    
}
@property (strong, nonatomic) IBOutlet UIView *contentView;

- (IBAction)buttonAction:(UIButton *)sender;

@end


@implementation CustomPickerView

#pragma mark - Initialization:

- (void)initialize
{
    [[NSBundle mainBundle] loadNibNamed:@"CustomPickerView"
                                  owner:self
                                options:nil];
    if (!CGRectEqualToRect(self.frame, CGRectZero)) {
        self.contentView.frame = self.bounds;
    }
    [self addSubview:self.contentView];
    
    self.minValue = -FLT_MAX;
    self.maxValue = FLT_MAX;
    self.stringFormat = @"%.f";
    self.stepValue = 1.0f;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

#pragma mark - Setters:

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.contentView.backgroundColor = backgroundColor;
}

- (void)setCurrentValue:(CGFloat)currentValue
{
    NSAssert([self setCurrentValueIfPossible:currentValue], @"[%@] Cannot set value <%f> which not in range (%f;%f)",self,currentValue,self.minValue,self.maxValue);
}

- (BOOL)setCurrentValueIfPossible:(CGFloat)currentValue
{
    if (currentValue >= self.minValue && currentValue <= self.maxValue) {
        _currentValue = currentValue;
        self.titleLabel.text = [NSString stringWithFormat:self.stringFormat, self.currentValue];
        return YES;
    }
    return NO;
}

- (void)setStringFormat:(NSString *)stringFormat
{
    _stringFormat = stringFormat;
    [self setCurrentValueIfPossible:self.currentValue];
}

#pragma mark - Actions:

- (IBAction)buttonAction:(UIButton *)sender {
    BOOL isNeedToSendActionEvent = NO;
    if (sender == self.increaseButton)
        isNeedToSendActionEvent = [self setCurrentValueIfPossible:(self.currentValue + self.stepValue)];
    else
        isNeedToSendActionEvent = [self setCurrentValueIfPossible:(self.currentValue - self.stepValue)];
    
    if (isNeedToSendActionEvent) [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
