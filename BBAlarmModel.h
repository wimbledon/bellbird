//
//  BBAlarmModel.h
//  Bellbird
//
//  Created by David Liu on 1/31/17.
//  Copyright © 2017 Handshake. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "JSONValueTransformer+Utility.h"

@interface BBAlarmModel : JSONModel

@property (nonatomic) NSUInteger id;
@property (nonatomic, strong) NSString *body;
@property (nonatomic) NSInteger votes;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;

@end
