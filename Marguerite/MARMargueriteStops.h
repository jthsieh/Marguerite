//
//  MARMargueriteStops.h
//  Marguerite
//
//  Created by Tim Hsieh on 10/16/14.
//  Copyright (c) 2014 Stanford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MARMargueriteStops : NSObject

@property (strong, nonatomic) NSMutableDictionary *stops;

- (instancetype)initWithData;

@end
