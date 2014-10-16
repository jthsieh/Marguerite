//
//  MARRoutesViewController.m
//  Marguerite
//
//  Created by Tim Hsieh on 10/14/14.
//  Copyright (c) 2014 Stanford. All rights reserved.
//

#import "MARRoutesViewController.h"

#import "MARMargueriteRoute.h"
#import "MARNetworkingService.h"
#import "MARStopsViewController.h"

@interface MARRoutesViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *routes;

@end


@implementation MARRoutesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MARNetworkingService *sharedService = [MARNetworkingService sharedNetworkingService];
    [sharedService getDataWithURL:@"routes"
                          success:^(id responseObject) {
        self.routes = [[NSMutableArray alloc] init];
        
        NSDictionary *dict = responseObject; // Key: string, value: an array of NSDictionaries
        NSArray *results = [dict objectForKey:@"results"]; // Get the array of dictionaries
        for (NSDictionary *routeInfo in results) {
            MARMargueriteRoute *route = [[MARMargueriteRoute alloc] initWithId:[routeInfo[@"route_id"] integerValue]
                                                                      longName:routeInfo[@"route_long_name"]];
            [self.routes addObject:route]; // Add to the array routes
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.routes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"routeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    MARMargueriteRoute *route = [self.routes objectAtIndex:indexPath.row]; // Get the route at the given index
    [cell.textLabel setText:route.routeLongName]; // Label cell
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    MARStopsViewController *stopsViewController = segue.destinationViewController;
    
    MARMargueriteRoute *route = [self.routes objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    [stopsViewController setRouteId:route.routeId];
    [stopsViewController setTitle:route.routeLongName];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}


@end
