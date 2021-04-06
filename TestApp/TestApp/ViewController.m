//
//  ViewController.m
//  TestApp
//
//  Created by Andrey on 08/03/2021.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

#import "LocationManager.h"

@interface ViewController () <MKMapViewDelegate>

@property (nonatomic, weak) MKMapView *mapView;
@property (nonatomic, strong) LocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [LocationManager new];
    [self.locationManager start];
    
    self.title = @"Map Example";
    self.view.backgroundColor = [UIColor yellowColor];
    
    //Карта
    MKMapView *map = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView = map;
    self.mapView.delegate = self;
    

    self.locationManager.locationCallback = ^(CLLocation *location) {
    
    [self addressFromLocation: location withCompletion:^(CLPlacemark *placemark) {
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000000, 1000000);
        [self.mapView setRegion:region animated:YES];
        
        MKPointAnnotation *annotation = [MKPointAnnotation new];
        annotation.title = placemark.name;
        annotation.subtitle = placemark.country;
        annotation.coordinate = location.coordinate;
        
        [self.mapView addAnnotation:annotation];
        
    }];
    };

    [self.view addSubview:self.mapView];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [self.locationManager start];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.locationManager stop];
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    static NSString *identifier = @"AnnotationIdentifer";
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (annotationView) {
        annotationView.annotation = annotation;
    } else {
        annotationView = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.canShowCallout = YES;
        annotationView.calloutOffset = CGPointMake(0.0, 5.0);
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    
    return annotationView;
}

#pragma mark - Private

// Location -> Address
- (void)addressFromLocation:(CLLocation *)location withCompletion:(void(^)(CLPlacemark *placemark))completion{
    
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:
     ^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count > 0) {
            for (MKPlacemark *placemark in placemarks) {
                completion(placemark);
            }
        }
    }];
}

// Address -> Location
- (void)locationFromAddress:(NSString *)address {
    CLGeocoder *geocoder = [CLGeocoder new];
    
    [geocoder geocodeAddressString:address completionHandler:
        ^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            if (placemarks.count > 0) {
                for (MKPlacemark *placemark in placemarks) {
                    NSLog(@"Placemark Location \n\n - %@", placemark.location);
                }
            }
    }];
}


@end

