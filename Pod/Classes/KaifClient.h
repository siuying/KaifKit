//
//  KaifClient.h
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 8/4/15.
//  Copyright (c) 2015 Ignition Soft. All rights reserved.
//

#import <AFOAuth2Manager/AFOAuth2Manager.h>

extern id KCNullSafeObject(id object);

extern NSString* const KaifClientErrorDomain;

@interface KaifClient : AFOAuth2Manager

- (instancetype)initWithClientID:(NSString*)clientID secret:(NSString*)secret credential:(AFOAuthCredential*)credential;

- (BOOL)authenticated;

- (void)authenticateWithViewController:(UIViewController *)viewController;

@end
