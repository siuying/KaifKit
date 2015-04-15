//
//  KaifAuthViewController.m
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 9/4/15.
//  Copyright (c) 2015 Ignition Soft. All rights reserved.
//

#import "KaifAuthViewController.h"
#import "KaifClient.h"

#import <AFOAuth2Manager/AFOAuth2Manager.h>
#import <AFNetworking/AFNetworking.h>
#import <stdlib.h>

@interface KaifAuthViewController () <UIWebViewDelegate>
@property (nonatomic, strong) AFOAuth2Manager* oauthManager;

@property (nonatomic, strong) UIActivityIndicatorView* activityIndicator;
@property (nonatomic, strong) UIWebView* webView;

@property (nonatomic, strong) NSURL* authorizationURL;
@property (nonatomic, strong) NSURL* redirectURL;
@property (nonatomic, strong) NSString* clientID;
@property (nonatomic, strong) NSString* secret;
@end

@implementation KaifAuthViewController

- (instancetype)initWithAuthorizationURL:(NSURL*)authorizationURL
                             redirectURL:(NSURL*)redirectURL
                                clientID:(NSString*)clientID
                                  secret:(NSString*)secret
                                delegate:(id<KaifAuthViewControllerDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.clientID = clientID;
        self.secret = secret;
        self.authorizationURL = authorizationURL;
        self.redirectURL = redirectURL;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(cancel:)];
    
    self.navigationItem.rightBarButtonItem = cancelItem;

    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.activityIndicator setHidesWhenStopped:YES];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];

    self.activityIndicator.frame = CGRectMake((self.navigationController.view.frame.size.width - (self.activityIndicator.frame.size.width/2))/2,
                                              (self.navigationController.view.frame.size.height - (self.activityIndicator.frame.size.height/2) - 44)/2,
                                              self.activityIndicator.frame.size.width,
                                              self.activityIndicator.frame.size.height);
    [self.webView addSubview:self.activityIndicator];
    [self loadWebView];
}

- (void)cancel:(id)sender
{
    [self.webView stopLoading];
    if (self.delegate) {
        [self.delegate authViewControllerDidCancel:self];
    }
    self.delegate = nil;
}

- (void)loadWebView
{
    [self.activityIndicator startAnimating];
    [self.webView setDelegate:self];
    
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionary];
    mutableParameters[@"client_id"] = self.clientID;
    mutableParameters[@"client_secret"] = self.secret;
    mutableParameters[@"scope"] = @"public user feed article debate vote";
    mutableParameters[@"response_type"] = @"code";
    mutableParameters[@"state"] = [NSString stringWithFormat:@"%@", @(arc4random())];
    mutableParameters[@"redirect_uri"] = self.redirectURL.absoluteString;
    AFHTTPRequestSerializer* serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request = [serializer requestWithMethod:@"GET" URLString:self.authorizationURL.absoluteString parameters:mutableParameters error:nil];
    [self.webView loadRequest:request];
}

-(void) reload
{
    [self loadWebView];
}

# pragma mark - UIWebViewDelegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if ([error.domain isEqualToString:@"WebKitErrorDomain"] && error.code == 102) {
        // ignore "Frame load interrupted" errors
        return;
    }

    if ([[webView.request.URL absoluteString] hasPrefix:self.redirectURL.absoluteString]) {
        // ignore oauth redirect;
        return;
    }
    
    [self.activityIndicator stopAnimating];
    
    [self.webView stopLoading];

    if (self.delegate) {
        [self.delegate authViewController:self didFailWithError:error];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([[request.URL absoluteString] hasPrefix:self.redirectURL.absoluteString]) {
        if (self.delegate) {
            [self.delegate authViewController:self receivedOAuthCallbackURL:request.URL];
        }
    }

    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
}

@end
