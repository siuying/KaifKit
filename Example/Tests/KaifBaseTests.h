//
//  KaifBaseTests.h
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 9/4/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KaifClient.h"
#import <Expecta/Expecta.h>
#import <AFOAuth2Manager/AFHTTPRequestSerializer+OAuth2.h>

@interface KaifBaseTests : XCTestCase
@property (nonatomic, strong) KaifClient* client;
@end
