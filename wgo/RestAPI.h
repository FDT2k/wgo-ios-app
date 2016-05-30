//
//  RestAPI.h
//  wgo
//
//  Created by Fabien Di Tore on 30.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Unirest.h"
@interface RestAPI : NSObject{
    NSMutableDictionary * _defaultHeaders;
    NSString * _serverURL;
}


+ (id)sharedInstance;
-(void) authenticate:(NSString*) email password:(NSString*) password callback:( BOOL ( ^ )( int ) )predicate;

-(void) registerWithMail:(NSString*) email password:(NSString*) password callback:( BOOL ( ^ )( int ) )callback;




@end
