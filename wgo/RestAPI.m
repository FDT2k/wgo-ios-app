//
//  RestAPI.m
//  wgo
//
//  Created by Fabien Di Tore on 30.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import "RestAPI.h"

@implementation RestAPI

+ (id)sharedInstance {
    static RestAPI *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        
        _serverURL= @"https://wgo.geekagency.ch/wgo/api/";
        
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}



-(void) authenticate:(NSString*) email password:(NSString*) password callback:( void ( ^ )( UNIHTTPJsonResponse* response, NSError *error ) )callback{
    NSDictionary *headers = @{@"accept": @"application/json"};
    NSDictionary *parameters = @{@"parameter": @"value", @"foo": @"bar"};
    
    [[UNIRest post:^(UNISimpleRequest *request) {
        [request setUrl:[self urlForMethod:@"_authenticate"]];
        [request setHeaders:headers];
        [request setParameters:parameters];
    }] asJsonAsync:callback];

}

-(void) registerAPNS:(NSString*) token  callback:( void ( ^ )( BOOL result ) )callback{
    NSDictionary *headers = @{@"accept": @"application/json"};
    NSDictionary *parameters = @{@"token": token, @"debug": [NSString stringWithFormat:@"%d",DEBUG]};
    [[UNIRest post:^(UNISimpleRequest *request) {
        [request setUrl:[self urlForMethod:@"_apns"]];
        [request setHeaders:headers];
        [request setParameters:parameters];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        NSInteger code = response.code;
        NSDictionary *responseHeaders = response.headers;
        UNIJsonNode *body = response.body;
        NSData *rawBody = response.rawBody;
        callback(YES);
        
    }];
}

-(NSString*) urlForMethod:(NSString*) string{
    
    return [_serverURL stringByAppendingString:string];
}
@end
