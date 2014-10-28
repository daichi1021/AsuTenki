//
//  MainViewController.m
//  WeatherApp
//
//  Created by Daichi Mizoguchi on 2014/10/20.
//  Copyright (c) 2014年 Daichi Mizoguchi. All rights reserved.
//

#import  <CoreLocation/CoreLocation.h>

#import "MainViewController.h"
#import "WeatherTableViewCell.h"
#import "Weather.h"
#import "Context.h"
#import "CommonUtil.h"

#import "NSDate+Escort.h"

#import "SIAlertView.h"

#import "UITableViewCell+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "FUIButton.h"

#import "KFOpenWeatherMapAPIClient.h"
#import "KFOWMWeatherResponseModel.h"
#import "KFOWMMainWeatherModel.h"
#import "KFOWMWeatherModel.h"
#import "KFOWMForecastResponseModel.h"
#import "KFOWMCityModel.h"
#import "KFOWMDailyForecastResponseModel.h"
#import "KFOWMDailyForecastListModel.h"
#import "KFOWMSearchResponseModel.h"
#import "KFOWMSystemModel.h"

@interface MainViewController () <CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *weatherTableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) KFOpenWeatherMapAPIClient *apiClient;

@property (strong, nonatomic) NSString *customCellName;
@property (strong, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSMutableArray *weathers;

@end


@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:[NSString stringWithFormat:@"%@",[self class]] bundle:nibBundleOrNil];
    if (self) {
        _customCellName = [NSString stringWithFormat:@"%@",[WeatherTableViewCell class]];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNotification];
    [self setupDesign];
    [self setupTableView];
    [self setupLocationManager];
    
    [self getLocationData];
}


//- (void)viewWillAppear:(BOOL)animated
//{
//    [self getLocationData];
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setupNotification
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(applicationDidEnterBackground) name:@"applicationDidEnterBackground" object:nil];
    [nc addObserver:self selector:@selector(applicationWillEnterForeground) name:@"applicationWillEnterForeground" object:nil];
}


- (void)setupDesign
{
    self.view.backgroundColor = [UIColor cloudsColor];
    self.title = [Context titleLabel];
}


- (void)setupTableView
{
    UINib *taskNib = [UINib nibWithNibName:_customCellName bundle:nil];
    [_weatherTableView registerNib:taskNib forCellReuseIdentifier:_customCellName];
    _weatherTableView.delegate = self;
    _weatherTableView.dataSource = self;
    _weatherTableView.backgroundColor = [UIColor cloudsColor];
    _weatherTableView.separatorColor = [UIColor clearColor];
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refleshTableView) forControlEvents:UIControlEventValueChanged];
    [_weatherTableView addSubview:_refreshControl];
}


- (void)setupLocationManager
{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
}


#pragma mark - LocationManager Delegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
         [_locationManager startUpdatingLocation];
    } else {
        [_refreshControl endRefreshing];
//        [SVProgressHUD dismiss];
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"ロケーション情報がアップデートされました");
    [_refreshControl endRefreshing];
//    [SVProgressHUD dismiss];
    //[_locationManager stopUpdatingLocation];
    [self getWeatherData:[locations lastObject]];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [_refreshControl endRefreshing];
//    [SVProgressHUD dismiss];
    [self showAlertMessage:[Context alertLocationMessageLabel]];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_weathers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherTableViewCell *weatherCell = [tableView dequeueReusableCellWithIdentifier:_customCellName
                                                                        forIndexPath:indexPath];
    Weather *wt = _weathers[indexPath.row];
    
    weatherCell.temperatureLabel.text = [NSString stringWithFormat:@"%0.f℃", wt.temperature];
    weatherCell.timeLabel.text = [CommonUtil timeString:wt.dateTime];
    weatherCell.backgroundColor = [CommonUtil cellColorFromWeatherCode:wt.weatherDetail];
    
    return weatherCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [Context weatherTableViewHeight];
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _cityName;
}


- (void)getLocationData
{
    NSLog(@"ロケーション情報取得開始");
    //[SVProgressHUD showWithStatus:[Context readingLabel] maskType:SVProgressHUDMaskTypeBlack];
    //[_refreshControl beginRefreshing];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [_locationManager requestAlwaysAuthorization];
    } else {
        [_locationManager startUpdatingLocation];
    }
}


- (void)refleshTableView
{
    [_refreshControl beginRefreshing];
    [self setupLocationManager];
    [self getLocationData];
}


- (void)getWeatherData:(CLLocation* )location
{
    NSLog(@"天気予報情報取得開始");
    CLLocationCoordinate2D locCod;
    locCod.latitude = location.coordinate.latitude;
    locCod.longitude = location.coordinate.longitude;
    
    _apiClient = [[KFOpenWeatherMapAPIClient alloc] initWithAPIKey:WEATHER_API_KEY andAPIVersion:WEATHER_API_VERSION];
    
    [_apiClient forecastForCoordinate:locCod withResultBlock:^(BOOL success, id responseData, NSError *error)
     {
         if (success) {
             KFOWMForecastResponseModel *responseModel = (KFOWMForecastResponseModel *)responseData;
             _cityName = responseModel.city.cityName;
             
             _weathers = [[NSMutableArray alloc] init];
             
             NSArray *weathers = [responseModel.list valueForKeyPath:@"weather"];
             NSArray *mainWeathers = [responseModel.list valueForKeyPath:@"mainWeather"];
             NSArray *dateTimes = [responseModel.list valueForKeyPath:@"dt"];
             
             NSInteger count = [dateTimes count];
             for (int i = 0; i  < count; i++ ) {
                 
                 NSString *weatherDetail = [weathers[i] valueForKeyPath:@"main"][0];
                 // ケルビンから摂氏に変換
                 CGFloat temperature = [[mainWeathers[i] valueForKeyPath:@"temperature"] floatValue] - 273.15f;
                 NSDate *dateTime = dateTimes[i];
                 
                 // 明日の日付のレコードのみ処理対象
                 if (![dateTime isTomorrow]) {
                     continue;
                 }
                 
                 Weather *wt =  [[Weather alloc] initWithWeatherDetail:weatherDetail
                                                        andTemperature:temperature
                                                           andDateTime:dateTime];
                 [_weathers addObject:wt];
             }
             NSLog(@"天気予報情報取得完了");
             [_weatherTableView reloadData];
         } else {
             [self showAlertMessage:[Context alertWeatherMessageLabel]];
         }
     }];

}


- (void)showAlertMessage:(NSString *)message
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:[Context confirmLabel]
                                                     andMessage:message];
    
    [alertView addButtonWithTitle:[Context okLabel]
                             type:SIAlertViewButtonTypeCancel
                          handler:nil];
    
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    [alertView show];
}


- (void)applicationDidEnterBackground
{
    [_locationManager stopUpdatingLocation];
}


- (void)applicationWillEnterForeground
{
    [self setupLocationManager];
    [self getLocationData];
}



@end
