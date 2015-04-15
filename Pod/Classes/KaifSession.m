//
//  KaifSession.m
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 10/4/15.
//  Copyright (c) 2015 Ignition Soft. All rights reserved.
//

#import "KaifSession.h"
#import <SSKeychain/SSKeychain.h>
#import <AFOAuth2Manager/AFOAuth2Manager.h>

NSString* const KaifSessionAuthenticationChangedNotification = @"KaifSessionAuthenticationChangedNotification";
NSString* const KaifSessionAuthenticationFailureNotification = @"KaifSessionAuthenticationFailureNotification";

static NSString* const ServiceName      = @"Kaif.io";
static NSString* const ServiceAccount   = @"Bearer";
static NSString* _sharedAccessGroup     = nil;

@implementation KaifSession

+(BOOL) setAccessToken:(NSString*)accessToken
                 error:(NSError *__autoreleasing *)error
{
    SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
    query.service = ServiceName;
    query.account = ServiceAccount;
    query.accessGroup = [self accessGroup];
    query.password = accessToken;
    BOOL succeed = [query save:error];
    if (succeed) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KaifSessionAuthenticationChangedNotification object:nil];

    } else if (*error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KaifSessionAuthenticationFailureNotification object:@{NSLocalizedDescriptionKey: [(*error) localizedDescription]}];

    }

    return succeed;
}

+(BOOL) authenticated
{
    SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
    query.service = ServiceName;
    query.account = ServiceAccount;
    query.accessGroup = [self accessGroup];
    return [query fetch:nil];
}

+(AFOAuthCredential*) credential
{
    SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
    query.service = ServiceName;
    query.account = ServiceAccount;
    query.accessGroup = [self accessGroup];
    NSError* error;
    if(![query fetch:&error]) {
        NSLog(@"error auth: %@", error);
        return nil;
    }
    return [[AFOAuthCredential alloc] initWithOAuthToken:query.password tokenType:@"Bearer"];
}

+(void) logout
{
    SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
    query.service = ServiceName;
    query.account = ServiceAccount;
    query.accessGroup = [self accessGroup];
    [query deleteItem:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:KaifSessionAuthenticationChangedNotification object:nil];
}

+(void) setAccessGroup:(NSString*)accessGroup
{
    _sharedAccessGroup = accessGroup;
}


+(NSString*) accessGroup
{
    return _sharedAccessGroup;
}

@end
