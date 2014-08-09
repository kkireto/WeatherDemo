//
//  CommunicationManager.m
//  WeatherDemo
//
//  Created by Kireto on 8/9/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import "CommunicationManager.h"
#import "Constants.h"

#import "AFHTTPRequestOperation.h"

@implementation CommunicationManager

+ (void)nearbyAirportsForLongitude:(float)longitude
                       andLatitude:(float)latitude
                   successCallback:(void (^)(id responseObject)) successCallback
                     errorCallback:(void (^)(NSString *errorMessage)) errorCallback {
    
    NSString *longitudeString = [NSString stringWithFormat:@"%f", longitude];
    NSString *latitudeString = [NSString stringWithFormat:@"%f", latitude];
    NSString *requestURLString = [NSString stringWithFormat:@"%@%@/%@?%@=%@&%@=%@", AIRPORT_SERVICE_BASE_URL, latitudeString, longitudeString, USER_KEY_NAME, USER_KEY_VALUE, MAX_AIRPORTS_NAME, MAX_AIRPORTS_VALUE];
    NSURL *requestURL = [NSURL URLWithString:requestURLString];
    
    [CommunicationManager requestForURL:requestURL
                        successCallback:^(id responseObject) {
                            
                            successCallback(responseObject);
                            
                        } errorCallback:^(NSString *errorMessage) {
                            
                            errorCallback(errorMessage);
                        }];
}

+ (void)currentWeatherForCityName:(NSString*)cityName
                  successCallback:(void (^)(id responseObject)) successCallback
                    errorCallback:(void (^)(NSString *errorMessage)) errorCallback {
    
    NSString *requestURLString = [NSString stringWithFormat:@"%@%@?%@=%@&%@=%@", WEATHER_SERVICE_BASE_URL, WEATHER_SERVICE_NAME, CITY_NAME_SERVICE_NAME, cityName, WEATHER_UNITS_NAME, WEATHER_UNITS_VALUE];
    NSURL *requestURL = [NSURL URLWithString:requestURLString];
    
    [CommunicationManager requestForURL:requestURL
                        successCallback:^(id responseObject) {
                            
                            successCallback(responseObject);
                            
                        } errorCallback:^(NSString *errorMessage) {
                            
                            errorCallback(errorMessage);
                        }];
}

+ (void)forecastWeatherForCityName:(NSString*)cityName
                   successCallback:(void (^)(id responseObject)) successCallback
                     errorCallback:(void (^)(NSString *errorMessage)) errorCallback {
    
    NSString *requestURLString = [NSString stringWithFormat:@"%@%@?%@=%@&%@=%@", WEATHER_SERVICE_BASE_URL, FORECAST_SERVICE_NAME, CITY_NAME_SERVICE_NAME, cityName, WEATHER_UNITS_NAME, WEATHER_UNITS_VALUE];
    NSURL *requestURL = [NSURL URLWithString:requestURLString];
    
    [CommunicationManager requestForURL:requestURL
                        successCallback:^(id responseObject) {
                            
                            successCallback(responseObject);
                            
                        } errorCallback:^(NSString *errorMessage) {
                            
                            errorCallback(errorMessage);
                        }];
}

+ (void)requestForURL:(NSURL*)requestURL
      successCallback:(void (^)(id responseObject)) successCallback
        errorCallback:(void (^)(NSString *errorMessage)) errorCallback {
    
    NSMutableURLRequest *afRequest = [NSMutableURLRequest requestWithURL:requestURL
                                                             cachePolicy:NSURLCacheStorageNotAllowed
                                                         timeoutInterval:15];
    [afRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:afRequest];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"status code %i", (int)[operation.response statusCode]);
        NSError *error;
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        successCallback(jsonData);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        errorCallback([CommunicationManager errorCallbackMessageFor:operation andError:error defaultMessage:@"Action not available"]);
    }];
    [operation start];
}

+ (NSString*)errorCallbackMessageFor:(AFHTTPRequestOperation*)operation
                            andError:(NSError*) error
                      defaultMessage:(NSString*)defaultMessage {
    
    NSLog(@"error:  %@", error);
    NSString *alertMsg = [error localizedRecoverySuggestion];
    NSData *responseData = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
    if (responseData) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        if (jsonData && [jsonData isKindOfClass:[NSDictionary class]]) {
            if ([jsonData valueForKey:@"error"]) {
                if ([[jsonData valueForKey:@"error"] isKindOfClass:[NSString class]]) {
                    alertMsg = [jsonData valueForKey:@"error"];
                }
                else if ([[jsonData valueForKey:@"error"] isKindOfClass:[NSArray class]]) {
                    NSArray *errorArray = [jsonData valueForKey:@"error"];
                    if ([errorArray count] && [[errorArray objectAtIndex:0] isKindOfClass:[NSString class]]) {
                        alertMsg = [errorArray objectAtIndex:0];
                    }
                    errorArray = nil;
                }
            }
        }
    }
    else {
        NSDictionary *errorDict = [error userInfo];
        if (errorDict && [errorDict valueForKey:@"NSLocalizedDescription"]) {
            alertMsg = [errorDict valueForKey:@"NSLocalizedDescription"];
        }
    }
    if (![alertMsg length]) {
        alertMsg = defaultMessage;
    }
    else if ([alertMsg isEqualToString:@"The request timed out."]) {
        alertMsg = @"Your Internet connection is slow. Please try to connect to а faster network.";
    }
    return alertMsg;
}

@end
