//
//  ZView.h
//  NavigationViewController
//
//  Created by Ayal Spitz on 4/2/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZView : UIView

typedef void (^DrawRectBlock)(CGRect rect, CGContextRef currentContext);

@property (assign) DrawRectBlock drawRectBlock;

- (id)initWithDrawRectBlock:(DrawRectBlock)drawRectBlock;
- (id)initWithFrame:(CGRect)frame andDrawRectBlock:(DrawRectBlock)drawRectBlock;

+ (id)viewWithDrawRectBlock:(DrawRectBlock)drawRectBlock;

@end
