//
//  KaifClient+Article.m
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 8/4/15.
//  Copyright (c) 2015 Ignition Soft. All rights reserved.
//

#import "KaifClient+Article.h"

#import <AFOAuth2Manager/AFHTTPRequestSerializer+OAuth2.h>
#import "KaifSession.h"

@implementation KaifClient (Article)

- (void) putExternLinkWithTitle:(NSString*)title
                      URLString:(NSString*)URLString
                           zone:(NSString*)zone
                       callback:(void(^)(NSDictionary* article, NSError* error))callback
{
    [self PUT:@"/v1/article/external-link"
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

- (void) putSpeakWithTitle:(NSString*)title
                   content:(NSString*)content
                      zone:(NSString*)zone
                  callback:(void(^)(NSDictionary* article, NSError* error))callback
{
    [self PUT:@"/v1/article/speak"
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

- (void) getArticlesWithType:(KaifClientArticleType)type zone:(NSString*)zone startArticleId:(NSString*)startArticleId callback:(void(^)(NSArray* articles, NSError* error))callback
{
    NSString* path = [self getArticlePathWithType:type zone:zone];

    NSDictionary* params;
    if (startArticleId) {
        params = @{@"start-article-id": startArticleId};
    }

    [self GET:path
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

- (void) getHotArticlesWithStartArticleId:(NSString*)startArticleId
                                 callback:(void(^)(NSArray* articles, NSError* error))callback
{
    [self getArticlesWithType:KaifClientArticleTypeHot zone:nil startArticleId:startArticleId callback:callback];
}

- (void) getLatestArticlesWithStartArticleId:(NSString*)startArticleId
                                    callback:(void(^)(NSArray* articles, NSError* error))callback
{
    [self getArticlesWithType:KaifClientArticleTypeLatest zone:nil startArticleId:startArticleId callback:callback];
}

- (void) getHotArticlesWithZone:(NSString*)zone
                 startArticleId:(NSString*)startArticleId
                       callback:(void(^)(NSArray* articles, NSError* error))callback
{
    [self getArticlesWithType:KaifClientArticleTypeHot zone:zone startArticleId:startArticleId callback:callback];
}

- (void) getLatestArticlesWithZone:(NSString*)zone
                    startArticleId:(NSString*)startArticleId
                          callback:(void(^)(NSArray* articles, NSError* error))callback
{
    [self getArticlesWithType:KaifClientArticleTypeLatest zone:zone startArticleId:startArticleId callback:callback];
}

#pragma mark - 

-(NSString*) getArticlePathWithType:(KaifClientArticleType)type zone:(NSString*)zone
{
    NSMutableString* url = [[NSMutableString alloc] init];
    [url appendString:@"/v1/article"];
    if (zone) {
        [url appendFormat:@"/zone/%@", zone];
    }
    if (type == KaifClientArticleTypeHot) {
        [url appendString:@"/hot"];
    } else {
        [url appendString:@"/latest"];
    }
    return [url copy];
}

@end
