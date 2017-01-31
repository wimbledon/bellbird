//
//  NSArray+Manipulation.h
//  Imaggle
//
//  Created by David Liu on 4/6/14.
//  Copyright (c) 2014 Imaggle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Bolts/Bolts.h>

@interface NSArray (Manipulation)
- (NSArray *)arrayByManipulationBlock:(id(^)(id obj, NSUInteger ind))manipulationBlock;
@end
