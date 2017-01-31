//
//  NSArray+Manipulation.m
//  Imaggle
//
//  Created by David Liu on 4/6/14.
//  Copyright (c) 2014 Imaggle. All rights reserved.
//

#import "NSArray+Manipulation.h"

@implementation NSArray (Manipulation)
- (NSArray *)arrayByManipulationBlock:(id(^)(id obj, NSUInteger ind))manipulationBlock
{
    if (self.count) {
        NSMutableArray *ma = [NSMutableArray arrayWithCapacity:self.count];
        for (NSUInteger i = 0; i < self.count; i++) {
            id mObj = manipulationBlock(self[i], i);
            if (mObj) {
                [ma addObject:mObj];
            }
        }
        return [NSArray arrayWithArray:ma];
    }
    return nil;
}
@end
