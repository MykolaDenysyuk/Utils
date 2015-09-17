//
//  UITableView+VisibleSections.h
//  Utils
//
//  Created by Mykola Denysyuk on 9/17/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//
//  http://stackoverflow.com/a/23538021

#import <UIKit/UIKit.h>

@interface UITableView (VisibleSections)
// Returns an array of NSNumbers of the current visible section indexes
- (NSArray *)indexesOfVisibleSections;
// Returns an array of UITableViewHeaderFooterView objects of the current visible section headers
- (NSArray *)visibleSections;
@end