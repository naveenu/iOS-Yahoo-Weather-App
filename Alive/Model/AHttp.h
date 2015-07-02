//
//  AHttp.h
//  Alive
//
//  Created by Naveenu Vishwa Prakash P on 26/06/2015.
//  Copyright (c) 2015 Track the Bird. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Location.h"
#import "Forecast.h"

@interface AHttp : NSObject

- (void) getWeatherDetails;

@end
