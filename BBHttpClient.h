//
//  BBHttpClient.h
//  Bellbird
//
//  Created by David Liu on 1/31/17.
//  Copyright © 2017 Handshake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Bolts/Bolts.h>
#import "BBAlarmModel.h"

@interface BBHttpClient : NSObject

+ (instancetype)sharedClient;

- (BFTask *)fetchAlarms;

- (BFTask *)createAlarmWithBody:(NSString *)body votes:(NSInteger)votes;

- (BFTask *)updateAlarm:(BBAlarmModel *)alarm withVotes:(NSInteger)votes;

@end
