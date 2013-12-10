//
//  CircularPorgressBarView.h
//  CircularProgressBar
//
//  Created by Mykola Denysyuk on 12/9/13.
//  Copyright (c) 2013 Mykola Denysyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularPorgressBarView : UIView

@property (readonly) UILabel* titleLabel;
@property (nonatomic) CGSize pointSize;
@property (nonatomic) UIColor* pointColor;
@property (nonatomic) UIColor* pointTrackColor;

@property (nonatomic) UIFont* countFont;
@property (nonatomic) UIFont* unitsFont;
@property (nonatomic) UIColor* countColor;
@property (nonatomic) UIColor* unitsColor;

@property (nonatomic) int count;
@property (nonatomic) NSString* units;
@property (nonatomic) float progress;

@end
