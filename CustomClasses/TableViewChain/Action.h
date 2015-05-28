//
//  Action.h
//  
//
//  Created by Mykola Denysyuk on 8/6/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Action;
typedef void(^ActionBlock)(id* object);

@protocol ActionExecuteDelegate <NSObject>
- (void)action:(Action *)action delegateExecute:(id*)parameter;
@end

/**
 Object wrapper for action (via block or via delegation).
 Set 'targetDelegate' or 'actionBlock' to transmit action.
 */
@interface Action : NSObject

@property (readonly, nonatomic, weak) id<ActionExecuteDelegate> targetDelegate;
@property (readonly, nonatomic, copy) ActionBlock actionBlock;

// Factory

+ (instancetype)actionWithTarget:(id<ActionExecuteDelegate>)targetDelegate;
+ (instancetype)actionWithBlock:(ActionBlock)actionBlock;

/**
 Will delegate execution to 'targetDelegate' or perform 'actionBlock' if they exist. Override this method to incapsulate other extended action behavoir
 */
- (void)execute:(id*)parameter;

@end
