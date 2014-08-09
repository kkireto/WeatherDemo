//
//  AirportDetailsViewController.m
//  WeatherDemo
//
//  Created by Kireto on 8/9/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import "AirportDetailsViewController.h"

#import "AirportModel.h"
#import "WeatherModel.h"
#import "WindModel.h"

#import "CommunicationManager.h"
#import "JSONManager.h"
#import "Constants.h"

#import "AirportWeatherForecastCollectionViewCell.h"
#import "AirportWeatherNowCollectionViewCell.h"

#import "WeatherNowItemView.h"
#import "WeatherForecastItemView.h"

@interface AirportDetailsViewController ()

@property (nonatomic,strong) AirportModel* airport;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) BOOL enableRefresh;

@end

@implementation AirportDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithAirport:(AirportModel *)airport
{
    self = [super init];
    if (self) {
        // Custom initialization
        _airport = airport;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [_collectionView registerClass:[AirportWeatherNowCollectionViewCell class] forCellWithReuseIdentifier:@"NowCell"];
    [_collectionView registerClass:[AirportWeatherForecastCollectionViewCell class] forCellWithReuseIdentifier:@"ForecastCell"];
    
    _enableRefresh = YES;
    
    _refreshControl = [[UIRefreshControl alloc] init];
    _refreshControl.tintColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:0.9];
    [_collectionView addSubview:_refreshControl];
    [_refreshControl addTarget:self action:@selector(loadForecast) forControlEvents:UIControlEventValueChanged];
    
    [self loadForecast];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_dataArray) {
        return [_dataArray count];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell;
    WeatherModel *weather = [_dataArray objectAtIndex:indexPath.item];
    if (indexPath.item == 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NowCell" forIndexPath:indexPath];
        AirportWeatherNowCollectionViewCell *nowCell = (AirportWeatherNowCollectionViewCell*)cell;
        [nowCell.itemView customizeForAirport:_airport andWeather:weather];
    }
    else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ForecastCell" forIndexPath:indexPath];
        AirportWeatherForecastCollectionViewCell *forecastCell = (AirportWeatherForecastCollectionViewCell*)cell;
        [forecastCell.itemView customizeForAirport:_airport andWeather:weather];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        return CGSizeMake(320.0, 150.0);
    }
    return CGSizeMake(320.0, 90.0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.view.userInteractionEnabled = NO;
    [self dismissViewControllerAnimated:YES completion:^{
        self.view.userInteractionEnabled = YES;
    }];
}

- (void)setCollectionData {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    else {
        [_dataArray removeAllObjects];
    }
    if (_airport.currWeather) {
        [_dataArray addObject:_airport.currWeather];
    }
    if (_airport.forecastArray && [_airport.forecastArray count]) {
        for (int forecastIndex = 0; forecastIndex < MAX_FORECAST_VALUE; forecastIndex++) {
            WeatherModel *weather = [_airport.forecastArray objectAtIndex:forecastIndex];
            [_dataArray addObject:weather];
        }
    }
    [_collectionView reloadData];
}

#pragma mark - API calls
- (void)loadForecast {
    
    if (_enableRefresh) {
        
        if (_airport.forecastLoadDate) {
            
            NSDate *currTime = [NSDate date];
            NSTimeInterval timeDiff = [currTime timeIntervalSinceDate:_airport.forecastLoadDate];
            if (timeDiff < 10*60) {
                [self setCollectionData];
                [_refreshControl endRefreshing];
                return;
            }
        }
        _enableRefresh = NO;
        
        [CommunicationManager forecastWeatherForCityName:_airport.city
                                         successCallback:^(id responseObject) {
                                             
                                             if (responseObject &&
                                                 [responseObject isKindOfClass:[NSDictionary class]] &&
                                                 [responseObject count]) {
                                                 
                                                 NSDictionary *responseDict = (NSDictionary*)responseObject;
                                                 
                                                 NSArray *responseArray = [JSONManager arrayValueForKey:@"list" fromDictionary:responseDict];
                                                 if (responseArray && [responseArray count]) {
                                                     if (!_airport.forecastArray) {
                                                         _airport.forecastArray = [[NSMutableArray alloc] init];
                                                     }
                                                     for (int forecastIndex = 0; forecastIndex < MAX_FORECAST_VALUE; forecastIndex++) {
                                                         
                                                         NSDictionary *dict = [responseArray objectAtIndex:forecastIndex];
                                                         WeatherModel *weather = [[WeatherModel alloc] initWithDict:dict];
                                                         [_airport.forecastArray addObject:weather];
                                                     }
                                                     [self setCollectionData];
                                                 }
                                             }
                                             _enableRefresh = YES;
                                             
                                         } errorCallback:^(NSString *errorMessage) {
                                             
                                             
                                         }];
    }
    else {
        [self setCollectionData];
        [_refreshControl endRefreshing];
    }
}

@end
