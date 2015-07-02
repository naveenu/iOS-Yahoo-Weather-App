//
//  Utils.h
//  Alive
//
//  Created by Naveenu Vishwa Prakash P on 27/06/2015.
//  Copyright (c) 2015 Track the Bird. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+ (NSString *)  getFormattedStringDate:(NSDate *) date;
+ (UIImage *)   getWeatherIcon:(int) code;

@end
