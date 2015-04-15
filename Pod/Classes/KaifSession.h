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

/**
 * Application shared user session
 */
@interface KaifSession : NSObject

/**
 * save access token for shared session
 */
+(BOOL) setAccessToken:(NSString*)accessToken
                 error:(NSError**)error;

/**
 * get logged in user credential
 */
+(AFOAuthCredential*) credential;

/*
* check if user is authenticated
*/
+(BOOL) authenticated;

/**
 * Logout current user session
 */
+(void) logout;

/**
 * Set the shared access group. Default nil.
 */
+(void) setAccessGroup:(NSString*)accessGroup;

/**
 * Get the shared app group
 */
+(NSString*) accessGroup;

@end
