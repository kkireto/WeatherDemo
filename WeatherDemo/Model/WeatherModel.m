//
//  WeatherModel.m
//  WeatherDemo
//
//  Created by Kireto on 8/9/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import "WeatherModel.h"
#import "WindModel.h"
#import "JSONManager.h"

@implementation WeatherModel

- (id)initWithDict:(NSDictionary*)dict {
    
    self = [super init];
    if (self) {
        
        NSDictionary *windDict = [JSONManager dictValueForKey:@"wind" fromDictionary:dict];
        if (windDict) {
            self.wind = [[WindModel alloc] initWithDict:windDict];
        }
        NSArray *weatherArray = [JSONManager arrayValueForKey:@"weather" fromDictionary:dict];
        if (weatherArray && [weatherArray count]) {
            NSDictionary *weatherDict = [weatherArray objectAtIndex:0];
            if (weatherDict) {
                self.mainDesc = [JSONManager stringValueForKey:@"main" fromDictionary:weatherDict];
                self.description = [JSONManager stringValueForKey:@"description" fromDictionary:weatherDict];
                self.iconName = [JSONManager stringValueForKey:@"icon" fromDictionary:weatherDict];
            }
        }
        NSDictionary *mainDict = [JSONManager dictValueForKey:@"main" fromDictionary:dict];
        if (mainDict) {
            self.temperature = [JSONManager intValueForKey:@"temp" fromDictionary:mainDict];
            self.pressure = [JSONManager intValueForKey:@"pressure" fromDictionary:mainDict];
        }
        self.date = [JSONManager dateValueFromTimeIntervalForKey:@"dt" fromDictionary:dict];
        self.cityId = [JSONManager intValueForKey:@"id" fromDictionary:dict];
    }
    return self;
}

@end
