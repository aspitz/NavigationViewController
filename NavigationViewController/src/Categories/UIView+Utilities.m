//
//  UIView+Utilities.m
//  NavigationViewController
//
//  Created by Ayal Spitz on 3/30/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "UIView+Utilities.h"

@implementation UIView (Utilities)

- (void)insertSubview:(UIView *)view betweenSubview:(UIView *)oneSubview andSubview:(UIView *)anotherSubview{
    NSUInteger oneIndex = [self.subviews indexOfObject:oneSubview];
    NSUInteger anotherIndex = [self.subviews indexOfObject:anotherSubview];
    NSUInteger insertIndex = MIN(oneIndex, anotherIndex);
    [self insertSubview:view atIndex:insertIndex];
}

- (NSArray *)addSubviewWithMaxConstraints:(UIView *)view{
    return [self addSubview:view withMaxConstraintsAndInsets:UIEdgeInsetsZero];
}

- (NSArray *)addSubview:(UIView *)view withMaxConstraintsAndInsets:(UIEdgeInsets)insets{
    // make sure we don't use auto resizing masks
    view.translatesAutoresizingMaskIntoConstraints = NO;
    // add the view as a subview
    [self addSubview:view];
    
    // build max constraints
    NSMutableArray *constraints = [NSMutableArray array];
    NSLayoutConstraint *constraint = nil;
    
    constraint = [NSLayoutConstraint constraintWithItem:view
                                              attribute:NSLayoutAttributeTop
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self
                                              attribute:NSLayoutAttributeTop
                                             multiplier:1.0
                                               constant:insets.top];
    [constraints addObject:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:view
                                              attribute:NSLayoutAttributeBottom
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self
                                              attribute:NSLayoutAttributeBottom
                                             multiplier:1.0
                                               constant:-insets.bottom];
    [constraints addObject:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:view
                                              attribute:NSLayoutAttributeLeft
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self
                                              attribute:NSLayoutAttributeLeft
                                             multiplier:1.0
                                               constant:insets.left];
    [constraints addObject:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:view
                                              attribute:NSLayoutAttributeRight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self
                                              attribute:NSLayoutAttributeRight
                                             multiplier:1.0
                                               constant:-insets.right];
    [constraints addObject:constraint];
    
    // add the new constraints
    [self addConstraints:constraints];
    
    // return the constraints, just in case
    return constraints;
}

@end
