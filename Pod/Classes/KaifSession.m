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

static NSString* const ServiceName = @"Kaif.io";
static NSString* const ServiceAccount = @"Bearer";
static NSString* const AccessGroup = @"hk.ignition.KaifApp";

@implementation KaifSession

+(BOOL) setAccessToken:(NSString*)accessToken
                 error:(NSError *__autoreleasing *)error
{
    SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
    query.service = ServiceName;
    query.account = ServiceAccount;
    query.accessGroup = AccessGroup;
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
    query.accessGroup = AccessGroup;
    return [query fetch:nil];
}

+(AFOAuthCredential*) credential
{
    SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
    query.service = ServiceName;
    query.account = ServiceAccount;
    query.accessGroup = AccessGroup;
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
    query.accessGroup = AccessGroup;
    [query deleteItem:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:KaifSessionAuthenticationChangedNotification object:nil];
}

@end
