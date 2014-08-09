//
//  AirportWeatherForecastCollectionViewCell.m
//  WeatherDemo
//
//  Created by Kireto on 8/9/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import "AirportWeatherForecastCollectionViewCell.h"
#import "WeatherForecastItemView.h"

#define item_width 300
#define item_height 80

@implementation AirportWeatherForecastCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (!_itemView) {
            _itemView = [[WeatherForecastItemView alloc] initWithFrame:CGRectMake((self.contentView.frame.size.width - item_width)/2, (self.contentView.frame.size.height - item_height)/2, item_width, item_height)];
            _itemView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
            
            _itemView.backgroundColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:0.9];
            _itemView.layer.cornerRadius = 4.0;
            [self.contentView addSubview:_itemView];
        }
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

@end
