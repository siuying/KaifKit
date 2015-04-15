//
//  KaifClient+Debate.h
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 9/4/15.
//  Copyright (c) 2015 Ignition Soft. All rights reserved.
//

#import "KaifClient.h"

@interface KaifClient (Debate)

-(void) putDebateWithArticleId:(NSString*)articleId
                parentDebateId:(NSString*)parentDebateId
                       content:(NSString*)content
                      callback:(void(^)(NSDictionary* debate, NSError* error))callback;

-(void) getDebatesWithArticleId:(NSString*)articleId
                       callback:(void(^)(NSDictionary* debateTree, NSError* error))callback;

@end
