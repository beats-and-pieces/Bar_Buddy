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
#import "User+CoreDataClass.h"

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
}

- (void)setupMapView
{
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
//    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 55.741476;
    zoomLocation.longitude= 37.531409;

    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 5*METERS_PER_MILE, 5*METERS_PER_MILE);
    
    [self.mapView setRegion:viewRegion animated:YES];
}

- (void)displayUsersLocations{
    NSMutableArray *array = [NSMutableArray new];
    for (User *user in self.dataManager.users)
    {
        MKPointAnnotation *userPoint = [MKPointAnnotation new];
        
        userPoint.title = user.displayedName;
        userPoint.coordinate = CLLocationCoordinate2DMake(user.locationLatitude, user.locationLongitude);
//        NSLog(@"userpoint %f, %f", userPoint.coordinate.longitude, userPoint.coordinate.latitude);
        [array addObject:userPoint];
        
    }
    [self.mapView showAnnotations:array animated:YES];
}
- (void)calculateZoomArea
{
    
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

@end
