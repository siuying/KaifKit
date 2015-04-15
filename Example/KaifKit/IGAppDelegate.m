//
//  IGAppDelegate.m
//  KaifKit
//
//  Created by CocoaPods on 04/15/2015.
//  Copyright (c) 2014 Francis Chong. All rights reserved.
//

#import "IGAppDelegate.h"
#import "IGViewController.h"
#import <KaifKit/KaifKit.h>

@interface IGAppDelegate()
@property (nonatomic, strong) KaifClient* client;
@end

@implementation IGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // environment variable have to be set
    NSString* kaifClientId = [[NSProcessInfo processInfo] environment][@"KAIF_CLIENT_ID"];
    NSString* kaifSecret = [[NSProcessInfo processInfo] environment][@"KAIF_SECRET"];
    NSAssert(![kaifClientId isEqualToString:@""], @"KAIF_CLIENT_ID is not set!");
    NSAssert(![kaifSecret isEqualToString:@""], @"KAIF_SECRET is not set!");

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[IGViewController alloc] initWithNibName:nil bundle:nil];
    [self.window makeKeyAndVisible];

    self.client = [[KaifClient alloc] initWithClientID:kaifClientId secret:kaifSecret redirectURL:[NSURL URLWithString:@"kafkit://callback"]];
    if (![self.client authenticated]) {
        [self.client authenticateWithViewController:self.window.rootViewController];
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
