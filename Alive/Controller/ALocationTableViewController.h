//
//  ALocationTableViewController.h
//  Alive
//
//  Created by Naveenu Vishwa Prakash P on 26/06/2015.
//  Copyright (c) 2015 Track the Bird. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ForecastCell.h"
#import "LocationCell.h"
#import "Forecast.h"
#import "Location.h"
#import "Strings.h"
#import "AHttp.h"
#import "AForecastTableViewController.h"
#import "Utils.h"

@interface ALocationTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) AHttp *aHttp;
@property (nonatomic,strong) NSManagedObjectContext* context;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
