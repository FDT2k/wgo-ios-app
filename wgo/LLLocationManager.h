//
//  LLLocationManager.h
//  wgo
//
//  Created by Fabien Di Tore on 30.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocationManager.h>
#define LL_LocationManager_UPDATED_LOCATION @"LL_LocationManager_UPDATED_LOCATION"
@interface LLLocationManager : NSObject <CLLocationManagerDelegate>

@property(readonly) CLLocationManager * locMgr;
@property(readonly) CLLocation * currentLocation;

@end
