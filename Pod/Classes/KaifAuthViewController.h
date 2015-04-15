//
//  KaifAuthViewController.h
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 9/4/15.
//  Copyright (c) 2015 Ignition Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KaifAuthViewController;

@protocol KaifAuthViewControllerDelegate <NSObject>
- (void)authViewControllerDidCancel:(KaifAuthViewController *)controller;
- (void)authViewController:(KaifAuthViewController *)sender didFailWithError:(NSError *)error;
- (void)authViewController:(KaifAuthViewController *)controller receivedOAuthCallbackURL:(NSURL *)url;
@end

@interface KaifAuthViewController : UIViewController

@property (nonatomic, weak) id<KaifAuthViewControllerDelegate> delegate;

- (instancetype)initWithAuthorizationURL:(NSURL*)authorizationURL
                             redirectURL:(NSURL*)redirectURL
                                clientID:(NSString*)clientID
                                  secret:(NSString*)secret
                                delegate:(id<KaifAuthViewControllerDelegate>)delegate;

-(void) reload;

@end
