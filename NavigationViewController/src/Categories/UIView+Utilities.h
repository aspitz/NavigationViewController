//
//  UIView+Utilities.h
//  NavigationViewController
//
//  Created by Ayal Spitz on 3/30/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utilities)

- (void)insertSubview:(UIView *)view betweenSubview:(UIView *)oneSubview andSubview:(UIView *)anotherSubview;

- (NSArray *)addSubviewWithMaxConstraints:(UIView *)view;
- (NSArray *)addSubview:(UIView *)view withMaxConstraintsAndInsets:(UIEdgeInsets)insets;

@end
