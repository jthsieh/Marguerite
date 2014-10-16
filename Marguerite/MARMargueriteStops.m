//
//  MARMargueriteStops.m
//  Marguerite
//
//  Created by Tim Hsieh on 10/16/14.
//  Copyright (c) 2014 Stanford. All rights reserved.
//

#import "MARMargueriteStops.h"

#import "MARNetworkingService.h"

@implementation MARMargueriteStops

- (instancetype)initWithData
{
    self = [super init];
    if (self) {
        MARNetworkingService *sharedService = [MARNetworkingService sharedNetworkingService];
        [sharedService getDataWithURL:@"stops"
                              success:^(id responseObject) {
                                  
                                  NSDictionary *dict = responseObject; // Key: string, value: an array of NSDictionaries
                                  NSArray *results = [dict objectForKey:@"results"]; // Get the array of dictionaries
                                  for (NSDictionary *stopInfo in results) {
                                      [self.stops setObject:stopInfo[@"stop_id"] forKey:stopInfo[@"stop_name"]];
                                  }
                                  
                              } failure:^(NSError *error) {
                                  
                              }];
    }
    return self;
}

@end
