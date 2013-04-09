//
//  ZPair.h
//
//  Created by Ayal Spitz on 4/4/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPair : NSObject <NSCoding, NSCopying>

@property (strong) id<NSCoding, NSCopying> a;
@property (strong) id<NSCoding, NSCopying> b;

- (id)initWithA:(id<NSCoding, NSCopying>)a andB:(id<NSCoding, NSCopying>)b;

- (void)setObject:(id)anObject atIndexedSubscript:(NSUInteger)index;
- (id)objectAtIndexedSubscript:(NSUInteger)index;

@end
