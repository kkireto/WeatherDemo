//
//  AirportDetailsViewController.h
//  WeatherDemo
//
//  Created by Kireto on 8/9/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AirportModel;

@interface AirportDetailsViewController : UIViewController

@property (nonatomic,weak) IBOutlet UICollectionView *collectionView;

- (id)initWithAirport:(AirportModel *)airport;

@end
