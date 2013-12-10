//
//  CircularPorgressBarView.m
//  CircularProgressBar
//
//  Created by Mykola Denysyuk on 12/9/13.
//  Copyright (c) 2013 Mykola Denysyuk. All rights reserved.
//

#define SQR(A) A*A

#define DEFAULT_POINT_SIZE CGSizeMake(10, 10)
#define DEFAULT_POINT_COLOR UIColor.yellowColor
#define DEFAULT_POINT_TRACK_COLOR UIColor.greenColor;
#define DEFAULT_COUNT_COLOR [UIColor blackColor]
#define DEFAULT_COUNT_FONT [UIFont systemFontOfSize:20]
#define DEFAULT_UNITS @"units"
#define DEFAULT_UNITS_COLOR [UIColor blackColor]
#define DEFAULT_UNITS_FONT [UIFont systemFontOfSize:10]

#import "CircularPorgressBarView.h"

@implementation CircularPorgressBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blueColor];
        
        _titleLabel = [UILabel new];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _pointSize = DEFAULT_POINT_SIZE;
        _pointColor = DEFAULT_POINT_COLOR;
        _pointTrackColor = DEFAULT_POINT_TRACK_COLOR;
        
        _countColor = DEFAULT_COUNT_COLOR;
        _countFont = DEFAULT_COUNT_FONT;
        
        _units = DEFAULT_UNITS;
        _unitsColor = DEFAULT_UNITS_COLOR;
        _unitsFont = DEFAULT_UNITS_FONT;
        
        [self addSubview:_titleLabel];
        
        [self applyAttributedString];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    int minSide = MIN(self.frame.size.width, self.frame.size.height);
    int rectSide = sqrt(SQR(minSide)/2);
    _titleLabel.frame = CGRectMake((self.frame.size.width - rectSide)/2, (self.frame.size.height - rectSide)/2, rectSide, rectSide);
}

#pragma mark - Notify changes:

- (void)setPointSize:(CGSize)pointSize
{
    _pointSize = pointSize;
    [self setNeedsDisplay];
}

- (void)setPointColor:(UIColor *)pointColor
{
    _pointColor = pointColor;
    [self setNeedsDisplay];
}

- (void)setPointTrackColor:(UIColor *)pointTrackColor
{
    _pointTrackColor = pointTrackColor;
    [self setNeedsDisplay];
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)setCount:(int)count
{
    _count = count;
    [self applyAttributedString];
}

- (void)setCountColor:(UIColor *)countColor
{
    _countColor = countColor;
    [self applyAttributedString];
}

- (void)setCountFont:(UIFont *)countFont
{
    _countFont = countFont;
    [self applyAttributedString];
}

- (void)setUnits:(NSString *)units
{
    _units = units;
    [self applyAttributedString];
}

- (void)setUnitsFont:(UIFont *)unitsFont
{
    _unitsFont = unitsFont;
    [self applyAttributedString];
}

- (void)setUnitsColor:(UIColor *)unitsColor
{
    _unitsColor = unitsColor;
    [self applyAttributedString];
}

#pragma mark - Helpers:

- (void)applyAttributedString
{
    _titleLabel.font = _unitsFont;
    
    NSString* string = [NSString stringWithFormat:@"%i\n", _count];
    string = _units ? [string stringByAppendingString:_units] : string;
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = [string rangeOfString:[NSString stringWithFormat:@"%i", _count]];
    [attrString addAttribute:NSFontAttributeName value:_countFont range:range];
    
    _titleLabel.attributedText = attrString;
}

#pragma mark - Draw:
- (void)drawRect:(CGRect)rect
{
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    int radius = MIN(self.frame.size.height, self.frame.size.width)/2 - _pointSize.width;
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    for (int i = 0; i < 15; i++) {
        float angle = M_PI*1.5 + 2*M_PI*(i/15.0);
        int x = cos(angle)*radius + center.x;
        int y = sin(angle)*radius + center.y;
        CGRect rect = CGRectMake(x - _pointSize.width/2.0, y - _pointSize.height/2.0, _pointSize.width, _pointSize.height);
        CGContextAddEllipseInRect(context, rect);
        
        UIColor* fillColor = i/15.0 < _progress ? _pointTrackColor : _pointColor;
        
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextFillPath(context);
    }
}

@end
