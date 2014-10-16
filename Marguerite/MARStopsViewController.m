//
//  MARStopsViewController.m
//  Marguerite
//
//  Created by Tim Hsieh on 10/15/14.
//  Copyright (c) 2014 Stanford. All rights reserved.
//

#import "MARStopsViewController.h"

#import "MARMargueriteRoute.h"
#import "MARMargueriteStops.h"
#import "MARNetworkingService.h"

@interface MARStopsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) NSInteger tripId;
@property (strong, nonatomic) NSMutableArray *stops;

@end


@implementation MARStopsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stops = [[NSMutableArray alloc] init];
    MARMargueriteStops *MARStops = [[MARMargueriteStops alloc] initWithData];
    
    // Get one trip of that route
    MARNetworkingService *sharedService = [MARNetworkingService sharedNetworkingService];
    [sharedService getDataWithURL:@"trips" success:^(id responseObject) {
        
        NSDictionary *dict = responseObject;
        NSArray *allTrips = [dict objectForKey:@"results"];
        for (NSDictionary *trip in allTrips) {
            if ([trip[@"route_id"] integerValue] == self.routeId) {
                self.tripId = [trip[@"trip_id"] integerValue];
                break;
            }
        }

    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                        message:[NSString stringWithFormat:@"Problem found: %@", error.localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        [alert show];
    }];
    
    
    // Get all the stops
    [sharedService getDataWithURL:@"stop_times" success:^(id responseObject) {
        
        NSDictionary *dict = responseObject;
        NSArray *allStops = [dict objectForKey:@"results"];
        for (NSDictionary *stop in allStops) {
            if ([stop[@"trip_id"] integerValue] == self.tripId) {
                NSString *name = [MARStops.stops objectForKey:stop[@"stop_id"]];
                [self.stops addObject:name];
            }
        }
        
    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                        message:[NSString stringWithFormat:@"Problem found: %@", error.localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        [alert show];
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.stops count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"stopCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *label = [self.stops objectAtIndex:indexPath.row];
    [cell.textLabel setText:label];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
