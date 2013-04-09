//
//  ZNavigationViewController.m
//  NavigationViewController
//
//  Created by Ayal Spitz on 3/26/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZNavigationViewController.h"
#import "ZNavigationView.h"
#import "ZNavigationBarView.h"
#import "ZPullDownTabView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ZNavigationViewController

#pragma mark - Init object methods

- (id)init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

- (void)setup{
    _constraintsStack = [NSMutableArray array];
    _tabViewControllerStack = [NSMutableArray array];
}

#pragma mark - 

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _navigationView = [[ZNavigationView alloc]init];
    _navigationView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_navigationView];

    NSArray *constraints = nil;
    NSDictionary *viewsDictionary = @{@"navigationView":_navigationView};
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|[navigationView]|"
                                                          options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[navigationView]|"
                                                          options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraints];
    
    self.navigationBarView.leftView.Hidden = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleLeftButtonTap:)];
    [self.navigationBarView.leftView addGestureRecognizer:tapGestureRecognizer];
}

#pragma mark - View access methods

- (ZNavigationBarView *)navigationBarView{
    return self.navigationView.navigationBarView;
}

- (UIView *)navigationContentView{
    return self.navigationView.navigationContentView;
}

- (ZPullDownTabView *)pullDownTabView{
    return self.navigationView.pullDownTabView;
}

#pragma mark - Button handler

- (void)handleLeftButtonTap:(UIGestureRecognizer *)gestureRecognizer{
    if (self.childViewControllers.count > 2){
        [self popViewControllerAnimated:YES];
    }
}

#pragma mark - ViewController management methods 

- (void)setRootViewController:(UIViewController *)viewController andTabViewController:(UIViewController *)tabViewController{
    _rootViewController = viewController;
    _rootTabViewController = tabViewController;
    [self pushViewController:viewController andTabViewController:tabViewController animated:NO];
}

- (void)pushViewController:(UIViewController *)viewController andTabViewController:(UIViewController *)tabViewController animated:(BOOL)animated{

    if (tabViewController != nil){
        // add tabViewController to pullDownTabView
        [self addChildViewController:tabViewController];
        [_tabViewControllerStack addObject:tabViewController];
        tabViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        self.pullDownTabView.contentView = tabViewController.view;
    } else {
        self.pullDownTabView.hidden = YES;
        [_tabViewControllerStack addObject:[NSNull null]];
    }

    
    // add viewController to navigationContentView
    [self addChildViewController:viewController];
    
    viewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    viewController.view.layer.masksToBounds = NO;
    viewController.view.layer.shadowOffset = CGSizeMake( -2.0, 0.0);
    viewController.view.layer.shadowOpacity = 0.5;
    [self.navigationContentView addSubview:viewController.view];

    NSDictionary *viewsDictionary = @{@"view":viewController.view};
    NSArray *constraintArray = nil;
    NSMutableArray *constraints = [NSMutableArray array];
    constraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"|[view]|"
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
    [constraints addObjectsFromArray:constraintArray];
    
    constraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|"
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
    [constraints addObjectsFromArray:constraintArray];

    
    void (^addConstraintsBlock)() = ^(){
        [self.navigationContentView addConstraints:constraints];
        [self.navigationContentView layoutIfNeeded];
        [_constraintsStack addObject:constraints];
    };
    
    if (animated){
        NSMutableArray *initialConstraints = [NSMutableArray arrayWithCapacity:4];
        initialConstraints[0] = [NSLayoutConstraint constraintWithItem:viewController.view
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.navigationContentView
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1.0
                                                              constant:0.0];
        
        initialConstraints[1] = [NSLayoutConstraint constraintWithItem:viewController.view
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.navigationContentView
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:1.0
                                                              constant:0.0];
        
        initialConstraints[2] = [NSLayoutConstraint constraintWithItem:viewController.view
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.navigationContentView
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.0
                                                              constant:0.0];
        
        initialConstraints[3] = [NSLayoutConstraint constraintWithItem:viewController.view
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.navigationContentView
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:1.0
                                                              constant:0.0];

        [self.navigationContentView addConstraints:initialConstraints];
        [self.navigationContentView layoutIfNeeded];

        self.navigationBarView.leftView.userInteractionEnabled = NO;
        
        [UIView animateWithDuration:0.5 delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone
                         animations:^{
                             [self.navigationContentView removeConstraints:initialConstraints];
                             addConstraintsBlock();
                         } completion:^(BOOL finished) {
                             self.navigationBarView.title = viewController.title;
                             self.navigationBarView.leftView.hidden = NO;
                             self.navigationBarView.leftView.userInteractionEnabled = YES;
                         }
         ];
    } else {
        addConstraintsBlock();
        self.navigationBarView.title = viewController.title;
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    UIViewController *contentController = self.childViewControllers.lastObject;
    
    [contentController willMoveToParentViewController:nil];
    
    void (^popViewControllerBlock)() = ^(){
        id obj = _tabViewControllerStack.lastObject;
        if (![obj isMemberOfClass:[NSNull class]]){
            UIViewController *tabViewController = obj;
            [tabViewController.view removeFromSuperview];
            [tabViewController removeFromParentViewController];            
        }
        [_tabViewControllerStack removeLastObject];

        obj = _tabViewControllerStack.lastObject;
        if (![obj isMemberOfClass:[NSNull class]]){
            self.pullDownTabView.hidden = NO;
        }
        
        [contentController.view removeFromSuperview];
        [contentController removeFromParentViewController];
        
        UIViewController *currentContentController = self.childViewControllers.lastObject;
        self.navigationBarView.title = currentContentController.title;
        
        NSUInteger minControllerCount = 1;
        if (![obj isMemberOfClass:[NSNull class]]){
            minControllerCount++;
        }
        if (self.childViewControllers.count == minControllerCount){
            self.navigationBarView.leftView.hidden = YES;
        }
    };
    
    if (animated){
        NSMutableArray *initialConstraints = [NSMutableArray arrayWithCapacity:4];
        initialConstraints[0] = [NSLayoutConstraint constraintWithItem:contentController.view
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.navigationContentView
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1.0
                                                              constant:0.0];
        
        initialConstraints[1] = [NSLayoutConstraint constraintWithItem:contentController.view
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.navigationContentView
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:1.0
                                                              constant:0.0];
        
        initialConstraints[2] = [NSLayoutConstraint constraintWithItem:contentController.view
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.navigationContentView
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.0
                                                              constant:0.0];
        
        initialConstraints[3] = [NSLayoutConstraint constraintWithItem:contentController.view
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.navigationContentView
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:1.0
                                                              constant:0.0];

        NSMutableArray *constraints = [_constraintsStack lastObject];
        [_constraintsStack removeLastObject];
        [self.navigationContentView removeConstraints:constraints];
        
        self.navigationBarView.leftView.userInteractionEnabled = NO;
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.navigationContentView addConstraints:initialConstraints];
            [self.navigationContentView layoutIfNeeded];
        } completion:^(BOOL finished) {
            popViewControllerBlock();
            self.navigationBarView.leftView.userInteractionEnabled = YES;
        }];
    } else {
        NSMutableArray *constraints = [_constraintsStack lastObject];
        [_constraintsStack removeLastObject];
        [self.navigationContentView removeConstraints:constraints];

        popViewControllerBlock();
    }
    
    return contentController;
}

@end
