//
//  AView.m
//  AView
//
//  Created by Mykola Denysyuk on 10/23/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import "AView.h"

@implementation AView

- (void)initialize
{
    [self initializeWithNibName:nil];
}

- (void)initializeWithNibName:(NSString *)nibNameOrNil
{
    nibNameOrNil = nibNameOrNil ? : NSStringFromClass(self.class);
    [[NSBundle mainBundle] loadNibNamed:nibNameOrNil
                                  owner:self
                                options:nil];
    self.contentView.translatesAutoresizingMaskIntoConstraints = YES;
    self.contentView.frame = self.bounds;
    [self addSubview:self.contentView];
    
    [self setNeedsLayout];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    [self.contentView updateConstraints];
}

@end
