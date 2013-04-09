//
//  ZTriplet.h
//
//  Created by Ayal Spitz on 4/4/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZPair.h"

@interface ZTriplet : ZPair

@property (strong) id<NSCoding, NSCopying> c;

- (id)initWithA:(id<NSCoding, NSCopying>)a b:(id<NSCoding, NSCopying>)b andC:(id<NSCoding, NSCopying>)c;

- (void)setObject:(id)anObject atIndexedSubscript:(NSUInteger)index;
- (id)objectAtIndexedSubscript:(NSUInteger)index;

@end
