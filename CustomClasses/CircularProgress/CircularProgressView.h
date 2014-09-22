//
//  CircularProgressView.h
//  CircularProgress
//
//  Created by Mykola Denysyuk on 9/22/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularProgressView : UIView

@property (nonatomic) UIEdgeInsets contentInsets;
@property (nonatomic) CGFloat progressLineWidth;
@property (nonatomic) UIColor* filledTrackColor;
@property (nonatomic) UIColor* emptyTrackColor;

@property (nonatomic) CGFloat progress;

@end
