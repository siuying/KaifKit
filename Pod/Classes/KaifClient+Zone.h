//
//  KaifClient+Zone.h
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 9/4/15.
//  Copyright (c) 2015 Ignition Soft. All rights reserved.
//

#import "KaifClient.h"

@interface KaifClient (Zone)

-(void) getZonesWithCallback:(void(^)(NSArray* zones, NSError* error))callback;

@end
