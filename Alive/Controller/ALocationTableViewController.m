//
//  ALocationTableViewController.m
//  Alive
//
//  Created by Naveenu Vishwa Prakash P on 26/06/2015.
//  Copyright (c) 2015 Track the Bird. All rights reserved.
//

#import "ALocationTableViewController.h"

@interface ALocationTableViewController ()

@end

@implementation ALocationTableViewController

@synthesize fetchedResultsController    =   _fetchedResultsController;
@synthesize context;
/*    Initialize  */
- (void)initialize{
    AppDelegate *appDelegate    =   [[UIApplication sharedApplication] delegate];
    context                     =   [appDelegate managedObjectContext];
    
    //Set Title
    self.title                  =   @WEATHER_APPLICATION;
}

/*    Initialize  initFetchResultController */
- (void)initFetchResultController{
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initilize
    [self initialize];
    
    // Init Fetch Resultview controller
    [self initFetchResultController];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.fetchedResultsController = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}
// Set Table View Cell height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 244;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id  sectionInfo         =   [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (void) configureCell:(LocationCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Location    *locationInfo                   =   [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.lWeatherUpdatedDateAndTime.text        =   [NSString stringWithFormat:@"Last updated time : %@",locationInfo.updatedDateAndTime];
    cell.lPlace.text                            =   locationInfo.weatherLocation;
    cell.lWeatherTitle.text                     =   locationInfo.currentWeatherTitle;
    cell.lSunriseTime.text                      =   locationInfo.sunriseTime;
    cell.lSunsetTime.text                       =   locationInfo.sunsetTime;
    cell.lPresentWeatherCondition.text          =   locationInfo.currentConditionMessage;
    cell.lTemperature.text                      =   [NSString stringWithFormat:@"%@˙F",locationInfo.currentTemperature];
    cell.lHumidity.text                         =   [NSString stringWithFormat:@"%@ : %@",@HUMIDITY,    locationInfo.humidity];
    cell.lWindSpeed.text                        =   [NSString stringWithFormat:@"%@ : %@mph",@WIND_SPEED,  locationInfo.windSpeed];
    cell.lPressure.text                         =   [NSString stringWithFormat:@"%@ : %@in",@PRESSURE,    locationInfo.pressure];
    cell.ivPresentWeatherStateIcon.image        =   [Utils getWeatherIcon:[locationInfo.code intValue]];
}

// Display weather forcast using tableview
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    @try {
        //Define Cell identifier
        static NSString *cellIdentifier             =  @"locationCell";
        LocationCell *weatherLocationCell           =  nil;
        weatherLocationCell                          =  (LocationCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!weatherLocationCell){
            weatherLocationCell                      =  [[LocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [self configureCell:weatherLocationCell atIndexPath:indexPath];
        return weatherLocationCell;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // Deselect selected item
}

#pragma mark - fetchedResultsController
- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest    = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity     = [NSEntityDescription
                                       entityForName:@"Location" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"weatherLocation" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:context sectionNameKeyPath:nil
                                                   cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView                      = self.tableView;
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(LocationCell *)[tableView cellForRowAtIndexPath:indexPath]  atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"forecastSegue"]){
        AForecastTableViewController *forecastTableViewController = segue.destinationViewController;
        LocationCell *cell = (LocationCell *)sender;
        forecastTableViewController.selectedLocation    =   cell.lPlace.text;
    }
}
@end
