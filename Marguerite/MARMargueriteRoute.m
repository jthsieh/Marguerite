//
//  MARMargueriteRoute.m
//  Marguerite
//
//  Created by Tim Hsieh on 10/14/14.
//  Copyright (c) 2014 Stanford. All rights reserved.
//

#import "MARMargueriteRoute.h"

@implementation MARMargueriteRoute

- (instancetype)initWithId:(NSInteger)routeId longName:(NSString *)longName
{
    self = [super init];
    if (self) {
        self.routeId = routeId;
        self.routeLongName = longName;
    }
    return self;
}

@end
