//
//  ZNavigationBarView.m
//  ZNavigationViewController
//
//  Created by Ayal Spitz on 3/26/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZNavigationBarView.h"
#import "UIView+Utilities.h"

@implementation ZNavigationBarView

- (id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        _leftViewContainer = [[UIView alloc]init];
        _leftViewContainer.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_leftViewContainer];
    
        _rightViewContainer = [[UIView alloc]init];
        _rightViewContainer.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_rightViewContainer];

        _titleViewContainer = [[UIView alloc]init];
        _titleViewContainer.translatesAutoresizingMaskIntoConstraints = NO;
        _titleViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_titleViewContainer];
        
        NSDictionary *viewsDictionary = @{@"leftView":_leftViewContainer,
                                          @"titleView":_titleViewContainer,
                                          @"rightView":_rightViewContainer};
        NSArray *constraints = nil;
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|[leftView(44)][titleView][rightView(44)]|"
                                                              options:0 metrics:nil views:viewsDictionary];
        [self addConstraints:constraints];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[leftView]|"
                                                              options:0 metrics:nil views:viewsDictionary];
        [self addConstraints:constraints];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleView]|"
                                                              options:0 metrics:nil views:viewsDictionary];
        [self addConstraints:constraints];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rightView]|"
                                                              options:0 metrics:nil views:viewsDictionary];
        [self addConstraints:constraints];

        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        self.titleView = (UIView<SetTextProtocol> *)titleLabel;
        
        
        UIImage *grayImage = [UIImage imageNamed:@"arrow-west(gray)"];
        UIImage *whiteImage = [UIImage imageNamed:@"arrow-west(white)"];
        UIImageView *backImageView = [[UIImageView alloc] initWithImage:grayImage highlightedImage:whiteImage];
        backImageView.contentMode = UIViewContentModeCenter;
        backImageView.translatesAutoresizingMaskIntoConstraints = NO;
        backImageView.userInteractionEnabled = YES;
        self.leftView = backImageView;
    }
    return self;
}

#pragma mark - Set View Methods
- (void)setLeftView:(UIView *)leftView{
    _leftView = leftView;
    [_leftViewContainer addSubviewWithMaxConstraints:leftView];
}

- (void)setRightView:(UIView *)rightView{
    _rightView = rightView;
    [_rightViewContainer addSubviewWithMaxConstraints:rightView];
}

- (void)setTitleView:(UIView<SetTextProtocol> *)titleView{
    _titleView = titleView;
    [_titleViewContainer addSubviewWithMaxConstraints:titleView];
}

#pragma mark -
- (void)setTitle:(NSString *)title{
    _titleView.text = title;
}

@end
