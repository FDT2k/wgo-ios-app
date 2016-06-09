//
//  ViewController.h
//  wgo
//
//  Created by Fabien Di Tore on 26.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface MapViewController : UIViewController <MKMapViewDelegate>{
    NSArray * _points;
    NSMutableArray * _selectedData;
}


@property IBOutlet MKMapView * map;
@property (retain)IBOutlet  UIButton * btCamera;
@property (readonly) CLLocationManager* locMgr;
@property (atomic) CLLocation * userLocation;

@property IBOutlet UIButton * btSearch;
@property IBOutlet UITextField * tfSearch;
@property BOOL centerECAL;

- (IBAction) centerOnUser:(id)sender;

//- (IBAction)didHitCameraButton:(id)sender;

-(IBAction)toggleSearch:(id)sender;
-(void) centerOnECAL;
@end

