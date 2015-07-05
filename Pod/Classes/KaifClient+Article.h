//
//  KaifClient+Article.h
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 8/4/15.
//  Copyright (c) 2015 Ignition Soft. All rights reserved.
//

#import "KaifClient.h"

typedef NS_ENUM(NSUInteger, KaifClientArticleType) {
    KaifClientArticleTypeHot,
    KaifClientArticleTypeLatest
};

@interface KaifClient (Article)

#pragma mark - Articles

- (void) putExternLinkWithTitle:(NSString*)title
                      URLString:(NSString*)URLString
                           zone:(NSString*)zone
                       callback:(void(^)(NSDictionary* article, NSError* error))callback;

- (void) putSpeakWithTitle:(NSString*)title
                   content:(NSString*)content
                      zone:(NSString*)zone
                  callback:(void(^)(NSDictionary* article, NSError* error))callback;

- (void) getArticlesWithType:(KaifClientArticleType)type
                        zone:(NSString*)zone
              startArticleId:(NSString*)startArticleId
                    callback:(void(^)(NSArray* articles, NSError* error))callback;

- (void) getHotArticlesWithStartArticleId:(NSString*)startArticleId
                                 callback:(void(^)(NSArray* articles, NSError* error))callback;

- (void) getLatestArticlesWithStartArticleId:(NSString*)startArticleId
                                    callback:(void(^)(NSArray* articles, NSError* error))callback;

- (void) getHotArticlesWithZone:(NSString*)zone
                 startArticleId:(NSString*)startArticleId
                       callback:(void(^)(NSArray* articles, NSError* error))callback;

- (void) getLatestArticlesWithZone:(NSString*)zone
                    startArticleId:(NSString*)startArticleId
                          callback:(void(^)(NSArray* articles, NSError* error))callback;

@end
