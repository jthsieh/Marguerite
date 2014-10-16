//
//  MARNetworkingService.m
//  Marguerite
//
//  Created by Tim Hsieh on 10/14/14.
//  Copyright (c) 2014 Stanford. All rights reserved.
//

#import "MARNetworkingService.h"
#import <AFNetworking/AFNetworking.h>

static NSString *kRoutesURL = @"http://tsukihi.org/marguerite/routes.json";
static NSString *kTripsURL = @"http://tsukihi.org/marguerite/trips.json";
static NSString *kStopTimesURL = @"http://tsukihi.org/marguerite/stop_times.json";
static NSString *kStopsURL = @"http://tsukihi.org/marguerite/stops.json";

@implementation MARNetworkingService

+ (instancetype)sharedNetworkingService {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)getDataWithURL:(NSString *)type success:(MARSuccessBlock)success failure:(MARFailureBlock)failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSString *URL;
    if ([type isEqualToString:@"routes"]) {
        URL = kRoutesURL;
    } else if ([type isEqualToString:@"trips"]) {
        URL = kTripsURL;
    } else if ([type isEqualToString:@"stop_times"]) {
        URL = kStopTimesURL;
    } else {
        URL = kStopsURL;
    }
    
    [manager GET:URL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if ([responseObject isKindOfClass:[NSDictionary class]]) {
                 success(responseObject);
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             failure(error);
         }];
}


@end
