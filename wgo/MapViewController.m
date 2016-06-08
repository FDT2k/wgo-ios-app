//
//  ViewController.m
//  wgo
//
//  Created by Fabien Di Tore on 26.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "CustomAnnotation.h"
@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Enabled %d",[CLLocationManager locationServicesEnabled]);
    _points = @[
                @{
                    @"name":@"",
                    @"date":[NSDate date],
                    @"pic":@"img1.jpg",
                    @"lat":[NSNumber numberWithFloat:45],
                    @"lng": [NSNumber numberWithFloat:-6]
                    },
                @{
                    @"name":@"",
                    @"date":[NSDate date],
                    @"pic":@"img1.jpg",
                    @"lat":[NSNumber numberWithFloat:-45],
                    @"lng": [NSNumber numberWithFloat:6]
                    },
                @{
                    @"name":@"",
                    @"date":[NSDate date],
                    @"pic":@"img1.jpg",
                    @"lat":[NSNumber numberWithFloat:46.536948],
                    @"lng": [NSNumber numberWithFloat:6.588535]
                    }
                ];
    
    
    [_map setDelegate:self];
    [_map setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    [self loadAnnotations];
    [self centerOnUser:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) loadAnnotations{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    for(NSDictionary* item in _points){
        CustomAnnotation * c = [[CustomAnnotation alloc]initWithLocation:CLLocationCoordinate2DMake([[item objectForKey:@"lat"] floatValue], [[item objectForKey:@"lng"] floatValue])];
      
        
        
        [array addObject:c];
        
    }
    [_map addAnnotations:array];
}

-(void) viewDidAppear:(BOOL)animated{
   
    [self.map setShowsUserLocation:YES];

    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) centerOnUser:(id)sender{

    MKCoordinateRegion mapRegion;
    NSLog(@"%f",self.userLocation.coordinate.latitude);
    mapRegion.center.latitude = _map.userLocation.coordinate.latitude;
    mapRegion.center.longitude = _map.userLocation.coordinate.longitude;
    mapRegion.span.latitudeDelta = 1;
    mapRegion.span.longitudeDelta = 1;
    [_map setRegion:mapRegion animated: YES];

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation{

    MKAnnotationView * v = [mapView dequeueReusableAnnotationViewWithIdentifier:@"custom"];
    
    if(v == nil){
        if (![annotation isKindOfClass:[MKUserLocation class]]){
            v = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"custom"];
            [v setImage:[UIImage imageNamed:@"marker.png"]];
        }
    }else{
        v.annotation = annotation;
    }
    
    
    return v;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
   /* NSLog(@"UserLocation updated %@", [locations description]);
    
    self.userLocation = [locations objectAtIndex:0];
    [self centerOnUser];*/
}

@end
