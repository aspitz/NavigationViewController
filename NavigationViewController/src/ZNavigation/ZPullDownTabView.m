//
//  ZPullDownTabView.m
//  NavigationViewController
//
//  Created by Ayal Spitz on 3/31/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZPullDownTabView.h"
#import "ZBasicTabView.h"
#import "ZView.h"

#import "UIView+Utilities.h"
#import "GraphicsUtil.h"

@implementation ZPullDownTabView

- (id)init{
    self = [super init];
    if (self) {
        _contentContainerView = [ZView viewWithDrawRectBlock:^(CGRect rect, CGContextRef currentContext) {
            CGContextSetStrokeColorWithColor(currentContext, [UIColor blackColor].CGColor);
            CGContextSetLineWidth(currentContext, 1.0);
            
            CGContextDrawLine(currentContext, 0.0, 0.0, 0.0, rect.size.height);
            CGContextDrawLine(currentContext, rect.size.width, 0.0, rect.size.width, rect.size.height);
        }];
        _contentContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentContainerView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_contentContainerView];
        
        _tabContainerView = [[UIView alloc]init];
        _tabContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_tabContainerView];
        
        NSMutableArray *constraints = [NSMutableArray array];
        NSArray *constraintArray = nil;
        NSDictionary *viewDictionary = @{@"contentContainerView":_contentContainerView,
                                         @"tabContainerView":_tabContainerView};
        constraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"|[contentContainerView]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewDictionary];
        [constraints addObjectsFromArray:constraintArray];
        constraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"|[tabContainerView]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewDictionary];
        [constraints addObjectsFromArray:constraintArray];
        constraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentContainerView][tabContainerView]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewDictionary];
        [constraints addObjectsFromArray:constraintArray];
        
        [self addConstraints:constraints];
        
        self.tabView = [[ZBasicTabView alloc]init];
        self.tabView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)setContentView:(UIView *)contentView{
    _contentView = contentView;
    [_contentContainerView addSubview:contentView withMaxConstraintsAndInsets:UIEdgeInsetsMake(0.0, 1.0, 0.0, 1.0)];
}

- (void)setTabView:(UIView *)tabView{
    _tabView = tabView;
    [_tabContainerView addSubviewWithMaxConstraints:tabView];
}

@end