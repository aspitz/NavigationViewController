//
//  ZPullDownTabView.h
//  NavigationViewController
//
//  Created by Ayal Spitz on 3/31/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPullDownTabView : UIView{
    UIView *_contentContainerView;
    UIView *_tabContainerView;
}

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *tabView;

@end
