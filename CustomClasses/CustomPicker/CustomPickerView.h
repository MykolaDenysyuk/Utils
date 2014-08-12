//
//  CustomPickerView.h
//
//
//  Created by Mykola Denysyuk on 8/4/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPickerView : UIControl

@property (readonly, nonatomic) UILabel * titleLabel;
@property (readonly, nonatomic) UIButton * increaseButton;
@property (readonly, nonatomic) UIButton * decreaseButton;
@property (nonatomic) UIColor * tintColor;

/**
 Minimum and maximum values
 */
@property (nonatomic) CGFloat minValue;
@property (nonatomic) CGFloat maxValue;

/**
 Current value will be increased or decreased by 'stepValue'
 */
@property (nonatomic) CGFloat stepValue;

/**
 Current picker value. Displayed value denends on 'stringFormat'
 */
@property (nonatomic) CGFloat currentValue;

/**
 * "%f"    = 3145.559706
 * "%.f"   = 3146
 * "%.1f"  = 3145.6
 * "%.2f"  = 3145.56
 * "%.02f" = 3145.56 // which is equal to "%.2f"
 * "%.3f"  = 3145.560
 * "%.03f" = 3145.560 // which is equal to "%.3f"
 */
@property (nonatomic) NSString * stringFormat;

@end
