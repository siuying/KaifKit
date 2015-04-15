//
//  KaifClientDebateTests.m
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 9/4/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KaifBaseTests.h"
#import "KaifClient+Debate.h"

@interface KaifClientDebateTests : KaifBaseTests

@end

@implementation KaifClientDebateTests

- (void)testPutDebate {
    __block NSDictionary* _debate;
    __block NSError* _error = [NSError new];
    
    [self.client putDebateWithArticleId:@"cdlEDT288j" parentDebateId:@"cMnpVZzryL" content:@"test 2" callback:^(NSDictionary *debate, NSError *error) {
        _debate = debate;
        _error = error;
    }];

    expect(_error).will.beNil();
    expect(_debate).willNot.beNil();
    expect(_debate).to.beKindOf([NSDictionary class]);
}


- (void)testGetDebatesWithArticleId {
    __block NSDictionary* _debateTree;
    __block NSError* _error = [NSError new];
    
    [self.client getDebatesWithArticleId:@"cLstHmXC0H" callback:^(NSDictionary *debateTree, NSError *error) {
        _debateTree = debateTree;
        _error = error;
    }];
    expect(_debateTree).willNot.beNil();
    expect(_debateTree).to.beKindOf([NSDictionary class]);
    expect(_error).to.beNil();
}

@end
