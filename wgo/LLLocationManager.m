//
//  LLLocationManager.m
//  wgo
//
//  Created by Fabien Di Tore on 30.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import "LLLocationManager.h"
#import <CoreLocation/CLLocationManager.h>

@implementation LLLocationManager


+ (id)sharedInstance {
    static LLLocationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        _locMgr = [[CLLocationManager alloc] init];
        _locMgr.delegate = self;
        [_locMgr requestAlwaysAuthorization];
        [_locMgr setAllowsBackgroundLocationUpdates:YES];
        [_locMgr setDelegate:self];
        [_locMgr startUpdatingLocation];
        [_locMgr startUpdatingHeading];
 
       // [_map setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"UserLocation updated %@", [locations description]);
    
    _currentLocation = [locations objectAtIndex:0];
    [[NSNotificationCenter defaultCenter] postNotificationName:LL_LocationManager_UPDATED_LOCATION object:self userInfo:nil];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{


}


@end
