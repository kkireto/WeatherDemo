//
//  WeatherNowItemView.h
//  WeatherDemo
//
//  Created by Kireto on 8/9/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AirportModel;
@class WeatherModel;

@interface WeatherNowItemView : UIView

- (void)customizeForAirport:(AirportModel*)airport andWeather:(WeatherModel*)weatherModel;

@end
