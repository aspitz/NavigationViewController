//
//  ZNavigationView.h
//  NavigationViewController
//
//  Created by Ayal Spitz on 3/26/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZNavigationBarView;
@class ZPullDownTabView;

@interface ZNavigationView : UIView{
    NSLayoutConstraint *_closedConstraint;
    NSLayoutConstraint *_openConstraint;
    BOOL _isOpen;
}

@property (strong) ZNavigationBarView *navigationBarView;
@property (strong) ZPullDownTabView *pullDownTabView;
@property (strong) UIView *navigationContentView;

@end
