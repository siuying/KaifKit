//
//  KaifClient+Vote.m
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 8/4/15.
//  Copyright (c) 2015 Ignition Soft. All rights reserved.
//

#import "KaifClient+Vote.h"

static NSString* voteStateToString(KaifClientVoteState state) {
    switch (state) {
        case KaifClientVoteStateUP:
            return @"UP";
        case KaifClientVoteStateDOWN:
            return @"DOWN";
        case KaifClientVoteStateEMPTY:
            return @"EMPTY";
            
    }
    [NSException raise:NSInternalInconsistencyException format:@"unexpected state: %@", @(state)];
}

@implementation KaifClient (Vote)

-(void) getArticleVotesWithArticleIds:(NSArray*)articleIds
                             callback:(void(^)(NSArray* votes, NSError* error))callback
{
    NSParameterAssert(articleIds);
    NSAssert([articleIds count] > 0, @"must provide at least one articleIds");
    
    NSDictionary* params = @{@"article-id": [articleIds componentsJoinedByString:@","]};

    [self GET:@"/v1/vote/article"
   parameters:params
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

-(void) getDebateVotesWithDebateIds:(NSArray*)debateIds
                           callback:(void(^)(NSArray* votes, NSError* error))callback
{
    NSParameterAssert(debateIds);
    NSAssert([debateIds count] > 0, @"must provide at least one debateIds");
    
    NSDictionary* params = @{@"debate-id": [debateIds componentsJoinedByString:@","]};
    
    [self GET:@"/v1/vote/debate"
   parameters:params
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

-(void) getDebateVotesWithArticleId:(NSString*)articleId
                           callback:(void(^)(NSArray* votes, NSError* error))callback
{
    NSParameterAssert(articleId);
    
    [self GET:[NSString stringWithFormat:@"/v1/vote/debate/article/%@", articleId]
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

-(void) postArticleVoteWithArticleId:(NSString*)articleId
                           voteState:(KaifClientVoteState)voteState
                            callback:(void(^)(NSError* error))callback
{
    NSParameterAssert(articleId);
    
    NSDictionary* params = @{@"articleId": articleId, @"voteState": voteStateToString(voteState)};
    [self POST:@"/v1/vote/article"
   parameters:params
      success:^(AFHTTPRequestOperation *operation, NSDictionary* response) {
          NSArray* errors = response[@"errors"];
          if ([errors count] > 0) {
              callback([NSError errorWithDomain:KaifClientErrorDomain code:1 userInfo:@{NSLocalizedDescriptionKey: [errors description]}]);
              return;
          }
          
          callback(nil);
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          callback(error);
      }];
}

-(void) postDebateVoteWithDebateId:(NSString*)debateId
                         voteState:(KaifClientVoteState)voteState
                          callback:(void(^)(NSError* error))callback
{
    NSDictionary* params = @{@"debateId": debateId, @"voteState": voteStateToString(voteState)};
    [self POST:@"/v1/vote/debate"
    parameters:params
       success:^(AFHTTPRequestOperation *operation, NSDictionary* response) {
           NSArray* errors = response[@"errors"];
           if ([errors count] > 0) {
               callback([NSError errorWithDomain:KaifClientErrorDomain code:1 userInfo:@{NSLocalizedDescriptionKey: [errors description]}]);
               return;
           }
           
           callback(nil);
       }
       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           callback(error);
       }];
}

@end
