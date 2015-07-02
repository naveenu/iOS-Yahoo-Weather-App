//
//  LocationCell.h
//  Alive
//
//  Created by Naveenu Vishwa Prakash P on 26/06/2015.
//  Copyright (c) 2015 Track the Bird. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lLocationName;
@property (weak, nonatomic) IBOutlet UILabel *lWeatherUpdatedDateAndTime;
@property (weak, nonatomic) IBOutlet UILabel *lPlace;
@property (weak, nonatomic) IBOutlet UILabel *lWeatherTitle;
@property (weak, nonatomic) IBOutlet UILabel *lSunriseTime;
@property (weak, nonatomic) IBOutlet UILabel *lSunsetTime;
@property (weak, nonatomic) IBOutlet UILabel *lPresentWeatherCondition;
@property (weak, nonatomic) IBOutlet UILabel *lTemperature;
@property (weak, nonatomic) IBOutlet UILabel *lHumidity;
@property (weak, nonatomic) IBOutlet UILabel *lWindSpeed;
@property (weak, nonatomic) IBOutlet UILabel *lPressure;
@property (weak, nonatomic) IBOutlet UIImageView *ivPresentWeatherStateIcon;
@property (weak, nonatomic) IBOutlet UIImageView *ivSunriseIcon;
@property (weak, nonatomic) IBOutlet UIImageView *lSunsetIcon;
@property (weak, nonatomic) IBOutlet UIImageView *lTemperatureIcon;

@end
