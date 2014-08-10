//
//  LoadingView.m
//  WeatherDemo
//
//  Created by Kireto on 8/10/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()

@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic,strong) UILabel *loadingLabel;

@end

@implementation LoadingView

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
    
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    self.layer.cornerRadius = 5.0;
    
    CGRect loadingLabelFrame = CGRectMake(0.0, self.frame.size.height - 25.0, self.frame.size.width, 15.0);
    _loadingLabel = [self labelWithFrame:loadingLabelFrame
                           numberOfLines:1
                               labelFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:11.0]
                              labelColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]
                               alignment:NSTextAlignmentCenter
                           andLabelTitle:@"Loading..."];
    _loadingLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:_loadingLabel];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] init];
    CGSize activitySize = _activityIndicator.frame.size;
    _activityIndicator.frame = CGRectMake((self.frame.size.width - activitySize.width)/2, (self.frame.size.height - activitySize.height - _loadingLabel.frame.origin.x)/2, activitySize.width, activitySize.height);
    _activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:_activityIndicator];
    [_activityIndicator startAnimating];
}

- (void)updateLabelText:(NSString*)newText {
    [_loadingLabel setText:newText];
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
