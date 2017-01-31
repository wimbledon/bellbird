//
//  AFHTTPSessionManager+BFTask.m
//  Imaggle
//
//  Created by David Liu on 8/20/14.
//  Copyright (c) 2014 Imaggle. All rights reserved.
//

#import "AFHTTPSessionManager+BFTask.h"

@implementation AFHTTPSessionManager (BFTask)

- (BFTask *)getWithURL:(NSString *)url parameters:(NSDictionary *)parameters
{
    BFTaskCompletionSource *ts = [BFTaskCompletionSource taskCompletionSource];
    [self GET: url
   parameters:parameters
      success:^(NSURLSessionDataTask *task, id responseObject) {
          [ts setResult:responseObject];
      } failure:^(NSURLSessionDataTask *task, NSError *error) {
          [ts setError:error];
      }];
    return ts.task;
}

- (BFTask *)postWithURL:(NSString *)url parameters:(NSDictionary *)parameters
{
    BFTaskCompletionSource *ts = [BFTaskCompletionSource taskCompletionSource];
    [self POST: url
    parameters:parameters
       success:^(NSURLSessionDataTask *task, id responseObject) {
           [ts setResult:responseObject];
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           [ts setError:error];
       }];
    return ts.task;
}

- (BFTask *)postWithURL:(NSString *)url parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
{
    BFTaskCompletionSource *ts = [BFTaskCompletionSource taskCompletionSource];
    [self POST:url
    parameters:parameters
constructingBodyWithBlock:block
       success:^(NSURLSessionDataTask *task, id responseObject) {
           [ts setResult:responseObject];
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           [ts setError:error];
       }];
    return ts.task;
}

- (BFTask *)deleteWithURL:(NSString *)url parameters:(NSDictionary *)parameters
{
    BFTaskCompletionSource *ts = [BFTaskCompletionSource taskCompletionSource];
    [self DELETE:url
      parameters:parameters
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [ts setResult:responseObject];
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             [ts setError:error];
         }];
    return ts.task;
}

- (BFTask *)putWithURL:(NSString *)url parameters:(NSDictionary *)parameters
{
    BFTaskCompletionSource *ts = [BFTaskCompletionSource taskCompletionSource];
    [self PUT:url
   parameters:parameters
      success:^(NSURLSessionDataTask *task, id responseObject) {
          [ts setResult:responseObject];
      } failure:^(NSURLSessionDataTask *task, NSError *error) {
          [ts setError:error];
      }];
    return ts.task;
}

@end
