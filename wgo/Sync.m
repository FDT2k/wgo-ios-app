//
//  Sync.m
//  wgo
//
//  Created by Fabien Di Tore on 31.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import "Sync.h"
#import "RestAPI.h"
#import "LocalData.h"
@implementation Sync
+ (id)sharedInstance {
    static Sync *sharedInstance = nil;
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


-(void) registerNickname:(NSString*) nickname complete:( void ( ^ )( BOOL ,NSDictionary*, NSError* )) complete
{
   

}
@end
