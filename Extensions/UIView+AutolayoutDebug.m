//
//  UIView+AutolayoutDebug.m
//  Utils
//
//  Created by Mykola Denysyuk on 1/11/16.
//
//

#import "UIView+AutolayoutDebug.h"

@implementation UIView (AutolayoutDebug)

- (void)traceConstraints {
    [self p_traceConstraintsLevel:1];
}

- (void)p_traceConstraintsLevel:(NSUInteger)level {
    printf("\n\n");
    char * prefix = malloc(sizeof(char)*level*2 +1);
    for (int i=0; i<(level*2); i+=2) {
        prefix[i] = '\t';
        prefix[i+1] = '|';
    }
    prefix[level*2] = '\0';
    const char * viewDescription = [[self description] cStringUsingEncoding:NSASCIIStringEncoding];
    printf("%s ", prefix);
    printf("%s ", viewDescription);
    
    [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        printf("\n%s ", prefix);
        const char * constraintDesc = [[obj description] cStringUsingEncoding:NSASCIIStringEncoding];
        printf("%s%c", constraintDesc, idx == (self.constraints.count-1) ? ' ' : ',');
    }];
    
    free(prefix);
    
    if (self.subviews.count) {
        for (UIView *subview in self.subviews) {
            [subview p_traceConstraintsLevel:level+1];
        }
    }
}

@end
