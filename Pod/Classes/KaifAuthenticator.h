//
//  KaifOAuthAuthenticator.h
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 9/4/15.
//  Copyright (c) 2015 Ignition Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* const KaifOAuthAuthenticatorErrorDomian;
extern NSInteger const KaifOAuthAuthenticatorErrorCodeUserCancelled;
extern NSInteger const KaifOAuthAuthenticatorErrorCodeUnexpected;

@interface KaifAuthenticator : NSObject

// callback when authentication failed
@property (nonatomic, copy) void(^failureCallback)(NSError* error);

// callback when authentication succeed
@property (nonatomic, copy) void(^successCallback)(NSString* accessToken);

-(instancetype) initWithClientID:(NSString*)clientID
                          secret:(NSString*)secret
                authorizationURL:(NSURL*)authorizationURL
                        tokenURL:(NSURL*)tokenURL
                     redirectURL:(NSURL*)redirectURL;

- (void)authenticateWithViewController:(UIViewController *)viewController;

@end
