//
//  AirportModel.m
//  WeatherDemo
//
//  Created by Kireto on 8/9/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import "AirportModel.h"
#import "JSONManager.h"

@implementation AirportModel

- (id)initWithDict:(NSDictionary*)dict {
    
    self = [super init];
    if (self) {
        self.city = [JSONManager stringValueForKey:@"city" fromDictionary:dict];
        self.code = [JSONManager stringValueForKey:@"code" fromDictionary:dict];
        self.country = [JSONManager stringValueForKey:@"country" fromDictionary:dict];
        self.name = [JSONManager stringValueForKey:@"name" fromDictionary:dict];
        self.timezone = [JSONManager stringValueForKey:@"timezone" fromDictionary:dict];
        self.lat = [JSONManager doubleValueForKey:@"timezone" fromDictionary:dict];
        self.lon = [JSONManager doubleValueForKey:@"timezone" fromDictionary:dict];
    }
    return self;
}

@end