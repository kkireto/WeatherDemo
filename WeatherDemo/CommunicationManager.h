//
//  CommunicationManager.h
//  WeatherDemo
//
//  Created by Kireto on 8/9/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunicationManager : NSObject

+ (void)nearbyAirportsForLongitude:(float)longitude
                       andLatitude:(float)latitude
                   successCallback:(void (^)(id responseObject)) successCallback
                     errorCallback:(void (^)(NSString *errorMessage)) errorCallback;
+ (void)currentWeatherForCityName:(NSString*)cityName
                  successCallback:(void (^)(id responseObject)) successCallback
                    errorCallback:(void (^)(NSString *errorMessage)) errorCallback;
+ (void)forecastWeatherForCityName:(NSString*)cityName
                   successCallback:(void (^)(id responseObject)) successCallback
                     errorCallback:(void (^)(NSString *errorMessage)) errorCallback;

@end
