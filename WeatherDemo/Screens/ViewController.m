//
//  ViewController.m
//  WeatherDemo
//
//  Created by Kireto on 8/9/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import "ViewController.h"

#import "Constants.h"
#import "CommunicationManager.h"

#import "AirportModel.h"
#import "WeatherModel.h"
#import "WindModel.h"
#import "JSONManager.h"

#import "AirportCollectionViewCell.h"
#import "AirportItemView.h"

#import "AirportDetailsViewController.h"

#import "LoadingView.h"

#define item_width 150
#define item_height 180

@interface ViewController ()

@property (nonatomic,strong) LoadingView *loadingView;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (nonatomic,strong) NSMutableArray *airportsArray;
@property (nonatomic,strong) NSDate *lastRefreshTime;
@property (nonatomic,assign) NSUInteger airportIndex;
@property (nonatomic,assign) BOOL enableRefresh;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [_collectionView registerClass:[AirportCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    _enableRefresh = YES;
    
    _refreshControl = [[UIRefreshControl alloc] init];
    _refreshControl.tintColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:0.9];
    [_collectionView addSubview:_refreshControl];
    [_refreshControl addTarget:self action:@selector(reloadWeatherForAirports) forControlEvents:UIControlEventValueChanged];
    
    _airportIndex = 0;
    [self loadNearbyAirports];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_airportsArray) {
        return [_airportsArray count];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat topMargin = 0;
    if (indexPath.item == 0 || indexPath.item == 1) {
        topMargin = 30.0;
    }
    AirportCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.itemView.frame = CGRectMake((cell.contentView.frame.size.width - item_width)/2, topMargin + (cell.contentView.frame.size.height - item_height - topMargin)/2, item_width, item_height);
    cell.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    AirportModel *airport = [_airportsArray objectAtIndex:indexPath.item];
    [cell.itemView customizeForAirport:airport];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0 || indexPath.item == 1) {
        return CGSizeMake(160.0, 230.0);
    }
    return CGSizeMake(160.0, 200.0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.view.userInteractionEnabled = NO;
    AirportModel *airport = [_airportsArray objectAtIndex:indexPath.item];
    AirportDetailsViewController *controller = [[AirportDetailsViewController alloc] initWithAirport:airport];
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:controller animated:YES completion:^{
        self.view.userInteractionEnabled = YES;
    }];
}

#pragma mark - API calls
- (void)loadNearbyAirports {
    
    CLLocationManager *locationManager=[[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    CLLocation *location = [locationManager location];
    NSLog(@"latitude:%f and longitude:%f", location.coordinate.longitude, location.coordinate.latitude);
    
    if (location) {
        [self addLoadingMask];
        [_loadingView updateLabelText:@"Loading airports..."];
        [CommunicationManager nearbyAirportsForLongitude:location.coordinate.longitude
                                             andLatitude:location.coordinate.latitude
                                         successCallback:^(id responseObject) {
                                             
                                             if (responseObject &&
                                                 [responseObject isKindOfClass:[NSDictionary class]] &&
                                                 [responseObject count]) {
                                                 
                                                 if (!_airportsArray) {
                                                     _airportsArray = [[NSMutableArray alloc] init];
                                                 }
                                                 else {
                                                     [_airportsArray removeAllObjects];
                                                 }
                                                 NSDictionary *responseDict = (NSDictionary*)responseObject;
                                                 
                                                 NSArray *responseArray = [JSONManager arrayValueForKey:@"airports" fromDictionary:responseDict];
                                                 
                                                 int numberOfAirports = [MAX_AIRPORTS_VALUE intValue];
                                                 for (int airportIndex = 0; airportIndex < numberOfAirports; airportIndex++) {
                                                     NSDictionary *dict = [responseArray objectAtIndex:airportIndex];
                                                     AirportModel *airport = [[AirportModel alloc] initWithDict:dict];
                                                     if (airport) {
                                                         [_airportsArray addObject:airport];
                                                     }
                                                 }
                                                 [_collectionView reloadData];
                                                 [self reloadWeatherForAirports];
                                             }
                                             else {
                                                 [self removeLoadingMask];
                                             }
                                             
                                         } errorCallback:^(NSString *errorMessage) {
                                             
                                             [self removeLoadingMask];
                                             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                                             [alertView show];
                                         }];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Please enable location services for this application." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)reloadWeatherForAirports {
    if (_enableRefresh && [_airportsArray count]) {
        
        if (_lastRefreshTime) {
            
            NSDate *currTime = [NSDate date];
            NSTimeInterval timeDiff = [currTime timeIntervalSinceDate:_lastRefreshTime];
            if (timeDiff < 10*60) {
                [_refreshControl endRefreshing];
                return;
            }
        }
        _enableRefresh = NO;
        _airportIndex = 0;
        [self loadWeatherForAirports];
    }
    else {
        [self removeLoadingMask];
        [_refreshControl endRefreshing];
    }
}

- (void)loadWeatherForAirports {
    
    if ([_airportsArray count] > _airportIndex) {
        [self loadWeatherForAirportWithIndex:_airportIndex];
    }
    else {
        _enableRefresh = YES;
        _lastRefreshTime = [NSDate date];
        [_refreshControl endRefreshing];
        [self removeLoadingMask];
    }
}

- (void)loadWeatherForAirportWithIndex:(NSUInteger)airportIndex {
    
    if ([_airportsArray count] > airportIndex) {
        [self addLoadingMask];
        AirportModel *airport = [_airportsArray objectAtIndex:airportIndex];
        [_loadingView updateLabelText:[NSString stringWithFormat:@"Loading %@...", airport.code]];
        [CommunicationManager currentWeatherForCityName:airport.city
                                        successCallback:^(id responseObject) {
                                            
                                            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                                                
                                                airport.currWeather = [[WeatherModel alloc] initWithDict:responseObject];
                                                [_collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:airportIndex inSection:0]]];
                                            }
                                            _airportIndex++;
                                            [self loadWeatherForAirports];
                                            
                                        } errorCallback:^(NSString *errorMessage) {
                                            
                                            NSLog(@"errorCallback:%@ for city:%@", errorMessage, airport.city);
                                            _airportIndex++;
                                            [self loadWeatherForAirports];
                                        }];
    }
}

#pragma mark - loading mask
- (void)addLoadingMask {
    
    if (!_loadingView) {
        _loadingView = [[LoadingView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 90.0)/2, (self.view.frame.size.height - 90.0)/2, 90.0, 90.0)];
        [self.view addSubview:_loadingView];
    }
}

- (void)removeLoadingMask {
    
    if (_loadingView) {
        [_loadingView removeFromSuperview];
        _loadingView = nil;
    }
}

@end
