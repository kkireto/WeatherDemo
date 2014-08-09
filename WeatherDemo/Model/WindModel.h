//
//  WindModel.h
//  WeatherDemo
//
//  Created by Kireto on 8/9/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WindModel : NSObject

@property (nonatomic,assign) float speed;
@property (nonatomic,assign) float degrees;
@property (nonatomic,assign) NSString *direction;

- (id)initWithDict:(NSDictionary*)dict;

@end
