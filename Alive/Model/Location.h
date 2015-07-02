//
//  Location.h
//  
//
//  Created by Naveenu Vishwa Prakash P on 26/06/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Forecast;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSString * updatedDateAndTime;
@property (nonatomic, retain) NSString * weatherDescription;
@property (nonatomic, retain) NSString * currentConditionMessage;
@property (nonatomic, retain) NSNumber * currentTemperature;
@property (nonatomic, retain) NSNumber * code;
@property (nonatomic, retain) NSNumber * humidity;
@property (nonatomic, retain) NSNumber * pressure;
@property (nonatomic, retain) NSNumber * windSpeed;
@property (nonatomic, retain) NSString * currentWeatherTitle;
@property (nonatomic, retain) NSString * sunriseTime;
@property (nonatomic, retain) NSString * sunsetTime;
@property (nonatomic, retain) NSString * weatherLocation;
@property (nonatomic, retain) Forecast *forecastInfo;

@end
