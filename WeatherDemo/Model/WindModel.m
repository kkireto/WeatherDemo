//
//  WindModel.m
//  WeatherDemo
//
//  Created by Kireto on 8/9/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import "WindModel.h"
#import "JSONManager.h"

@implementation WindModel

- (id)initWithDict:(NSDictionary*)dict {
    
    self = [super init];
    if (self) {
        self.speed = [JSONManager doubleValueForKey:@"speed" fromDictionary:dict];
        self.degrees = [JSONManager doubleValueForKey:@"deg" fromDictionary:dict];
        [self calculateDirection];
    }
    return self;
}

- (void)calculateDirection {
    if (self.degrees < 22.5) {
        self.direction = @"N";
    }
    else if (self.degrees < 67.5) {
        self.direction = @"NE";
    }
    else if (self.degrees < 112.5) {
        self.direction = @"E";
    }
    else if (self.degrees < 157.5) {
        self.direction = @"SE";
    }
    else if (self.degrees < 202.5) {
        self.direction = @"S";
    }
    else if (self.degrees < 247.5) {
        self.direction = @"SW";
    }
    else if (self.degrees < 292.5) {
        self.direction = @"W";
    }
    else if (self.degrees < 337.5) {
        self.direction = @"NW";
    }
    else {
        self.direction = @"N";
    }
}

@end
