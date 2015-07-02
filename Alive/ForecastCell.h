//
//  ForecastCell
//  Alive
//
//  Created by Naveenu Vishwa Prakash P on 26/06/2015.
//  Copyright (c) 2015 Track the Bird. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lDayDateAndTime;
@property (weak, nonatomic) IBOutlet UILabel *lWeatherCondition;
@property (weak, nonatomic) IBOutlet UILabel *lHighTemparature;
@property (weak, nonatomic) IBOutlet UILabel *lLowTemparature;

@property (weak, nonatomic) IBOutlet UIImageView *ivWeatherIcon;
@property (weak, nonatomic) IBOutlet UIImageView *lHighTemparatureIcon;
@property (weak, nonatomic) IBOutlet UIImageView *lLowTemparatureIcon;

@property (weak, nonatomic) IBOutlet UILabel *lLocation;


@end
