//
//  MargueriteRoute.h
//  Marguerite
//
//  Created by Tim Hsieh on 10/13/14.
//  Copyright (c) 2014 Stanford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MargueriteRoute : NSObject

@property (assign, nonatomic) NSInteger routeId;
@property (strong, nonatomic) NSString *routeShortName;
@property (strong, nonatomic) NSString *routeLongName;
@property (strong, nonatomic) NSMutableArray *tripIDArray;

@end
