//
//  KaifClientZoneTests.m
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 9/4/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "KaifBaseTests.h"
#import "KaifClient+Zone.h"

@interface KaifClientZoneTests : KaifBaseTests
@end

@implementation KaifClientZoneTests

- (void)testGetZones {
    __block NSArray* resultZones;
    __block NSError* resultError;
    
    [self.client getZonesWithCallback:^(NSArray *zones, NSError *error) {
        resultZones = zones;
        resultError = error;
    }];
    
    expect(resultZones).willNot.beNil();
    expect(resultZones).to.beKindOf([NSArray class]);
    expect(resultZones).to.haveCountOf(10);
    expect(resultError).to.beNil();
}

@end
