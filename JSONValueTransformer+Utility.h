//
//  JSONValueTransformer+Utility.h
//  Bellbird
//
//  Created by David Liu on 1/31/17.
//  Copyright © 2017 Handshake. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JSONValueTransformer (Utility)

- (NSDate*)NSDateFromNSString:(NSString*)string;

@end
