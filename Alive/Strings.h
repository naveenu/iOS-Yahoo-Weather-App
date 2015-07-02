//
//  Strings.h
//  Alive
//
//  Created by Naveenu Vishwa Prakash P on 26/06/2015.
//  Copyright (c) 2015 Track the Bird. All rights reserved.
//

#ifndef Alive_Strings_h
#define Alive_Strings_h

// Application Title
#define WEATHER_APPLICATION                     "Weather app"



// Destination URL'S

#define YAHOO_WEATHER_URL                       "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%"
// Weather locations
#define SYDNEY_WEATHER_CDOE                     "3D1105779"
#define MOSMAN_WEATHER_CDOE                     "3D1107134"
#define JAPAN_WEATHER_CDOE                      "3D1107765"
#define SA_WEATHER_CDOE                         "3D1100012"

#define OUTPUT_FORMAT                           "&format=json"

// Weather related strings
#define PRESSURE                                "Pressure"
#define HUMIDITY                                "Humidity"
#define WIND_SPEED                              "Wind Speed"

// Yahoo network check URL
#define YAHOO_WEB_URL                           "https://www.yahoo.com/"

// Validation message
#define NO_INTERNET_CONNECTION                  "Sorry..There IS NO internet connection...Can't get weather forecast data.."

#endif
