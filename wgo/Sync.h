//
//  Sync.h
//  wgo
//
//  Created by Fabien Di Tore on 31.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sync : NSObject
+ (id)sharedInstance;


-(void) registerNickname:(NSString*) nickname complete:( void ( ^ )( BOOL ,NSDictionary*, NSError* )) complete;

-(void) registerFacebookUser:(NSString*) nickname complete:( void ( ^ )( BOOL ,NSDictionary*, NSError* )) complete;


@end
