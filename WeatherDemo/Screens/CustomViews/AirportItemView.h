//
//  AirportItemView.h
//  WeatherDemo
//
//  Created by Kireto on 8/9/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AirportModel;

@interface AirportItemView : UIView

@property (nonatomic,strong) AirportModel *airport;

- (void)customizeForAirport:(AirportModel*)airport;

@end
