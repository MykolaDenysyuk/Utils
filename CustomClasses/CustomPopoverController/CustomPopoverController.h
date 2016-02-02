//
//  CustomPopoverController.h
//  MilleniumSpeakerKit
//
//  Created by Mykola Denysyuk on 1/19/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomPopoverControllerDelegate;

/** in iOS8 popoverLayoutMargins seems to be broken. So this is my variant of popover controller with working popoverLayoutMargins */
@interface CustomPopoverController : UIViewController

@property (nonatomic, weak) id<CustomPopoverControllerDelegate> delegate;
@property (readonly, nonatomic) UIViewController * contentController;
@property (nonatomic) UIEdgeInsets popoverLayoutMargins;
@property (readonly) BOOL popoverVisible;
@property (nonatomic) UIColor* borderColor;

- (id)initWithContentController:(UIViewController *)contentController;
- (void)presentFromRect:(CGRect)fromRect inView:(UIView *)inView;

@end

@protocol CustomPopoverControllerDelegate <NSObject>

- (void)popoverDismissed:(CustomPopoverController *)popver;

@end