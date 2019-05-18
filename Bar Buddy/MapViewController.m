//
//  MapViewController.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "ProjectSettings.h"

@interface MapViewController () <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *mapView;
@property (nullable, strong) DataManager *dataManager;
@property (nonatomic) BOOL displayAllUsers;
@property (nonatomic, copy) NSString *userName;

@end

@implementation MapViewController


- (instancetype)initWithDataManager:(DataManager *)dataManager
{
    self = [super init];
    if (self) {
        _dataManager = dataManager;
        _displayAllUsers = TRUE;
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
    self.displayAllUsers = TRUE;
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // this part is boilerplate code used to create or reuse a pin annotation
    static NSString *viewId = @"MKPinAnnotationView";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)
    [self.mapView dequeueReusableAnnotationViewWithIdentifier:viewId];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:viewId];
    }
    // set your custom image
    annotationView.image = [UIImage imageNamed:PlaceholderFilename];
    return annotationView;
}


#pragma mark - ViewControllerFactoryProtocol

- (NSString *)getTabBarItemTitle
{
    return MapViewTabBarItemTitle;
}

@end
