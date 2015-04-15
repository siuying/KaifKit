//
//  KaifClient+Zone.m
//  KaifReaderReactNative
//
//  Created by Chan Fai Chong on 9/4/15.
//  Copyright (c) 2015 Ignition Soft. All rights reserved.
//

#import "KaifClient+Zone.h"

@implementation KaifClient (Zone)

-(void) getZonesWithCallback:(void(^)(NSArray* zones, NSError* error))callback
{
    [self GET:@"/v1/zone/all"
   parameters:nil
      success:^(AFHTTPRequestOperation *operation, NSDictionary* response) {
          NSArray* errors = response[@"errors"];
          if ([errors count] > 0) {
              callback(nil, [NSError errorWithDomain:KaifClientErrorDomain code:1 userInfo:@{NSLocalizedDescriptionKey: [errors description]}]);
              return;
          }
          
          callback(response[@"data"], nil);
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          callback(nil, error);
      }];
}

@end
