//
//  ZPair.m
//
//  Created by Ayal Spitz on 4/4/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZPair.h"

#define kAKey       @"A"
#define kBKey       @"B"

@implementation ZPair

- (id)initWithA:(id<NSCoding, NSCopying>)a andB:(id<NSCoding, NSCopying>)b{
    self = [super init];
    if (self) {
        self.a = a;
        self.b = b;
    }
    return self;
}

#pragma mark - NSCoding methods

- (id)initWithCoder:(NSCoder *)aDecoder{
    ZPair *obj = [[ZPair alloc]init];
    obj.a = [aDecoder decodeObjectForKey:kAKey];
    obj.b = [aDecoder decodeObjectForKey:kBKey];
    return obj;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.a forKey:kAKey];
    [aCoder encodeObject:self.b forKey:kBKey];
}

#pragma mark - NSCopying methods

- (id)copyWithZone:(NSZone *)zone{
    ZPair *copy = [[ZPair alloc]init];
    if (copy){
        copy.a = [self.a copyWithZone:zone];
        copy.b = [self.b copyWithZone:zone];
    }
    return copy;
}

#pragma mark - Subscript access methods

- (void)setObject:(id)anObject atIndexedSubscript:(NSUInteger)index{
    switch (index) {
        case 0:
            self.a = anObject;
            break;
        case 1:
            self.b = anObject;
            break;
        default:
            break;
    }
}

- (id)objectAtIndexedSubscript:(NSUInteger)index{
    switch (index) {
        case 0:
            return self.a;
        case 1:
            return self.b;
        default:
            return nil;
    }
}

@end
