//
//  KaifClient+Vote.h
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 8/4/15.
//  Copyright (c) 2015 Ignition Soft. All rights reserved.
//

#import "KaifClient.h"

typedef NS_ENUM(NSUInteger, KaifClientVoteState) {
    KaifClientVoteStateUP,
    KaifClientVoteStateDOWN,
    KaifClientVoteStateEMPTY,
};

@interface KaifClient (Vote)

-(void) getArticleVotesWithArticleIds:(NSArray*)articleIds
                             callback:(void(^)(NSArray* votes, NSError* error))callback;

-(void) getDebateVotesWithDebateIds:(NSArray*)debateIds
                           callback:(void(^)(NSArray* votes, NSError* error))callback;

-(void) getDebateVotesWithArticleId:(NSString*)articleId
                           callback:(void(^)(NSArray* votes, NSError* error))callback;

-(void) postArticleVoteWithArticleId:(NSString*)articleId
                           voteState:(KaifClientVoteState)voteState
                            callback:(void(^)(NSError* error))callback;

-(void) postDebateVoteWithDebateId:(NSString*)debateId
                         voteState:(KaifClientVoteState)voteState
                          callback:(void(^)(NSError* error))callback;

@end
