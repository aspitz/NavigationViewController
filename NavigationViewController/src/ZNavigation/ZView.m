//
//  ZView.m
//  NavigationViewController
//
//  Created by Ayal Spitz on 4/2/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZView.h"

@implementation ZView

- (id)initWithDrawRectBlock:(DrawRectBlock)drawRectBlock{
    self = [super init];
    if (self){
        self.drawRectBlock = drawRectBlock;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andDrawRectBlock:(DrawRectBlock)drawRectBlock{
    self = [super initWithFrame:frame];
    if (self){
        self.drawRectBlock = drawRectBlock;
    }
    return self;
}

+ (id)viewWithDrawRectBlock:(DrawRectBlock)drawRectBlock{
    return [[[self class]alloc]initWithDrawRectBlock:drawRectBlock];
}

- (void)drawRect:(CGRect)rect{
    if (self.drawRectBlock != nil){
        self.drawRectBlock(rect, UIGraphicsGetCurrentContext());
    }
}

@end
