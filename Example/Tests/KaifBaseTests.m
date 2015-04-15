//
//  KaifBaseTests.m
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 9/4/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "KaifBaseTests.h"

@implementation KaifBaseTests

- (void)setUp {
  [super setUp];
  
  NSString* kaifClientId = [[NSProcessInfo processInfo] environment][@"KAIF_CLIENT_ID"];
  NSString* kaifSecret = [[NSProcessInfo processInfo] environment][@"KAIF_SECRET"];
  NSString* kaifToken = [[NSProcessInfo processInfo] environment][@"KAIF_TOKEN"];
  NSAssert(![@"" isEqual:kaifClientId], @"KAIF_CLIENT_ID env not set");
  NSAssert(![@"" isEqual:kaifSecret], @"KAIF_SECRET env not set");
  NSAssert(![@"" isEqual:kaifToken], @"KAIF_TOKEN env not set");
  
  AFOAuthCredential* credential = [[AFOAuthCredential alloc] initWithOAuthToken:kaifToken tokenType:@"Bearer"];
  self.client = [[KaifClient alloc] initWithClientID:kaifClientId secret:kaifSecret credential:credential];
}

@end
