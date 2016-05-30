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



-(void) authenticate:(NSString*) email password:(NSString*) password callback:( BOOL ( ^ )( int ) )predicate{
    NSDictionary *headers = @{@"accept": @"application/json"};
    NSDictionary *parameters = @{@"parameter": @"value", @"foo": @"bar"};
    
    [[UNIRest post:^(UNISimpleRequest *request) {
        [request setUrl:[self urlForMethod:@"_authenticate"]];
        [request setHeaders:headers];
        [request setParameters:parameters];
    }] asJsonAsync:^(UNIHTTPJsonResponse* response, NSError *error) {
        // This is the asyncronous callback block
        NSInteger code = response.code;
        NSDictionary *responseHeaders = response.headers;
        UNIJsonNode *body = response.body;
        NSData *rawBody = response.rawBody;
    }];

}

-(void) registerWithMail:(NSString*) email password:(NSString*) password callback:( BOOL ( ^ )( int ) )callback{

    NSLog(@"%@",email);
}

-(NSString*) urlForMethod:(NSString*) string{
    return [_serverURL stringByAppendingString:string];
}
@end
