//
//  KaifClient.m
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 8/4/15.
//  Copyright (c) 2015 Ignition Soft. All rights reserved.
//

#import "KaifClient.h"
#import "KaifSession.h"
#import "KaifAuthenticator.h"

#import <AFOAuth2Manager/AFHTTPRequestSerializer+OAuth2.h>

id KCNullSafeObject(id object){
    return object ?: [NSNull null];
}

static NSString* const KaifClientBaseURLString  = @"https://kaif.io";
static NSString* const AuthorizationURLString   = @"https://kaif.io/oauth/authorize";
static NSString* const TokenURLString           = @"https://kaif.io/oauth/access-token";

NSString* const KaifClientErrorDomain = @"KaifClientErrorDomain";

@interface KaifClient()
@property (nonatomic, strong) KaifAuthenticator* authenticator;
@end

@implementation KaifClient

- (instancetype)initWithClientID:(NSString*)clientID
                          secret:(NSString*)secret
                     redirectURL:(NSURL*)redirectURL
{
    return [self initWithClientID:clientID secret:secret redirectURL:redirectURL credential:[KaifSession credential]];
}

- (instancetype)initWithClientID:(NSString*)clientID
                          secret:(NSString*)secret
                     redirectURL:(NSURL*)redirectURL
                      credential:(AFOAuthCredential*)credential
{
    self = [super initWithBaseURL:[NSURL URLWithString:KaifClientBaseURLString] clientID:clientID secret:secret];
    self.authenticator = [[KaifAuthenticator alloc] initWithClientID:clientID
                                                                   secret:secret
                                                         authorizationURL:[NSURL URLWithString:AuthorizationURLString]
                                                                 tokenURL:[NSURL URLWithString:TokenURLString]
                                                              redirectURL:redirectURL];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.requestSerializer setAuthorizationHeaderFieldWithCredential:credential];

    self.authenticator.successCallback = ^(NSString* code){
        NSError* error = nil;
        if (![KaifSession setAccessToken:code error:&error]) {
            NSLog(@"error saving key: %@", error);
        }
    };
    self.authenticator.failureCallback = ^(NSError* e){
        NSLog(@"failed login: %@", e);
    };

    return self;
}

-(BOOL) authenticated
{
    return [KaifSession authenticated];
}

- (void)authenticateWithViewController:(UIViewController *)viewController
{
    [self.authenticator authenticateWithViewController:viewController];
}

@end
