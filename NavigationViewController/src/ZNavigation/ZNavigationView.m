//
//  ZNavigationView.m
//  NavigationViewController
//
//  Created by Ayal Spitz on 3/26/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZNavigationView.h"
#import "ZNavigationBarView.h"
#import "ZPullDownTabView.h"
#import "UIView+Utilities.h"

@implementation ZNavigationView

- (id)init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    
    self.navigationContentView = [[UIView alloc]init];
    self.navigationContentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.navigationContentView];
    
    self.pullDownTabView = [[ZPullDownTabView alloc]init];
    self.pullDownTabView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.pullDownTabView];
    
    self.navigationBarView = [[ZNavigationBarView alloc]init];
    self.navigationBarView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.navigationBarView];

    NSArray *constraints = nil;
    NSDictionary *viewsDictionary = @{@"barView":self.navigationBarView,
                                      @"contentView":self.navigationContentView,
                                      @"pullDownTabView":self.pullDownTabView};
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|[barView]|"
                                                          options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|[contentView]|"
                                                          options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[barView(44)][contentView]|"
                                                          options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraints];
    
    
    NSLayoutConstraint *constraint = nil;
    NSMutableArray *constraintsArray = [NSMutableArray array];
    
    _openConstraint = [NSLayoutConstraint constraintWithItem:self.pullDownTabView
                                                   attribute:NSLayoutAttributeBottom
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self.navigationContentView
                                                   attribute:NSLayoutAttributeBottom
                                                  multiplier:1.0
                                                    constant:-3.0];
    
    _closedConstraint = [NSLayoutConstraint constraintWithItem:self.pullDownTabView
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.navigationContentView
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:15.0];
    [constraintsArray addObject:_closedConstraint];
    constraint = [NSLayoutConstraint constraintWithItem:self.pullDownTabView
                                              attribute:NSLayoutAttributeLeft
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.navigationContentView
                                              attribute:NSLayoutAttributeLeft
                                             multiplier:1.0
                                               constant:3.0];
    [constraintsArray addObject:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:self.pullDownTabView
                                              attribute:NSLayoutAttributeWidth
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.navigationContentView
                                              attribute:NSLayoutAttributeWidth
                                             multiplier:1.0
                                               constant:-6.0];
    [constraintsArray addObject:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:self.pullDownTabView
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.navigationContentView
                                              attribute:NSLayoutAttributeHeight
                                             multiplier:1.0
                                               constant:0.0];
    [constraintsArray addObject:constraint];
    [self addConstraints:constraintsArray];
    
    UIView *tab = self.pullDownTabView.tabView;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    [tab addGestureRecognizer:tapGestureRecognizer];
    _isOpen = NO;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer{
    if (_isOpen){
        [self removeConstraint:_openConstraint];
        [self addConstraint:_closedConstraint];
    } else {
        [self removeConstraint:_closedConstraint];
        [self addConstraint:_openConstraint];
    }

    
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
        _isOpen = !_isOpen;
    }];
}

@end
