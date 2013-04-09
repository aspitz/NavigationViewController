//
//  ZBasicTabView.m
//  NavigationViewController
//
//  Created by Ayal Spitz on 3/31/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZBasicTabView.h"

@implementation ZBasicTabView

- (id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentMode = UIViewContentModeRedraw;
        
        _tabRect = CGRectZero;
        _tabRect.size = CGSizeMake(30.0, 15.0);
    }
    return self;
}

- (CGSize)intrinsicContentSize{
    return CGSizeMake(UIViewNoIntrinsicMetric, 15.0);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return CGRectContainsPoint(_tabRect, point);
}

- (void)drawRect:(CGRect)rect{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    CGFloat tabX = (rect.size.width - _tabRect.size.width ) / 2.0;
    _tabRect.origin.x = tabX;
    CGFloat tabWidth = _tabRect.size.width;
    
    CGPathMoveToPoint(pathRef, NULL, tabX, 0);
    CGPathAddLineToPoint(pathRef, NULL, tabX + 3, rect.size.height);
    CGPathAddLineToPoint(pathRef, NULL, tabX + tabWidth - 6, rect.size.height);
    CGPathAddLineToPoint(pathRef, NULL, tabX + tabWidth - 3, 0);
    CGPathCloseSubpath(pathRef);
    
    CGContextSetFillColorWithColor(currentContext, [UIColor darkGrayColor].CGColor);
    CGContextAddPath(currentContext, pathRef);
    CGContextFillPath(currentContext);
    
    CGPathRelease(pathRef);
    
    pathRef = CGPathCreateMutable();
    
    CGPathMoveToPoint(pathRef, NULL, 0, 0);
    CGPathAddLineToPoint(pathRef, NULL, tabX, 0);
    CGPathAddLineToPoint(pathRef, NULL, tabX + 3, rect.size.height);
    CGPathAddLineToPoint(pathRef, NULL, tabX + tabWidth - 6, rect.size.height);
    CGPathAddLineToPoint(pathRef, NULL, tabX + tabWidth - 3, 0);
    CGPathAddLineToPoint(pathRef, NULL, rect.size.width, 0);
    
    CGContextSetLineWidth(currentContext, 1.5);
    CGContextSetStrokeColorWithColor(currentContext, [UIColor blackColor].CGColor);
    CGContextAddPath(currentContext, pathRef);
    CGContextStrokePath(currentContext);
    
    CGPathRelease(pathRef);
}

@end
