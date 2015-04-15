//
//  KaifClient.h
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 8/4/15.
//  Copyright (c) 2015 Ignition Soft. All rights reserved.
//

#import <AFOAuth2Manager/AFOAuth2Manager.h>

@class KaifAuthenticator;

extern id KCNullSafeObject(id object);

extern NSString* const KaifClientErrorDomain;

@interface KaifClient : AFOAuth2Manager

@property (nonatomic, readonly) KaifAuthenticator* authenticator;

- (instancetype)initWithClientID:(NSString*)clientID
                          secret:(NSString*)secret
                     redirectURL:(NSURL*)redirectURL;

- (instancetype)initWithClientID:(NSString*)clientID
                          secret:(NSString*)secret
                     redirectURL:(NSURL*)redirectURL
                      credential:(AFOAuthCredential*)credential;

- (BOOL)authenticated;

- (void)authenticateWithViewController:(UIViewController *)viewController;

@end
