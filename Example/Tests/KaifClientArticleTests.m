//
//  KaifClientTests.m
//  KaifClientTests
//
//  Created by Chan Fai Chong on 8/4/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "KaifBaseTests.h"
#import "KaifClient.h"
#import "KaifClient+Article.h"

@interface KaifClientTests : KaifBaseTests
@end

@implementation KaifClientTests

- (void)setUp {
    [super setUp];
    NSString* kaifClientId = [[NSProcessInfo processInfo] environment][@"KAIF_CLIENT_ID"];
    NSString* kaifSecret = [[NSProcessInfo processInfo] environment][@"KAIF_SECRET"];
    NSString* kaifToken = [[NSProcessInfo processInfo] environment][@"KAIF_TOKEN"];
    NSAssert(![@"" isEqual:kaifClientId], @"KAIF_CLIENT_ID env not set");
    NSAssert(![@"" isEqual:kaifSecret], @"KAIF_SECRET env not set");
    NSAssert(![@"" isEqual:kaifToken], @"KAIF_TOKEN env not set");
}

- (void)tearDown {
    [super tearDown];
}

- (void)testGetHotArticles {
    __block NSArray* resultArticles;
    __block NSError* resultError;
    
    [self.client getHotArticlesWithStartArticleId:nil callback:^(NSArray *articles, NSError *error) {
        resultArticles = articles;
        resultError = error;
    }];

    expect(resultArticles).willNot.beNil();
    expect(resultArticles).to.beKindOf([NSArray class]);
    expect(resultError).to.beNil();
    
    [resultArticles enumerateObjectsUsingBlock:^(NSDictionary* article, NSUInteger idx, BOOL *stop) {
        expect(article[@"articleId"]).toNot.beNil();
        expect(article[@"articleType"]).toNot.beNil();
        expect(article[@"authorName"]).toNot.beNil();
        expect(article[@"content"]).toNot.beNil();
        expect(article[@"createTime"]).toNot.beNil();
        expect(article[@"debateCount"]).toNot.beNil();
        expect(article[@"link"]).toNot.beNil();
        expect(article[@"title"]).toNot.beNil();
        expect(article[@"upVote"]).toNot.beNil();
        expect(article[@"zone"]).toNot.beNil();
        expect(article[@"zoneTitle"]).toNot.beNil();
    }];
}

- (void)testGetHotArticlesWithStartArticleId {
    __block NSArray* resultArticles;
    __block NSError* resultError;
    
    [self.client getHotArticlesWithStartArticleId:@"cJ6eRmAw6n" callback:^(NSArray *articles, NSError *error) {
        resultArticles = articles;
        resultError = error;
    }];
    
    expect(resultArticles).willNot.beNil();
    expect(resultArticles).to.beKindOf([NSArray class]);
    expect(resultError).to.beNil();
    
    [resultArticles enumerateObjectsUsingBlock:^(NSDictionary* article, NSUInteger idx, BOOL *stop) {
        expect(article[@"articleId"]).toNot.beNil();
        expect(article[@"articleType"]).toNot.beNil();
        expect(article[@"authorName"]).toNot.beNil();
        expect(article[@"content"]).toNot.beNil();
        expect(article[@"createTime"]).toNot.beNil();
        expect(article[@"debateCount"]).toNot.beNil();
        expect(article[@"link"]).toNot.beNil();
        expect(article[@"title"]).toNot.beNil();
        expect(article[@"upVote"]).toNot.beNil();
        expect(article[@"zone"]).toNot.beNil();
        expect(article[@"zoneTitle"]).toNot.beNil();
    }];
}

- (void)testGetLatestArticles {
    __block NSArray* resultArticles;
    __block NSError* resultError;
    
    [self.client getLatestArticlesWithStartArticleId:nil callback:^(NSArray *articles, NSError *error) {
        resultArticles = articles;
        resultError = error;
    }];
    
    expect(resultArticles).willNot.beNil();
    expect(resultArticles).to.beKindOf([NSArray class]);
    expect(resultError).to.beNil();
    
    [resultArticles enumerateObjectsUsingBlock:^(NSDictionary* article, NSUInteger idx, BOOL *stop) {
        expect(article[@"articleId"]).toNot.beNil();
        expect(article[@"articleType"]).toNot.beNil();
        expect(article[@"authorName"]).toNot.beNil();
        expect(article[@"content"]).toNot.beNil();
        expect(article[@"createTime"]).toNot.beNil();
        expect(article[@"debateCount"]).toNot.beNil();
        expect(article[@"link"]).toNot.beNil();
        expect(article[@"title"]).toNot.beNil();
        expect(article[@"upVote"]).toNot.beNil();
        expect(article[@"zone"]).toNot.beNil();
        expect(article[@"zoneTitle"]).toNot.beNil();
    }];
}


- (void)testGetLatestArticlesWithStartArticleId {
    __block NSArray* resultArticles;
    __block NSError* resultError;
    
    [self.client getLatestArticlesWithStartArticleId:@"cJ6eRmAw6n" callback:^(NSArray *articles, NSError *error) {
        resultArticles = articles;
        resultError = error;
    }];
    
    expect(resultArticles).willNot.beNil();
    expect(resultArticles).to.beKindOf([NSArray class]);
    expect(resultError).to.beNil();
    
    [resultArticles enumerateObjectsUsingBlock:^(NSDictionary* article, NSUInteger idx, BOOL *stop) {
        expect(article[@"articleId"]).toNot.beNil();
        expect(article[@"articleType"]).toNot.beNil();
        expect(article[@"authorName"]).toNot.beNil();
        expect(article[@"content"]).toNot.beNil();
        expect(article[@"createTime"]).toNot.beNil();
        expect(article[@"debateCount"]).toNot.beNil();
        expect(article[@"link"]).toNot.beNil();
        expect(article[@"title"]).toNot.beNil();
        expect(article[@"upVote"]).toNot.beNil();
        expect(article[@"zone"]).toNot.beNil();
        expect(article[@"zoneTitle"]).toNot.beNil();
    }];
}


