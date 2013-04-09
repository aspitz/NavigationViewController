//
//  ZTriplet.m
//
//  Created by Ayal Spitz on 4/4/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZTriplet.h"

#define kCKey       @"C"

@implementation ZTriplet

- (id)initWithA:(id<NSCoding, NSCopying>)a b:(id<NSCoding, NSCopying>)b andC:(id<NSCoding, NSCopying>)c{
    self = [super initWithA:a andB:b];
    if (self) {
        self.c = c;
    }
    return self;
}

#pragma mark - NSCoding methods

- (id)initWithCoder:(NSCoder *)aDecoder{
    ZTriplet *obj = [super initWithCoder:aDecoder];
    obj.c = [aDecoder decodeObjectForKey:kCKey];
    return obj;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.c forKey:kCKey];
}

#pragma mark - NSCopying methods

- (id)copyWithZone:(NSZone *)zone{
    ZTriplet *copy = [super copyWithZone:zone];
    if (copy){
        copy.c = [self.c copyWithZone:zone];
    }
    return copy;
}

#pragma mark - Subscript access methods

- (void)setObject:(id)anObject atIndexedSubscript:(NSUInteger)index{
    switch (index) {
        case 0:
        case 1:
            [super setObject:anObject atIndexedSubscript:index];
            break;
        case 2:
            self.c = anObject;
            break;
        default:
            break;
    }
}

- (id)objectAtIndexedSubscript:(NSUInteger)index{
    switch (index) {
        case 0:
        case 1:
            return [self objectAtIndexedSubscript:index];
        case 2:
            return self.c;
        default:
            return nil;
    }
}

@end
