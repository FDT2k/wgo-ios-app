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
#import "LLLocationManager.h"
@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Enabled %d",[CLLocationManager locationServicesEnabled]);
    _points = @[
               
                
                @{
                    @"name":@"10 Months",
                    @"date":[NSDate date],
                    @"pic":@[
                            @[@"contenu/po/1.jpg",@"6 mois"],
                            @[@"contenu/po/2.jpg",@"16 mois"],
                            @[@"contenu/po/3.jpg",@"6 mois"],
                            @[@"contenu/po/4.jpg",@"16 mois"],
                            @[@"contenu/po/5.jpg",@"6 mois"],
                            @[@"contenu/po/6.jpg",@"16 mois"],
                            @[@"contenu/po/7.jpg",@"6 mois"],
                            @[@"contenu/po/8.jpg",@"16 mois"],
                           ],
                    @"lat":[NSNumber numberWithFloat:46.536948],
                    @"lng": [NSNumber numberWithFloat:6.588535]
                }
                
                
            ];
    
    [LLLocationManager sharedInstance];
    [_map setDelegate:self];
    [_map setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    [_map setShowsUserLocation:YES];
    
    
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

- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView{

}

- (void)mapView:(MKMapView *)mapView
didFailToLocateUserWithError:(NSError *)error{

}

- (void)mapView:(MKMapView *)mapView
didUpdateUserLocation:(MKUserLocation *)userLocation{


}


-(IBAction) startTakingPicture:(id)sender{
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera ;
        
        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            
            imagePicker.cameraDevice =  UIImagePickerControllerCameraDeviceFront;
        } else {
            imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
        
        //  [self.navigationController presentViewController:imagePickerController animated:NO completion:nil];
        //  [self addChildViewController:imagePickerController];
        //  [imagePickerController didMoveToParentViewController:self];
        //  [self.view addSubview:imagePickerController.view];
        
        [self addChildViewController:imagePicker];
        [imagePicker didMoveToParentViewController:self];
        [self.view addSubview:imagePicker.view];
    }
    else {
        // do stuff ///....Alert
        UIAlertView * v = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support taking pictures" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [v show];
    }
    
    //   [self presentViewController:c animated:YES completion:^{
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    
    
    //pic = image;
    //if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
    //    [self performSegueWithIdentifier:@"publish" sender:self];
    //}else{
    //    [self performSegueWithIdentifier:@"postLivePic" sender:self];
   // }
    
    
    [self closePicker];
    [self centerOnECAL];
    
}

-(void) closePicker{
    [imagePicker.view removeFromSuperview];
    [imagePicker removeFromParentViewController];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self closePicker];
}


@end
