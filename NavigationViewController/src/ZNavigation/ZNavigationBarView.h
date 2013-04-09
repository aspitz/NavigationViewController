//
//  ZNavigationBarView.h
//  ZNavigationViewController
//
//  Created by Ayal Spitz on 3/26/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetTextProtocol
@optional
- (void)setText:(NSString *)text;
@end

@interface ZNavigationBarView : UIView{
    UIView *_leftViewContainer;
    UIView *_rightViewContainer;
    UIView *_titleViewContainer;
}

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;

@property (nonatomic, strong) UIView<SetTextProtocol> *titleView;

- (void)setTitle:(NSString *)title;

@end
