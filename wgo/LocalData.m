//
//  LocalData.m
//  wgo
//
//  Created by Fabien Di Tore on 30.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import "LocalData.h"
#import "LLLocationManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
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

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timer:) name:LL_TICKER_DIDTICK object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationUpdate:) name:LL_LocationManager_UPDATED_LOCATION object:nil];
        
        _config = [NSMutableDictionary dictionaryWithContentsOfFile: [DocumentPath stringByAppendingPathComponent:kConfigFile]];
        if(_config  == nil){
            _config = [NSMutableDictionary dictionary];
        }
    
    }
    return self;
}

-(BOOL) loggedInWithFacebook{
    return [FBSDKAccessToken currentAccessToken] != nil && ![[FBSDKAccessToken currentAccessToken] isEqual:@""];
}

-(BOOL) loggedInWithEmail
{
    return NO;
}

-(BOOL) authenticated
{
    return [self loggedInWithEmail] || [self loggedInWithFacebook];
}

-(BOOL) writeConfig
{
    if ([_config writeToFile:[DocumentPath stringByAppendingPathComponent:kConfigFile] atomically:YES])
    {
        return YES;
    }
    return NO;
}


-(void) setHelpRead{
    [_config setObject:[NSNumber numberWithBool:YES] forKey:@"first_launch"];
    [self writeConfig];
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

-(void) locationUpdate:(LLLocationManager * ) mgr{
    
}

-(void) timer:(NSTimer*) timer{

    [self recomputeDistances];
}

-(void) recomputeDistances{
    
}

-(BOOL) hasNickname
{
    return [_config objectForKey:@"nickname"] != nil && ![[_config objectForKey:@"nickname"] isEqual:@""];
}

-(void) setNickname:(NSString*) name{
    [_config setObject:name forKey:@"nickname"];
}

-(NSString*) getNickname{
    if([_config objectForKey:@"nickname"] != nil){
        return [_config objectForKey:@"nickname"];
    }
    return @"";
}

@end
