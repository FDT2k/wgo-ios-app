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
@interface MapViewController : UIViewController <CLLocationManagerDelegate>


@property IBOutlet MKMapView * map;
@property IBOutlet UIButton * btCamera;
@property (readonly) CLLocationManager* locMgr;
@property (atomic) CLLocation * userLocation;


//- (IBAction)didHitCameraButton:(id)sender;


@end

