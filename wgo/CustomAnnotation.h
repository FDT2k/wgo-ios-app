//
//  CustomAnnotation.h
//  wgo
//
//  Created by Fabien Di Tore on 07.06.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface CustomAnnotation : NSObject <MKAnnotation>{
    CLLocationCoordinate2D coordinate;
}
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (strong) NSMutableArray * data;
- (id)initWithLocation:(CLLocationCoordinate2D)coord;

// Other methods and properties.
@end
