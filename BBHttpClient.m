//
//  BBHttpClient.m
//  Bellbird
//
//  Created by David Liu on 1/31/17.
//  Copyright © 2017 Handshake. All rights reserved.
//

#import "BBHttpClient.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager+BFTask.h"
#import "NSArray+Manipulation.h"
#import "BBAlarmModel.h"

@interface BBHttpClient()
@property (nonatomic, strong) AFHTTPSessionManager *httpManager;
@end


@implementation BBHttpClient

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *baseUrl = [NSURL URLWithString:@"http://hs-bellbird.herokuapp.com"];
        self.httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
    }
    return self;
}

+ (instancetype)sharedClient
{
    static BBHttpClient *client;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[BBHttpClient alloc] init];
    });
    return client;
}

- (BFTask *)fetchAlarms
{
    return [[self.httpManager getWithURL:@"alarms.json" parameters:nil] continueWithSuccessBlock:^id _Nullable(BFTask * _Nonnull t) {
        NSArray *results = t.result;
        return [results arrayByManipulationBlock:^id(NSDictionary *mDic, NSUInteger ind) {
            NSError *er;
            BBAlarmModel *m = [[BBAlarmModel alloc] initWithDictionary:mDic error:&er];
            if (!er) {
                return m;
            }
            return er;
        }];
    }];
}

- (BFTask *)createAlarmWithBody:(NSString *)body votes:(NSInteger)votes
{
    __block BBAlarmModel *newAlarm;
    return [[[self.httpManager postWithURL:@"alarms.json"
                                parameters:@{@"alarm" : @{@"body" : body,
                                                          @"votes" : @(votes)}}] continueWithSuccessBlock:^id _Nullable(BFTask * _Nonnull t) {
        NSError *err;
        newAlarm = [[BBAlarmModel alloc] initWithDictionary:t.result error:&err];
        if (err) {
            return [BFTask taskWithError:err];
        }
        
        return [self.httpManager postWithURL:@"push" parameters:@{@"alarm_id" : @(newAlarm.id)}];
    }] continueWithSuccessBlock:^id _Nullable(BFTask * _Nonnull t) {
        return newAlarm;
    }];
}

- (BFTask *)updateAlarm:(BBAlarmModel *)alarm withVotes:(NSInteger)votes
{
    return [self.httpManager putWithURL:[NSString stringWithFormat:@"alarms/%lu.json", alarm.id]
                             parameters:@{@"alarm" : @{@"votes" : @(votes)}}];
}

@end
