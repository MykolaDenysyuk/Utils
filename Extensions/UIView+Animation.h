//
//  UIVIew+Animation.h
//
//  Created by Mykola Denysyuk on 2/19/13.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (Animation)

- (void) moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option withCompletion:(void (^)(void))block;
- (void) rotateDown:(float)secs option:(UIViewAnimationOptions)option withCompletion:(void (^)(void))block;
- (void) rotateUp:(float)secs option:(UIViewAnimationOptions)option withCompletion:(void (^)(void))block;
- (void) scale:(float)scale during:(float)duration withOption:(UIViewAnimationOptions)option withCompletion:(void (^)(void))block;
- (void)setWhiteCustomStyle;

- (void)rotateDuration:(float)duration repeat:(BOOL)repeat;

@end
