//
//  JSONValueTransformer+Utility.m
//  Bellbird
//
//  Created by David Liu on 1/31/17.
//  Copyright © 2017 Handshake. All rights reserved.
//

#import "JSONValueTransformer+Utility.h"

@implementation JSONValueTransformer (Utility)

- (NSDate*)NSDateFromNSString:(NSString*)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    return [dateFormatter dateFromString:string];
}

@end
