//
//  ViewController.m
//  Utils
//
//  Created by Mykola Denysyuk on 11/11/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import "ViewController.h"
#import "SpinViewAnimator.h"

@interface ViewController ()
{
    IBOutlet __weak UIImageView* _imageView;
    IBOutlet SpinViewAnimator * _animator;
    NSArray * _images;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _images = @[@"load1"];
    _imageView.layer.cornerRadius = _imageView.frame.size.width/2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAction:(UIButton *)sender
{
    if (_animator.isAnimating)
    {
        [_animator stopAnimating];
        [sender setTitle:@"Start animation"
                forState:UIControlStateNormal];
    }
    
    else
    {
        [_animator startAnimating];
        [sender setTitle:@"Stop animation"
                forState:UIControlStateNormal];
    }
}

- (IBAction)swipeAction:(UISwipeGestureRecognizer *)sender {
    NSUInteger nextIndex = _imageView.tag+1;
    if (nextIndex>=_images.count) {
        nextIndex = 0;
    }
    NSString* imageName = [_images objectAtIndex:nextIndex];
    _imageView.image = [UIImage imageNamed:imageName];
    _imageView.tag = nextIndex;
}

@end
