//
//  AForecastTableViewController.m
//  Alive
//
//  Created by Naveenu Vishwa Prakash P on 26/06/2015.
//  Copyright (c) 2015 Track the Bird. All rights reserved.
//

#import "AForecastTableViewController.h"

@interface AForecastTableViewController ()

@end

@implementation AForecastTableViewController

@synthesize fetchedResultsController    =   _fetchedResultsController;
@synthesize context;
@synthesize selectedLocation;

- (void)initialize{
    AppDelegate *appDelegate    =   [[UIApplication sharedApplication] delegate];
    context                     =   [appDelegate managedObjectContext];
    //Set Title
    self.title                  =   [NSString stringWithFormat:@"%@ weather", selectedLocation];
}

- (void)initFetchResultController{
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initilize the variables
    [self initialize];

    // Initialize Fetch result view controller
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
    return 104;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //return 1;
    id  sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (void) configureCell:(ForecastCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Forecast    *forcastInfo        =   [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.lDayDateAndTime.text       = [NSString stringWithFormat:@"%@, %@",forcastInfo.day,[Utils getFormattedStringDate:(NSDate *)forcastInfo.date]];
    cell.lWeatherCondition.text     = [NSString stringWithFormat:@"%@",forcastInfo.text];
    cell.lHighTemparature.text      = [NSString stringWithFormat:@"%@˙F",forcastInfo.high];
    cell.lLowTemparature.text       = [NSString stringWithFormat:@"%@˙F",forcastInfo.low];
    cell.ivWeatherIcon.image        = [Utils getWeatherIcon:(int) [forcastInfo.code intValue]];
    cell.lLocation.text             = [NSString stringWithFormat:@"%@",forcastInfo.forecastLocation];
}

// Display weather forcast using tableview
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    @try {
        //Define Cell identifier
        static NSString *cellIdentifier             =  @"forecastCell";
        ForecastCell *weatherDetailsCell     =  nil;
        weatherDetailsCell                          =  (ForecastCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!weatherDetailsCell){
            weatherDetailsCell                      =  [[ForecastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [self configureCell:weatherDetailsCell atIndexPath:indexPath];
        return weatherDetailsCell;
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
    NSDate  *cutOffDate             =  [self getCutOffDate];
    NSFetchRequest *fetchRequest    = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity     = [NSEntityDescription
                                   entityForName:@"Forecast" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"(forecastLocation == %@) AND (date >= %@)", selectedLocation, cutOffDate];
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"date" ascending:YES];
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
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(ForecastCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
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

//Navigate back
- (IBAction)navigateBack:(id)sender {
    UIStoryboard *storyboard    = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UIViewController * vc       = [storyboard instantiateViewControllerWithIdentifier:@"navigationLocation"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (NSDate *)getCutOffDate{
    NSDate *today               = [NSDate date];
    NSDate *cutOffDate          = [today dateByAddingTimeInterval: - 86400.0];
    return cutOffDate;
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
