//
//  MapViewController.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBMapViewController.h"
#import <MapKit/MapKit.h>
#import "ProjectSettings.h"

@interface BRBMapViewController ()

@property (nonatomic, nullable) MKMapView *mapView;
@property (nonatomic, nullable) BRBDataContainer *dataManager;
@property (nonatomic) BOOL displayAllUsers;
@property (nonatomic, copy) NSString *userName;

@end

@implementation BRBMapViewController


- (instancetype)initWithDataManager:(BRBDataContainer *)dataManager
{
    self = [super init];
    if (self) {
        _dataManager = dataManager;
        _displayAllUsers = YES;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupMapView];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.displayAllUsers)
    {
        [self displayUserLocations];
    }
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self deleteUsersFromMap];
    self.displayAllUsers = YES;
}


- (void)setupMapView
{
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.mapView];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = BRBZoomLocationLatitude;
    zoomLocation.longitude= BRBZoomLocationLongitude;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, BRBZoomArea, BRBZoomArea);
    self.mapView.zoomEnabled = YES;
    [self.mapView setRegion:viewRegion animated:YES];
}


- (void)displayUserLocations
{
    NSMutableArray *array = [NSMutableArray new];
    for (User *user in self.dataManager.users)
    {
        if (self.displayAllUsers || [user.displayedName isEqualToString: self.userName])
        {
            MKPointAnnotation *userPoint = [MKPointAnnotation new];
            
            userPoint.title = user.displayedName;
            userPoint.coordinate = CLLocationCoordinate2DMake(user.locationLatitude, user.locationLongitude);
            
            [array addObject:userPoint];
        }
    }
    [self.mapView showAnnotations:array animated:YES];
}


- (void)displayLocationOfUserWithName:(NSString *)userName
{
    self.displayAllUsers = NO;
    self.userName = userName;
    [self deleteUsersFromMap];
    [self displayUserLocations];
}


- (void)deleteUsersFromMap
{
    [self.mapView removeAnnotations:self.mapView.annotations];
}


#pragma mark - ViewControllerFactoryProtocol

- (NSString *)getTabBarItemTitle
{
    return BRBMapViewTabBarItemTitle;
}

@end
