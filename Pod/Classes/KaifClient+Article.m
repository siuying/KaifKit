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

- (void) getHotArticlesWithStartArticleId:(NSString*)startArticleId
                                 callback:(void(^)(NSArray* articles, NSError* error))callback
{
    NSDictionary* params;
    
    if (startArticleId) {
        params = @{@"start-article-id": startArticleId};
    }
    
    [self GET:@"/v1/article/hot"
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
          
          if ([[error domain] isEqualToString:AFURLResponseSerializationErrorDomain]) {
              NSHTTPURLResponse* response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
              if (response.statusCode == 401) {
                  // auth error
                  //[KaifSession logout];
              }
          }
      }];
}

- (void) getLatestArticlesWithStartArticleId:(NSString*)startArticleId
                                    callback:(void(^)(NSArray* articles, NSError* error))callback
{
    [self GET:@"/v1/article/latest"
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

- (void) getHotArticlesWithZone:(NSString*)zone
                 startArticleId:(NSString*)startArticleId
                       callback:(void(^)(NSArray* articles, NSError* error))callback
{
    NSParameterAssert(zone);

    NSDictionary* params;
    
    if (startArticleId) {
        params = @{@"start-article-id": startArticleId};
    }
    
    [self GET:[NSString stringWithFormat:@"/v1/article/zone/%@/hot", zone]
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

- (void) getLatestArticlesWithZone:(NSString*)zone
                    startArticleId:(NSString*)startArticleId
                          callback:(void(^)(NSArray* articles, NSError* error))callback
{
    NSParameterAssert(zone);

    NSDictionary* params;
    
    if (startArticleId) {
        params = @{@"start-article-id": startArticleId};
    }

    [self GET:[NSString stringWithFormat:@"/v1/article/zone/%@/latest", zone]
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

@end
