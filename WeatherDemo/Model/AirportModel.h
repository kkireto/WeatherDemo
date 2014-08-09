//
//  AirportModel.h
//  WeatherDemo
//
//  Created by Kireto on 8/9/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WeatherModel;

@interface AirportModel : NSObject

@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *country;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *timezone;
@property (nonatomic,strong) NSDate *forecastLoadDate;
@property (nonatomic,assign) float lat;
@property (nonatomic,assign) float lon;
@property (nonatomic,strong) WeatherModel *currWeather;
@property (nonatomic,strong) NSMutableArray *forecastArray;

- (id)initWithDict:(NSDictionary*)dict;

@end
