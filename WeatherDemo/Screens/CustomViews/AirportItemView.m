//
//  AirportItemView.m
//  WeatherDemo
//
//  Created by Kireto on 8/9/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import "AirportItemView.h"

#import "AirportModel.h"
#import "WeatherModel.h"
#import "WindModel.h"

@interface AirportItemView ()

@property (nonatomic,strong) UILabel *codeLabel;
@property (nonatomic,strong) UILabel *locationLabel;
@property (nonatomic,strong) UILabel *tempLabel;
@property (nonatomic,strong) UILabel *windLabel;
@property (nonatomic,strong) UILabel *pressureLabel;
@property (nonatomic,strong) UILabel *descLabel;
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation AirportItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setupView {
    
    CGRect codeLabelFrame = CGRectMake(0.0, 15.0, self.frame.size.width, 25.0);
    _codeLabel = [self labelWithFrame:codeLabelFrame
                        numberOfLines:1
                            labelFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0]
                           labelColor:[UIColor colorWithRed:69.0/255.0 green:164.0/255.0 blue:255.0/255.0 alpha:1.0]
                            alignment:NSTextAlignmentCenter
                        andLabelTitle:@""];
    _codeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_codeLabel];
    
    CGRect locationLabelFrame = CGRectMake(0.0, 40.0, self.frame.size.width, 15.0);
    _locationLabel = [self labelWithFrame:locationLabelFrame
                            numberOfLines:1
                                labelFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0]
                               labelColor:[UIColor colorWithRed:69.0/255.0 green:164.0/255.0 blue:255.0/255.0 alpha:1.0]
                                alignment:NSTextAlignmentCenter
                            andLabelTitle:@""];
    _locationLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_locationLabel];
    
    CGRect tempLabelFrame = CGRectMake(10.0, 80.0, self.frame.size.width - 20.0, 15.0);
    _tempLabel = [self labelWithFrame:tempLabelFrame
                        numberOfLines:1
                            labelFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0]
                           labelColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]
                            alignment:NSTextAlignmentLeft
                        andLabelTitle:@""];
    _tempLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_tempLabel];
    
    CGRect windLabelFrame = CGRectMake(10.0, 100.0, self.frame.size.width - 20.0, 15.0);
    _windLabel = [self labelWithFrame:windLabelFrame
                        numberOfLines:1
                            labelFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0]
                           labelColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]
                            alignment:NSTextAlignmentLeft
                        andLabelTitle:@""];
    _windLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_windLabel];
    
    CGRect pressureLabelFrame = CGRectMake(10.0, 120.0, self.frame.size.width - 20.0, 15.0);
    _pressureLabel = [self labelWithFrame:pressureLabelFrame
                            numberOfLines:1
                                labelFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0]
                               labelColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]
                                alignment:NSTextAlignmentLeft
                            andLabelTitle:@""];
    _pressureLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_pressureLabel];
    
    CGRect descLabelFrame = CGRectMake(0.0, self.frame.size.height - 25.0, self.frame.size.width, 15.0);
    _descLabel = [self labelWithFrame:descLabelFrame
                        numberOfLines:1
                            labelFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0]
                           labelColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]
                            alignment:NSTextAlignmentCenter
                        andLabelTitle:@""];
    _descLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:_descLabel];
    
    CGRect imageViewFrame = CGRectMake(self.frame.size.width - 70.0, 80.0, 60.0, 60.0);
    _imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    _imageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_imageView];
}

- (void)customizeForAirport:(AirportModel*)airport {
    
    _airport = airport;
    [_codeLabel setText:airport.code];
    [_locationLabel setText:[NSString stringWithFormat:@"%@, %@", airport.city, airport.country]];
    
    if (airport.currWeather) {
        [_descLabel setText:airport.currWeather.description];
        [_tempLabel setText:[NSString stringWithFormat:@"%i°C", airport.currWeather.temperature]];
        [_pressureLabel setText:[NSString stringWithFormat:@"%ihPa", airport.currWeather.pressure]];
        if (airport.currWeather.wind) {
            [_windLabel setText:[NSString stringWithFormat:@"%.1f m/s %@", airport.currWeather.wind.speed, airport.currWeather.wind.direction]];
        }
        else {
            [_windLabel setText:@""];
        }
        [_imageView setImage:[UIImage imageNamed:airport.currWeather.iconName]];
    }
    else {
        [_descLabel setText:@""];
        [_tempLabel setText:@""];
        [_windLabel setText:@""];
        [_pressureLabel setText:@""];
        [_imageView setImage:nil];
    }
}

- (UILabel*)labelWithFrame:(CGRect)labelFrame
             numberOfLines:(NSUInteger)numberOfLines
                 labelFont:(UIFont*)labelFont
                labelColor:(UIColor*)labelColor
                 alignment:(NSTextAlignment)textAlignment
             andLabelTitle:(NSString*)labelTitle {
    
    UILabel *returnLabel = [[UILabel alloc] initWithFrame:labelFrame];
    returnLabel.backgroundColor = [UIColor clearColor];
    returnLabel.font = labelFont;
    returnLabel.textColor = labelColor;
    returnLabel.textAlignment = textAlignment;
    returnLabel.numberOfLines = numberOfLines;
    returnLabel.text = labelTitle;
    return returnLabel;
}

@end
