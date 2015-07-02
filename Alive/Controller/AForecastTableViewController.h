//
//  AForecastTableViewController.h
//  Alive
//
//  Created by Naveenu Vishwa Prakash P on 26/06/2015.
//  Copyright (c) 2015 Track the Bird. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ForecastCell.h"
#import "Forecast.h"
#import "Location.h"
#import "Utils.h"

@interface AForecastTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>{
    
}

@property (nonatomic,strong) NSManagedObjectContext* context;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSString* selectedLocation;

- (IBAction)navigateBack:(id)sender;

@end
