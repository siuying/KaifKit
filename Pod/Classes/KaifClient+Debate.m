//
//  KaifClient+Debate.m
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 9/4/15.
//  Copyright (c) 2015 Ignition Soft. All rights reserved.
//

#import "KaifClient+Debate.h"

@implementation KaifClient (Debate)

-(void) putDebateWithArticleId:(NSString*)articleId
                parentDebateId:(NSString*)parentDebateId
                       content:(NSString*)content
                      callback:(void(^)(NSDictionary* debate, NSError* error))callback
{
    NSParameterAssert(articleId);
    NSParameterAssert(content);

    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"articleId": articleId, @"content": content}];
    if (parentDebateId) {
        param[@"parentDebateId"] = parentDebateId;
    }
    
    [self PUT:@"/v1/debate"
   parameters:param
      success:^(AFHTTPRequestOperation *operation, NSDictionary* response) {
          NSArray* errors = response[@"errors"];
          if ([errors count] > 0) {
              callback(nil, [NSError errorWithDomain:KaifClientErrorDomain code:1 userInfo:@{NSLocalizedDescriptionKey: [errors description]}]);
              return;
          }
          
          callback(response[@"data"], nil);
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          callback(nil, error);
      }];
}

-(void) getDebatesWithArticleId:(NSString*)articleId
                       callback:(void(^)(NSDictionary* debateTree, NSError* error))callback
{
    NSParameterAssert(articleId);

    [self GET:[NSString stringWithFormat:@"/v1/debate/article/%@/tree", articleId]
   parameters:nil
      success:^(AFHTTPRequestOperation *operation, NSDictionary* response) {
          NSArray* errors = response[@"errors"];
          if ([errors count] > 0) {
              callback(nil, [NSError errorWithDomain:KaifClientErrorDomain code:1 userInfo:@{NSLocalizedDescriptionKey: [errors description]}]);
              return;
          }
          
          callback(response[@"data"], nil);
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          callback(nil, error);
      }];
}

@end
