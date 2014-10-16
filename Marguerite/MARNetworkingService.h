//
//  MARNetworkingService.h
//  Marguerite
//
//  Created by Tim Hsieh on 10/14/14.
//  Copyright (c) 2014 Stanford. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MARSuccessBlock)(id responseObject);
typedef void (^MARFailureBlock)(NSError *error);

@interface MARNetworkingService : NSObject

+ (instancetype)sharedNetworkingService;

- (void)getDataWithURL:(NSString *)type success:(MARSuccessBlock)success failure:(MARFailureBlock)failure;


@end
