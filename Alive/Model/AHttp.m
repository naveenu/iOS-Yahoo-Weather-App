//
//  AHttp.m
//  Alive
//
//  Created by Naveenu Vishwa Prakash P on 26/06/2015.
//  Copyright (c) 2015 Track the Bird. All rights reserved.
//

#import "AHttp.h"
#import "Strings.h"

@implementation AHttp

    /* Background thread which downloads the weather data from yahoo server */
- (void) getWeatherDetails{
    NSArray *locationCodeArray      =   [NSArray arrayWithObjects:@SYDNEY_WEATHER_CDOE,@MOSMAN_WEATHER_CDOE,@JAPAN_WEATHER_CDOE,@SA_WEATHER_CDOE, nil];
    NSOperationQueue *queue =       [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 2;
    for (NSString* locationCode in locationCodeArray)
    {
        __block NSError *error;
        NSURL *url       =   [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",@YAHOO_WEATHER_URL,locationCode,@OUTPUT_FORMAT]];
        [queue addOperationWithBlock:^{
            NSData *data = [NSData dataWithContentsOfURL:url];
            NSDictionary *response     =   [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            [self saveWeatherData:(NSDictionary *)response];
        }];
    }
}

    /*  Save downlaed weather data into disk    */
- (void) saveWeatherData:(NSDictionary *) weatherDataDict{
    NSString    *location;
    NSError *error;
    Location *locationObject;
    AppDelegate *appDelegate            =   [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext  *context    =   [appDelegate managedObjectContext];
    // Get and Set weather location
    location                            =   [[[[[weatherDataDict objectForKey:@"query"] objectForKey:@"results"]
                                                                   objectForKey:@"channel"] objectForKey:@"location"] objectForKey:@"city"];
    
    NSFetchRequest *request             = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
    NSPredicate *predicate              = [NSPredicate predicateWithFormat:@"weatherLocation == %@", location];
    [request setPredicate:predicate];
    NSUInteger count                    = [context countForFetchRequest:request error:&error];
    if (count == NSNotFound){
        NSLog(@"Reading error");
    }
    else if (count == 0){
        // no matching object
        locationObject                  =   [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:context];
    }
    else{
        // at least one matching object exists
        locationObject                  = [[context executeFetchRequest:request error:&error] objectAtIndex:0];
    }
    
    // Get Last updated
    locationObject.updatedDateAndTime                   =   [[[[weatherDataDict objectForKey:@"query"] objectForKey:@"results"]
                                                              objectForKey:@"channel"] objectForKey:@"lastBuildDate"];
    //NSLog(@"Last updated time %@",lastUpdatedDateAndTime);
    // Get Description
    locationObject.weatherDescription                   =   [[[[weatherDataDict objectForKey:@"query"] objectForKey:@"results"]
                                                              objectForKey:@"channel"] objectForKey:@"description"];
    
    // Get current condition text
    locationObject.currentConditionMessage              =   [[[[[[weatherDataDict objectForKey:@"query"] objectForKey:@"results"]
                                                              objectForKey:@"channel"] objectForKey:@"item"] objectForKey:@"condition"] objectForKey:@"text"];
    // Current temperature
    locationObject.currentTemperature                   = [NSNumber numberWithFloat:[[[[[[[weatherDataDict objectForKey:@"query"] objectForKey:@"results"]
                                                                                           objectForKey:@"channel"] objectForKey:@"item"] objectForKey:@"condition"] objectForKey:@"temp"] floatValue]];
    
    // Current temperature
    locationObject.code                                 =   [NSNumber numberWithInt:[[[[[[[weatherDataDict objectForKey:@"query"] objectForKey:@"results"]
                                                                                     objectForKey:@"channel"] objectForKey:@"item"] objectForKey:@"condition"] objectForKey:@"code"] intValue]];
    // Get current humidity
    locationObject.humidity                             =   [NSNumber numberWithFloat:[[[[[[weatherDataDict objectForKey:@"query"] objectForKey:@"results"]
                                                                                     objectForKey:@"channel"] objectForKey:@"atmosphere"] objectForKey:@"humidity"] floatValue]];
 
    // Get current Pressure
    locationObject.pressure                             =   [NSNumber numberWithFloat:[[[[[[weatherDataDict objectForKey:@"query"] objectForKey:@"results"]
                                                                                       objectForKey:@"channel"] objectForKey:@"atmosphere"] objectForKey:@"pressure"] floatValue]];
    
    // Get current Windspeed
    locationObject.windSpeed                            =   [NSNumber numberWithFloat:[[[[[[weatherDataDict objectForKey:@"query"] objectForKey:@"results"]
                                                                                       objectForKey:@"channel"] objectForKey:@"wind"] objectForKey:@"speed"] floatValue]];
    
    // Get present weather title
    locationObject.currentWeatherTitle                  =   [[[[[weatherDataDict objectForKey:@"query"] objectForKey:@"results"]
                                                               objectForKey:@"channel"] objectForKey:@"item"] objectForKey:@"title"];
    
    // Get and Set Sunrise time
    locationObject.sunriseTime                          =   [[[[[weatherDataDict objectForKey:@"query"] objectForKey:@"results"]
                                                               objectForKey:@"channel"] objectForKey:@"astronomy"] objectForKey:@"sunrise"];
    // Get unset time
    locationObject.sunsetTime                           =   [[[[[weatherDataDict objectForKey:@"query"] objectForKey:@"results"]
                                                               objectForKey:@"channel"] objectForKey:@"astronomy"] objectForKey:@"sunset"];
    
    locationObject.weatherLocation                      =   location;
    
    
    NSMutableArray  *weatherForecastDataMutableArray    =   [[[[[weatherDataDict objectForKey:@"query"] objectForKey:@"results"]
                                                               objectForKey:@"channel"] objectForKey:@"item"] objectForKey:@"forecast"];
    for(int i=0; i<[weatherForecastDataMutableArray count]; i++){
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd LLLL yyyy"];
        NSDate *date = [dateFormat dateFromString:[weatherForecastDataMutableArray[i] objectForKey:@"date"]];
        Forecast    *forecastInfo;
        NSFetchRequest *requestForecast = [NSFetchRequest fetchRequestWithEntityName:@"Forecast"];
        NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"date == %@ && forecastLocation== %@", date, location];
        [requestForecast setPredicate:predicate];
        NSUInteger countForecast = [context countForFetchRequest:requestForecast error:&error];
        if (countForecast == NSNotFound){
            NSLog(@"reading error");
        }
        else if (countForecast == 0){
            forecastInfo          =   [NSEntityDescription insertNewObjectForEntityForName:@"Forecast" inManagedObjectContext:context];
        }
        else{
            forecastInfo          = [[context executeFetchRequest:requestForecast error:&error] objectAtIndex:0];
        }
        forecastInfo.code    =   [NSNumber numberWithInt:[[weatherForecastDataMutableArray[i] objectForKey:@"code"] intValue]];
        forecastInfo.day     =   [NSString stringWithFormat:@"%@",[weatherForecastDataMutableArray[i] objectForKey:@"day"]];
        forecastInfo.date    =   date;
        forecastInfo.high    =   [NSNumber numberWithInt:[[weatherForecastDataMutableArray[i] objectForKey:@"high"] intValue]];
        forecastInfo.low     =   [NSNumber numberWithInt:[[weatherForecastDataMutableArray[i] objectForKey:@"low"] intValue]];
        forecastInfo.text    =   [weatherForecastDataMutableArray[i] objectForKey:@"text"];
        forecastInfo.forecastLocation    =   location;
        locationObject.forecastInfo      =   forecastInfo;
    }
    //Save the context/Data into Core Data
    [context save:&error];
}

@end
