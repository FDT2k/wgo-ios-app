//
//  LocalData.m
//  wgo
//
//  Created by Fabien Di Tore on 30.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import "LocalData.h"

@implementation LocalData

+ (id)sharedInstance {
    static LocalData *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {

    
    
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}
@end
