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
 Action incapsulate object behavoir. Set 'targetDelegate' or 'actionBlock' and pass it to any other object where it could be executed via 'execute:'.
 */

@interface Action : NSObject

@property (readonly, nonatomic, weak) id<ActionExecuteDelegate> targetDelegate;
@property (readonly, nonatomic, copy) ActionBlock actionBlock;

// Factory

+ (instancetype)actionWithTarget:(id<ActionExecuteDelegate>)targetDelegate;
+ (instancetype)actionWithBlock:(ActionBlock)actionBlock;

/**
 Will delegate execution to 'targetDelegate' or perform 'actionBlock' if they are exsit. Override this method to incapsulate other extended action behavoir
 */

- (void)execute:(id*)parameter;

@end
