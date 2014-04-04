//
//  UIVIew+Animation.m
//
//  Created by Mykola Denysyuk on 2/19/13.
//

#import "UIVIew+Animation.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Animation)

- (void) moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option withCompletion:(void (^)(void))block
{
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         self.frame = CGRectMake(destination.x,destination.y, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (block && finished) {
                             block();
                         }
                     }];
}

- (void) rotateDown:(float)secs option:(UIViewAnimationOptions)option withCompletion:(void (^)(void))block
{
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, M_PI);
                     }
                     completion:^(BOOL finished) {
                         if (block && finished) {
                             block();
                         }
                     }];
}

- (void)rotateUp:(float)secs option:(UIViewAnimationOptions)option withCompletion:(void (^)(void))block
{
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, 0);
                     }
                     completion:^(BOOL finished) {
                         if (block && finished) {
                             block();
                         }
                     }];
    
}

- (void) scale:(float)scale during:(float)duration withOption:(UIViewAnimationOptions)option withCompletion:(void (^)(void))block
{
    [UIView animateWithDuration:duration delay:0.0 options:option animations:^{
        self.transform = CGAffineTransformScale(self.transform, scale, scale);
    } completion:^(BOOL finished) {
        if (block && finished) {
            block();
        }
    }];
}

- (void)setWhiteCustomStyle{
    self.layer.cornerRadius = 4.0f;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:4.0f].CGPath;
    self.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    self.layer.shadowRadius = 1.0f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.2f;
}



@end
