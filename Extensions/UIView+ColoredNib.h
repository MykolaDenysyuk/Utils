//
//  UIView+ColoredNib.h
//  Utils
//
//  Created by Mykola Denysyuk on 12/10/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ColoredNib)

@property (nonatomic) NSString * backgroundColorName;

@end


@interface UILabel (ColoredNib)

@property (nonatomic) NSString * textColorName;

@end

@interface UIButton (ColoredNib)

@property (nonatomic) NSString * textColorName;

@end

@interface UITextField (ColoredNib)

@property (nonatomic) NSString * textColorName;

@end