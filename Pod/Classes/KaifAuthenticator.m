//
//  KaifOAuthAuthenticator.m
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 9/4/15.
//  Copyright (c) 2015 Ignition Soft. All rights reserved.
//

#import "KaifAuthenticator.h"
#import "KaifAuthViewController.h"

#import <AFOAuth2Manager/AFOAuth2Manager.h>
#import <AFNetworking/AFNetworking.h>

NSInteger const KaifOAuthAuthenticatorErrorCodeUserCancelled = 3000;
NSInteger const KaifOAuthAuthenticatorErrorCodeUnexpected = 3001;
NSString* const KaifOAuthAuthenticatorErrorDomian = @"KaifOAuthAuthenticatorErrorDomian";

@interface KaifAuthenticator() <KaifAuthViewControllerDelegate>
@property (nonatomic, strong) NSURL* authorizationURL;
@property (nonatomic, strong) NSURL* tokenURL;
@property (nonatomic, strong) NSURL* redirectURL;

@property (nonatomic, copy) NSString* clientID;
@property (nonatomic, copy) NSString* secret;
@property (nonatomic, strong) KaifAuthViewController* authViewController;
@end

@implementation KaifAuthenticator

-(instancetype) initWithClientID:(NSString*)clientID
                          secret:(NSString*)secret
                authorizationURL:(NSURL*)authorizationURL
                        tokenURL:(NSURL*)tokenURL
                     redirectURL:(NSURL*)redirectURL
{
    self = [super init];

    self.clientID = clientID;
    self.secret = secret;
    
    self.authorizationURL = authorizationURL;
    self.tokenURL = tokenURL;
    self.redirectURL = redirectURL;
    return self;
}

- (void)authenticateWithViewController:(UIViewController *)viewController
{
    if (!self.authViewController) {
        self.authViewController = [[KaifAuthViewController alloc] initWithAuthorizationURL:self.authorizationURL
                                                                               redirectURL:self.redirectURL
                                                                                  clientID:self.clientID
                                                                                    secret:self.secret
                                                                                  delegate:self];
    }

    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:self.authViewController];
    [viewController presentViewController:navController animated:YES completion:NULL];
}

-(void) cleanup
{
    self.successCallback = nil;
    self.failureCallback = nil;
    self.authViewController = nil;
}

-(void) dismissAuthViewController
{
    __weak KaifAuthenticator* weakSelf = self;
    [self.authViewController.parentViewController dismissViewControllerAnimated:YES completion:^{
        [weakSelf cleanup];
    }];
}

#pragma mark -

- (void) retrieveAccessTokenUsingCode:(NSString*)code
{
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionary];
    mutableParameters[@"client_id"] = self.clientID;
    mutableParameters[@"client_secret"] = self.secret;
    mutableParameters[@"code"] = code;
    mutableParameters[@"grant_type"] = @"authorization_code";
    mutableParameters[@"redirect_uri"] = self.redirectURL.absoluteString;

    __weak KaifAuthenticator* weakSelf = self;
    [[AFHTTPSessionManager manager] POST:self.tokenURL.absoluteString
                              parameters:mutableParameters
                                 success:^(NSURLSessionDataTask *task, NSDictionary* response) {
                                     NSString* accessToken = response[@"access_token"];
                                     if (accessToken) {
                                         if (weakSelf.successCallback) {
                                             weakSelf.successCallback(accessToken);
                                         }
                                         [self dismissAuthViewController];
                                     } else if (response[@"errors"]) {
                                         NSArray* errors = response[@"errors"];
                                         if ([errors count] > 0) {
                                             if (weakSelf.failureCallback) {
                                                 weakSelf.failureCallback([NSError errorWithDomain:@"KaifAuthenticator"
                                                                                              code:2
                                                                                          userInfo:@{NSLocalizedDescriptionKey: [errors description]}]);
                                             }
                                         }
                                         [weakSelf.authViewController reload];
                                     } else {
                                         if (weakSelf.failureCallback) {
                                             weakSelf.failureCallback([NSError errorWithDomain:@"KaifAuthenticator"
                                                                                          code:3
                                                                                      userInfo:@{NSLocalizedDescriptionKey: @"Unknown error"}]);
                                         }
                                         [weakSelf.authViewController reload];
                                     }

                                     
                                 } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                     if (weakSelf.failureCallback) {
                                         weakSelf.failureCallback(error);
                                     }
                                     [weakSelf.authViewController reload];
                                 }];
}

#pragma mark -

- (void)authViewControllerDidCancel:(KaifAuthViewController *)controller
{
    [self dismissAuthViewController];
}

- (void)authViewController:(KaifAuthViewController *)sender didFailWithError:(NSError *)error
{
    if (self.failureCallback) {
        self.failureCallback(error);
    }

    [self.authViewController reload];
}

- (void)authViewController:(KaifAuthViewController *)controller receivedOAuthCallbackURL:(NSURL *)URL
{
    NSString* urlString = URL.absoluteString;
    NSRange queryRange = [urlString rangeOfString:@"?"];
    if (queryRange.location == NSNotFound || queryRange.location == urlString.length) {
        if (self.failureCallback) {
            self.failureCallback([NSError errorWithDomain:KaifOAuthAuthenticatorErrorDomian code:KaifOAuthAuthenticatorErrorCodeUnexpected userInfo:@{NSLocalizedDescriptionKey: [@"unexpected response URL: " stringByAppendingString:urlString]}]);
        }
        [self.authViewController reload];
        return;
    }

    NSString* query = [URL.absoluteString substringFromIndex:queryRange.location+1];
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [[query componentsSeparatedByString:@"&"] enumerateObjectsUsingBlock:^(NSString* fragment, NSUInteger idx, BOOL *stop) {
        NSArray* components = [fragment componentsSeparatedByString:@"="];
        NSString* key = [components firstObject];
        NSString* value = [components lastObject];
        if (key && value) {
            [params setObject:value forKey:key];
        }
    }];
    
    if (params[@"code"]) {
        [self retrieveAccessTokenUsingCode:params[@"code"]];
    } else {
        if (self.failureCallback) {
            self.failureCallback([NSError errorWithDomain:KaifOAuthAuthenticatorErrorDomian code:KaifOAuthAuthenticatorErrorCodeUnexpected userInfo:@{NSLocalizedDescriptionKey: @"missing 'code'"}]);
        }
        [self.authViewController reload];
    }
    
}

@end
