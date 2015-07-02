//
//  Utils.m
//  Alive
//
//  Created by Naveenu Vishwa Prakash P on 27/06/2015.
//  Copyright (c) 2015 Track the Bird. All rights reserved.
//

#import "Utils.h"

@implementation Utils


// Gets formatted string Date.
+ (NSString *) getFormattedStringDate:(NSDate *) date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd LLLL yyyy"];
    return[dateFormat stringFromDate:date];
}

// Get appropriate weather Icon
+ (UIImage *) getWeatherIcon:(int) code{
    UIImage   *icon =   [[UIImage alloc] init];
    
    switch (code) {
        case 2:
        case 4:
        case 11:
        case 12:
        case 37:
        case 38:
        case 39:
        case 40:
            // Rain
            icon    =   [UIImage imageNamed:@"rain"];
            break;
        case 16:
            // snow
            icon    =   [UIImage imageNamed:@"snow"];
            break;
        case 27:
            //  mostly cloudy (night)
            icon    =   [UIImage imageNamed:@"partly_cloudy_night"];
            break;
        case 29:
            //  partly cloudy (night)
            icon    =   [UIImage imageNamed:@"partly_cloudy_night"];
            break;
        case 30:
            //  partly cloudy (day)
            icon    =   [UIImage imageNamed:@"partly_cloudy"];
            break;
        case 31:
            //  clear night
            icon    =   [UIImage imageNamed:@"clear_night"];
            break;
        case 32:
            //  Sunny (day)
            icon    =   [UIImage imageNamed:@"clear_day"];
            break;
        case 34:
            //  Mostly Sunny (day)
            icon    =   [UIImage imageNamed:@"clear_day"];
            break;
        default:
            //Default
            icon    =   [UIImage imageNamed:@"weather"];
            break;
    }
    return icon;
}


@end
