//
//  WeatherForecastItemView.m
//  WeatherDemo
//
//  Created by Kireto on 8/9/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import "WeatherForecastItemView.h"

#import "AirportModel.h"
#import "WeatherModel.h"
#import "WindModel.h"

@interface WeatherForecastItemView ()

@property (nonatomic,strong) UILabel *tempLabel;
@property (nonatomic,strong) UILabel *windLabel;
@property (nonatomic,strong) UILabel *pressureLabel;
@property (nonatomic,strong) UILabel *descLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation WeatherForecastItemView

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
    
    CGRect descLabelFrame = CGRectMake(10.0, 10.0, self.frame.size.width - 10.0, 15.0);
    _descLabel = [self labelWithFrame:descLabelFrame
                        numberOfLines:1
                            labelFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0]
                           labelColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]
                            alignment:NSTextAlignmentLeft
                        andLabelTitle:@""];
    _descLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_descLabel];
    
    CGRect tempLabelFrame = CGRectMake(10.0, 25.0, self.frame.size.width - 20.0, 15.0);
    _tempLabel = [self labelWithFrame:tempLabelFrame
                        numberOfLines:1
                            labelFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0]
                           labelColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]
                            alignment:NSTextAlignmentLeft
                        andLabelTitle:@""];
    _tempLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_tempLabel];
    
    CGRect windLabelFrame = CGRectMake(10.0, 40.0, self.frame.size.width - 20.0, 15.0);
    _windLabel = [self labelWithFrame:windLabelFrame
                        numberOfLines:1
                            labelFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0]
                           labelColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]
                            alignment:NSTextAlignmentLeft
                        andLabelTitle:@""];
    _windLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_windLabel];
    
    CGRect pressureLabelFrame = CGRectMake(10.0, 55.0, self.frame.size.width - 20.0, 15.0);
    _pressureLabel = [self labelWithFrame:pressureLabelFrame
                            numberOfLines:1
                                labelFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0]
                               labelColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]
                                alignment:NSTextAlignmentLeft
                            andLabelTitle:@""];
    _pressureLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_pressureLabel];
    
    CGRect dateLabelFrame = CGRectMake(self.frame.size.width - 100.0, 10.0, 90.0, 20.0);
    _dateLabel = [self labelWithFrame:dateLabelFrame
                        numberOfLines:1
                            labelFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]
                           labelColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]
                            alignment:NSTextAlignmentRight
                        andLabelTitle:@""];
    _dateLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [self addSubview:_dateLabel];
    
    CGRect imageViewFrame = CGRectMake(self.frame.size.width - 50.0, 30, 40.0, 40.0);
    _imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    _pressureLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    _imageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_imageView];
}

- (void)customizeForAirport:(AirportModel*)airport andWeather:(WeatherModel*)weatherModel {
    
    if (weatherModel) {
        [_descLabel setText:[NSString stringWithFormat:@"Now: %@", weatherModel.description]];
        [_tempLabel setText:[NSString stringWithFormat:@"Temperature: %i°C", weatherModel.temperature]];
        [_pressureLabel setText:[NSString stringWithFormat:@"Pressure: %ihPa", weatherModel.pressure]];
        if (airport.currWeather.wind) {
            [_windLabel setText:[NSString stringWithFormat:@"%.1f m/s %@", weatherModel.wind.speed, weatherModel.wind.direction]];
        }
        else {
            [_windLabel setText:@""];
        }
        [_imageView setImage:[UIImage imageNamed:weatherModel.iconName]];
        
        if (weatherModel.date) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"HH:mm"];
            [_dateLabel setText:[formatter stringFromDate:weatherModel.date]];
        }
        else {
            [_dateLabel setText:@""];
        }
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
