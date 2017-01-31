//
//  AFHTTPSessionManager+BFTask.h
//  Imaggle
//
//  Created by David Liu on 8/20/14.
//  Copyright (c) 2014 Imaggle. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <Bolts/Bolts.h>

@interface AFHTTPSessionManager (BFTask)

- (BFTask *)getWithURL:(NSString *)url parameters:(NSDictionary *)parameters;
- (BFTask *)postWithURL:(NSString *)url parameters:(NSDictionary *)parameters;
- (BFTask *)postWithURL:(NSString *)url parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block;
- (BFTask *)deleteWithURL:(NSString *)url parameters:(NSDictionary *)parameters;
- (BFTask *)putWithURL:(NSString *)url parameters:(NSDictionary *)parameters;
@end
