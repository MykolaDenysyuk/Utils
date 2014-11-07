//
//  AView.h
//  AView
//
//  Created by Mykola Denysyuk on 10/23/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AView : UIView

@property (readonly, nonatomic) UIView * contentView;

- (void)initialize;
- (void)initializeWithNibName:(NSString *)nibNameOrNil;

@end
