//
//  MapViewController.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "DataManager.h"
#import "User.h"

@interface MapViewController () <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *mapView;
@property (nullable, strong) DataManager *dataManager;


@end

#define METERS_PER_MILE 1609.344

@implementation MapViewController

- (NSString *)getTabBarItemTitle
{
    return @"На карте";
}
- (instancetype)initWithDataManager:(DataManager *)dataManager
{
    self = [super init];
    if (self) {
        _dataManager = dataManager;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMapView];
    [self displayUsersLocations];
    // Do any additional setup after loading the view.
}

- (void)setupMapView
{
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.mapView];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 55.741476;
    zoomLocation.longitude= 37.531409;
//    55.741476, 37.531409
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 5*METERS_PER_MILE, 5*METERS_PER_MILE);
    
    // 3
    [_mapView setRegion:viewRegion animated:YES];
}

- (void)displayUsersLocations{
    //    for
    DataManager *dataManager = [DataManager shared];
    NSMutableArray *array = [NSMutableArray new];
    for (User *user in dataManager.users)
    {
        
        MKPointAnnotation *userPoint = [MKPointAnnotation new];
        
        userPoint.title = user.displayedName;
        userPoint.coordinate = CLLocationCoordinate2DMake(user.locationLatitude, user.locationLongitude);
        NSLog(@"userpoint %f, %f", userPoint.coordinate.longitude, userPoint.coordinate.latitude);
        [array addObject:userPoint];
        
    }
//    [self.mapView addAnnotations:array];
    [self.mapView showAnnotations:array animated:YES];
}
@end
