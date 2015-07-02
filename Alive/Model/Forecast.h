//
//  Forecast.h
//  
//
//  Created by Naveenu Vishwa Prakash P on 26/06/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Location;

@interface Forecast : NSManagedObject

@property (nonatomic, retain) NSNumber * code;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * day;
@property (nonatomic, retain) NSNumber * high;
@property (nonatomic, retain) NSNumber * low;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * forecastLocation;
@property (nonatomic, retain) NSSet *locationInfo;
@end

@interface Forecast (CoreDataGeneratedAccessors)

- (void)addLocationInfoObject:(Location *)value;
- (void)removeLocationInfoObject:(Location *)value;
- (void)addLocationInfo:(NSSet *)values;
- (void)removeLocationInfo:(NSSet *)values;

@end
