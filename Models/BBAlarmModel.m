//
//  BBAlarmModel.m
//  Bellbird
//
//  Created by David Liu on 1/31/17.
//  Copyright © 2017 Handshake. All rights reserved.
//

#import "BBAlarmModel.h"

@implementation BBAlarmModel

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper mapperForSnakeCase];
}

@end
