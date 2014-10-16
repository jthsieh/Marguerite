//
//  MARMargueriteRoute.h
//  Marguerite
//
//  Created by Tim Hsieh on 10/14/14.
//  Copyright (c) 2014 Stanford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MARMargueriteRoute : NSObject

@property (assign, nonatomic) NSInteger routeId;
@property (strong, nonatomic) NSString *routeLongName;
//@property (strong, nonatomic) NSMutableArray *tripIDArray;

- (instancetype)initWithId:(NSInteger)routeId longName:(NSString *)longName;


@end
