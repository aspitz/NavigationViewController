//
//  GraphicsUtil.c
//
//  Created by Ayal Spitz on 4/4/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#include "GraphicsUtil.h"

void CGContextDrawLine(CGContextRef c, CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2){
    CGContextBeginPath(c);
    CGContextMoveToPoint(c, x1, y1);
    CGContextAddLineToPoint(c, x2, y2);
    CGContextStrokePath(c);
}