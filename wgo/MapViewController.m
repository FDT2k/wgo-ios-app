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
#import "PicDetailViewController.h"
@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Enabled %d",[CLLocationManager locationServicesEnabled]);
    _points = @[
                @{
                    @"name":@"6 Months",
                    @"date":[NSDate date],
                     @"pic":@[@"img1.jpg"],
                    @"lat":[NSNumber numberWithFloat:45],
                    @"lng": [NSNumber numberWithFloat:-6]
                },
                
                
                @{
                    @"name":@"6 Months",
                    @"date":[NSDate date],
                    @"pic":@[@"img1.jpg"],
                    @"lat":[NSNumber numberWithFloat:-45],
                    @"lng": [NSNumber numberWithFloat:6]
                },
                
                
                @{
                    @"name":@"10 Months",
                    @"date":[NSDate date],
                    @"pic":@[
                            @"1970.jpg",
                            @"1971.jpg",
                            @"1972.jpg",
                            @"1973.jpg",],
                    @"lat":[NSNumber numberWithFloat:46.536948],
                    @"lng": [NSNumber numberWithFloat:6.588535]
                }
                
                
            ];
    
    
    [_map setDelegate:self];
    [_map setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    [self loadAnnotations];
    if(!self.centerECAL){
        [self centerOnUser:nil];
    }else
    {
        [self centerOnECAL];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:@"UITextFieldTextDidChangeNotification" object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) loadAnnotations{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    for(NSDictionary* item in _points){
        CustomAnnotation * c = [[CustomAnnotation alloc]initWithLocation:CLLocationCoordinate2DMake([[item objectForKey:@"lat"] floatValue], [[item objectForKey:@"lng"] floatValue])];
        
        [c setData:[item objectForKey:@"pic"]];
        
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
            [v setAnnotation:annotation];
        }
    }else{
        v.annotation = annotation;
    }
    
    
    return v;
}
- (void)mapView:(MKMapView *)mapView
didSelectAnnotationView:(MKAnnotationView *)view

{
    _selectedData = [(CustomAnnotation*)view.annotation data];
    [self performSegueWithIdentifier:@"detail" sender:self];
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
   /* NSLog(@"UserLocation updated %@", [locations description]);
    
    self.userLocation = [locations objectAtIndex:0];
    [self centerOnUser];*/
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"detail"] ){
        [(PicDetailViewController*)segue.destinationViewController setPics:_selectedData];
    }
}


- (void) geocode :(NSString*) addr{
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:addr
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     NSLog(@"%d found",placemarks.count);
                     if( placemarks.count>0){
                         CLPlacemark* place = [placemarks objectAtIndex:0];
                         MKCoordinateRegion mapRegion;
                         
                         mapRegion.center.latitude = place.location.coordinate.latitude;
                         mapRegion.center.longitude =place.location.coordinate.longitude;
                         mapRegion.span.latitudeDelta = 1;
                         mapRegion.span.longitudeDelta = 1;
                         [_map setRegion:mapRegion animated: YES];
                     }
                 }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    return YES;
}
-(IBAction)toggleSearch:(id)sender{
    if(self.tfSearch.alpha == 0.0f){
        self.tfSearch.alpha = 1.0f;
        [self.tfSearch becomeFirstResponder];
    }else{
        self.tfSearch.alpha = 0.0f;
        [self.tfSearch resignFirstResponder];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString * addr = textField.text;
    [self geocode:addr];
}

-(void) centerOnECAL{
    MKCoordinateRegion mapRegion;
    NSLog(@"%f",self.userLocation.coordinate.latitude);
    mapRegion.center.latitude = 46.536948;
    mapRegion.center.longitude = 6.588535;
    mapRegion.span.latitudeDelta = 1;
    mapRegion.span.longitudeDelta = 1;
    [_map setRegion:mapRegion animated: YES];
}

-(void) textDidChange:(NSNotification*)userinfo{
    UITextField * tf = userinfo.object;
    
   /* if(tf.text.length > 3 ){
        [self geocode:tf.text];
    }*/
}
@end
