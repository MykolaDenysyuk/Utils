//
//  Action.m
//
//
//  Created by Mykola Denysyuk on 8/6/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import "Action.h"

@implementation Action

+ (instancetype)actionWithTarget:(id<ActionExecuteDelegate>)targetDelegate
{
    return [[self alloc] initWithTarget:targetDelegate
                                orBlock:nil];
}

+ (instancetype)actionWithBlock:(ActionBlock)actionBlock
{
    return [[self alloc] initWithTarget:nil
                                orBlock:actionBlock];
}

- (id)initWithTarget:(id)target orBlock:(ActionBlock)actionBlock
{
    self = [super init];
    if (self) {
        _targetDelegate = target;
        _actionBlock = actionBlock;
    }
    return self;
}

- (void)execute:(__autoreleasing id *)parameter
{
    if (self.targetDelegate) {
        [self.targetDelegate action:self
                    delegateExecute:parameter];
    }
    else if (self.actionBlock)
    {
        self.actionBlock(parameter);
    }
}

@end
