//
//  KaifClientVoteTests.m
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 8/4/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//


#import "KaifBaseTests.h"
#import "KaifClient.h"
#import "KaifClient+Vote.h"

@interface KaifClientVoteTests : KaifBaseTests
@end

@implementation KaifClientVoteTests

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetVoteArticle {
    __block NSArray* resultVotes;
    __block NSError* resultError;
    
    [self.client getArticleVotesWithArticleIds:@[@"cLstHmXC0H", @"cJ6eRmAw6n", @"cbwYNJ2PIb"] callback:^(NSArray *votes, NSError *error) {
        resultVotes = votes;
        resultError = error;
    }];

    expect(resultVotes).willNot.beNil();
    expect(resultVotes).to.beKindOf([NSArray class]);
    expect(resultVotes).to.haveCountOf(3);
    expect(resultError).to.beNil();
}

- (void)testGetVoteDebate {
    __block NSArray* resultVotes;
    __block NSError* resultError;
    
    [self.client getDebateVotesWithDebateIds:@[@"cLykBF7SiP", @"cLsvqnas4z"] callback:^(NSArray *votes, NSError *error) {
        resultVotes = votes;
        resultError = error;
    }];
    
    expect(resultVotes).willNot.beNil();
    expect(resultVotes).to.beKindOf([NSArray class]);
    expect(resultVotes).to.haveCountOf(2);
    expect(resultError).to.beNil();
}

- (void)testGetVoteDebateWithArticle {
    __block NSArray* resultVotes;
    __block NSError* resultError;
    
    [self.client getDebateVotesWithArticleId:@"cLstHmXC0H" callback:^(NSArray *votes, NSError *error) {
        resultVotes = votes;
        resultError = error;
    }];
    
    expect(resultVotes).willNot.beNil();
    expect(resultVotes).to.beKindOf([NSArray class]);
    expect(resultVotes).to.haveCountOf(2);
    expect(resultError).to.beNil();
}

- (void)testPostVoteArticle {
    __block NSError* resultError = [NSError new];

    [self.client postArticleVoteWithArticleId:@"bHQqEaLhCf" voteState:KaifClientVoteStateUP callback:^(NSError *error) {
        resultError = error;
    }];

    expect(resultError).will.beNil();
}

- (void)testPostVoteDebate {
    __block NSError* resultError = [NSError new];
    
    [self.client postDebateVoteWithDebateId:@"cL9PGbXNq9" voteState:KaifClientVoteStateUP callback:^(NSError *error) {
        resultError = error;
    }];
    
    expect(resultError).will.beNil();
}

@end
