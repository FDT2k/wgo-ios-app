//
//  CustomAnnotation.m
//  wgo
//
//  Created by Fabien Di Tore on 07.06.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation 

@synthesize coordinate;

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    self = [super init];
    if (self) {
        coordinate = coord;
    }
    return self;
}


@end