//
//  KaifSession.h
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 10/4/15.
//  Copyright (c) 2015 Ignition Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

// posted when user login/logout
extern NSString* const KaifSessionAuthenticationChangedNotification;
extern NSString* const KaifSessionAuthenticationFailureNotification;

@class AFOAuthCredential;

@interface KaifSession : NSObject

+(BOOL) setAccessToken:(NSString*)accessToken
                 error:(NSError**)error;

+(AFOAuthCredential*) credential;

+(BOOL) authenticated;

+(void) logout;

@end
