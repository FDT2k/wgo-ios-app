//
//  ViewController.m
//  wgo
//
//  Created by Fabien Di Tore on 26.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Enabled %d",[CLLocationManager locationServicesEnabled]);
    _locMgr = [[CLLocationManager alloc] init];
    [_locMgr requestAlwaysAuthorization];
    [_locMgr setAllowsBackgroundLocationUpdates:YES];
    [_locMgr setDelegate:self];
    [_locMgr startUpdatingLocation];
    [_locMgr startUpdatingHeading];
    [_map setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    UIWindow *  window = [[UIApplication sharedApplication] keyWindow];
    [window setBackgroundColor:[UIColor redColor]];
   // [self centerOnUser];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewDidAppear:(BOOL)animated{
   
    [self.map setShowsUserLocation:YES];

    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) centerOnUser{

   /* MKCoordinateRegion mapRegion;
    NSLog(@"%f",self.userLocation.coordinate.latitude);
    mapRegion.center.latitude = self.userLocation.coordinate.latitude;
    mapRegion.center.longitude = self.userLocation.coordinate.longitude;
    mapRegion.span.latitudeDelta = 1;
    mapRegion.span.longitudeDelta = 1;
    [_map setRegion:mapRegion animated: YES];
*/
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"UserLocation updated %@", [locations description]);
    
    self.userLocation = [locations objectAtIndex:0];
    [self centerOnUser];
}

@end