#pragma mark - Article With Zone

- (void)testGetHotArticlesWithZone {
    __block NSArray* resultArticles;
    __block NSError* resultError;
    
    [self.client getHotArticlesWithZone:@"kaif-terms" startArticleId:nil callback:^(NSArray *articles, NSError *error) {
        resultArticles = articles;
        resultError = error;
    }];
    
    expect(resultArticles).willNot.beNil();
    expect(resultArticles).to.beKindOf([NSArray class]);
    expect(resultError).to.beNil();

    [resultArticles enumerateObjectsUsingBlock:^(NSDictionary* article, NSUInteger idx, BOOL *stop) {
        expect(article[@"articleId"]).toNot.beNil();
        expect(article[@"articleType"]).toNot.beNil();
        expect(article[@"authorName"]).toNot.beNil();
        expect(article[@"content"]).toNot.beNil();
        expect(article[@"createTime"]).toNot.beNil();
        expect(article[@"debateCount"]).toNot.beNil();
        expect(article[@"link"]).toNot.beNil();
        expect(article[@"title"]).toNot.beNil();
        expect(article[@"upVote"]).toNot.beNil();
        expect(article[@"zone"]).toNot.beNil();
        expect(article[@"zoneTitle"]).toNot.beNil();
    }];
}

- (void)testGetHotArticlesWithZoneAndStartArticleId {
    __block NSArray* resultArticles;
    __block NSError* resultError;
    
    [self.client getHotArticlesWithZone:@"kaif-terms" startArticleId:@"cJ6eRmAw6n" callback:^(NSArray *articles, NSError *error) {
        resultArticles = articles;
        resultError = error;
    }];
    
    expect(resultArticles).willNot.beNil();
    expect(resultArticles).to.beKindOf([NSArray class]);
    expect(resultError).to.beNil();
    
    [resultArticles enumerateObjectsUsingBlock:^(NSDictionary* article, NSUInteger idx, BOOL *stop) {
        expect(article[@"articleId"]).toNot.beNil();
        expect(article[@"articleType"]).toNot.beNil();
        expect(article[@"authorName"]).toNot.beNil();
        expect(article[@"content"]).toNot.beNil();
        expect(article[@"createTime"]).toNot.beNil();
        expect(article[@"debateCount"]).toNot.beNil();
        expect(article[@"link"]).toNot.beNil();
        expect(article[@"title"]).toNot.beNil();
        expect(article[@"upVote"]).toNot.beNil();
        expect(article[@"zone"]).toNot.beNil();
        expect(article[@"zoneTitle"]).toNot.beNil();
    }];
}

- (void)testGetLatestArticlesWithZone {
    __block NSArray* resultArticles;
    __block NSError* resultError;
    
    [self.client getLatestArticlesWithZone:@"kaif-terms" startArticleId:nil callback:^(NSArray *articles, NSError *error) {
        resultArticles = articles;
        resultError = error;
    }];
    
    expect(resultArticles).willNot.beNil();
    expect(resultArticles).to.beKindOf([NSArray class]);
    expect(resultError).to.beNil();
    
    [resultArticles enumerateObjectsUsingBlock:^(NSDictionary* article, NSUInteger idx, BOOL *stop) {
        expect(article[@"articleId"]).toNot.beNil();
        expect(article[@"articleType"]).toNot.beNil();
        expect(article[@"authorName"]).toNot.beNil();
        expect(article[@"content"]).toNot.beNil();
        expect(article[@"createTime"]).toNot.beNil();
        expect(article[@"debateCount"]).toNot.beNil();
        expect(article[@"link"]).toNot.beNil();
        expect(article[@"title"]).toNot.beNil();
        expect(article[@"upVote"]).toNot.beNil();
        expect(article[@"zone"]).toNot.beNil();
        expect(article[@"zoneTitle"]).toNot.beNil();
    }];
}


- (void)testGetLatestArticlesWithZoneAndStartArticleId {
    __block NSArray* resultArticles;
    __block NSError* resultError;
    
    [self.client getLatestArticlesWithZone:@"kaif-terms" startArticleId:@"cJ6eRmAw6n" callback:^(NSArray *articles, NSError *error) {
        resultArticles = articles;
        resultError = error;
    }];
    
    expect(resultArticles).willNot.beNil();
    expect(resultArticles).to.beKindOf([NSArray class]);
    expect(resultError).to.beNil();
    
    [resultArticles enumerateObjectsUsingBlock:^(NSDictionary* article, NSUInteger idx, BOOL *stop) {
        expect(article[@"articleId"]).toNot.beNil();
        expect(article[@"articleType"]).toNot.beNil();
        expect(article[@"authorName"]).toNot.beNil();
        expect(article[@"content"]).toNot.beNil();
        expect(article[@"createTime"]).toNot.beNil();
        expect(article[@"debateCount"]).toNot.beNil();
        expect(article[@"link"]).toNot.beNil();
        expect(article[@"title"]).toNot.beNil();
        expect(article[@"upVote"]).toNot.beNil();
        expect(article[@"zone"]).toNot.beNil();
        expect(article[@"zoneTitle"]).toNot.beNil();
    }];
}



@end
