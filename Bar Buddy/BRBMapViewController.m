//
//  BRBMapViewController.m
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
@property (nonatomic, nullable) BRBDataContainer *dataContainer;
@property (nonatomic) BOOL displayAllUsers;
@property (nonatomic, copy) NSString *userName;

@end

@implementation BRBMapViewController

#pragma mark - ViewControllerFactoryProtocol

- (instancetype)initWithDataContainer:(BRBDataContainer *)dataContainer
{
    self = [super init];
    if (self) {
        _dataContainer = dataContainer;
        if (_dataContainer.users.count == 0)
        {
            [_dataContainer loadData];
        }
        
        _displayAllUsers = YES;
        self.tabBarItem.title = BRBMapViewTabBarItemTitle;
        self.tabBarItem.image = [UIImage imageNamed:BRBMapViewTabBarItemImageName];
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
    for (User *user in self.dataContainer.users)
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

@end
