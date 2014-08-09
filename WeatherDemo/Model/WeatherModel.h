//
//  WeatherModel.h
//  WeatherDemo
//
//  Created by Kireto on 8/9/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WindModel;

@interface WeatherModel : NSObject

@property (nonatomic,strong) NSString *mainDesc;
@property (nonatomic,strong) NSString *description;
@property (nonatomic,strong) NSString *iconName;
@property (nonatomic,strong) NSDate *date;
@property (nonatomic,assign) int temperature;
@property (nonatomic,assign) int pressure;
@property (nonatomic,assign) int cityId;
@property (nonatomic,strong) WindModel *wind;

- (id)initWithDict:(NSDictionary*)dict;

@end
