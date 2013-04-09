//
//  ZNavigationViewController.h
//  NavigationViewController
//
//  Created by Ayal Spitz on 3/26/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZNavigationView;
@class ZNavigationBarView;
@class ZPullDownTabView;

@interface ZNavigationViewController : UIViewController{
    NSMutableArray *_constraintsStack;
    NSMutableArray *_tabViewControllerStack;
}

@property (readonly) ZNavigationView *navigationView;
@property (readonly) ZNavigationBarView *navigationBarView;
@property (readonly) UIView *navigationContentView;
@property (readonly) ZPullDownTabView *pullDownTabView;

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) UIViewController *rootTabViewController;

- (void)setRootViewController:(UIViewController *)viewController andTabViewController:(UIViewController *)tabViewController;
- (void)pushViewController:(UIViewController *)viewController andTabViewController:(UIViewController *)tabViewController animated:(BOOL)animated;

@end
