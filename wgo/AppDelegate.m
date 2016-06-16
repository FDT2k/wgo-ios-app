//
//  AppDelegate.m
//  wgo
//
//  Created by Fabien Di Tore on 26.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import "AppDelegate.h"
#import <AirshipKit/AirshipKit.h>
#import "RestAPI.h"
#import "LocalData.h"
#import "LLLocationManager.h"
#import "UIColor+Expanded.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "UIColor+Expanded.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    // Override point for customization after application launch.
    
    NSLog(@"User is logged with facebook: %d", [[LocalData sharedInstance] loggedInWithFacebook]);
    topColor = [UIColor colorWithRGBHex:0x2984a3];
    bottomColor = [UIColor colorWithRGBHex:0x4ab4a5];
    application.statusBarHidden = YES;
    // try to load stored configuration
    self.config = [NSDictionary dictionaryWithContentsOfFile: [DocumentPath stringByAppendingPathComponent:kConfigFile]];
    
    if (self.config && [self.config objectForKey:@"token"]){
        self.authenticationToken = [[self.config objectForKey:@"token"] copy];
    }
#ifdef __IPHONE_8_0
    //Right, that is the point
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#else
    //register to receive notifications
    UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
#endif
    [self initGradient];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timer:) name:LL_TICKER_DIDTICK object:nil];
    
    [UAirship takeOff];
    
    // User notifications will not be enabled until userPushNotificationsEnabled is
    // set YES on UAPush. Once enabled, the setting will be persisted and the user
    // will be prompted to allow notifications. Normally, you should wait for a more
    // appropriate time to enable push to increase the likelihood that the user will
    // accept notifications.
    [UAirship push].userPushNotificationsEnabled = YES;
    [LLLocationManager sharedInstance];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation
            ];
}


-(void)timer:(NSNotification*) note{
 //   [self animateGradient];
}

-(void) initGradient{
    UIWindow *  window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [window setBackgroundColor:[UIColor colorWithRGBHex:0x260d70]];
    return ;
    
    
    self.gradient = [CAGradientLayer layer];
    float w = CGRectGetWidth(window.bounds);
    float h =   CGRectGetHeight(window.bounds);
    float size = w;
    if(h >w ){
        size = h;
    }
    _gradient.frame = CGRectMake(0, 0, size,size);
    _gradient.colors = [NSArray arrayWithObjects:
                        (id)topColor.CGColor,
                        (id)bottomColor.CGColor,
                       nil];
    _gradient.locations = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.0f],
                          [NSNumber numberWithFloat:1.0],
                          nil];
    [window.layer addSublayer:self.gradient];
}

-(void) updateGradient{
    UIWindow *  window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [window setBackgroundColor:[UIColor redColor]];
    NSArray* newColors = [NSArray arrayWithObjects:
                          (id)topColor.CGColor,
                          (id)bottomColor.CGColor,
                          nil];
    [self.gradient setColors:newColors];
    NSArray * locations =  [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0f],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [self.gradient setLocations:locations];
}

- (void)animateGradient{
    
    double bottom =((double)arc4random() / 0x100000000);
    double top=((double)arc4random() / 0x100000000) * bottom-0.3;
    [UIView animateWithDuration:0.7
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [CATransaction begin];
                         [CATransaction setAnimationDuration:0.7];
                         
                         
                         NSArray* newColors = [NSArray arrayWithObjects:
                                               (id)topColor.CGColor,
                                               (id)bottomColor.CGColor,
                                               nil];
                         [self.gradient setColors:newColors];
                         NSArray * locations =  [NSArray arrayWithObjects:
                                                 [NSNumber numberWithDouble:top ],
                                                 [NSNumber numberWithDouble:bottom],
                                                 nil];
                         [self.gradient setLocations:locations];
                         [CATransaction commit];
                     }
                     completion:^(BOOL b) {
                         //[self animateLayer..];
                     }];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"content---%@", token);
    [[RestAPI sharedInstance] registerAPNS:token callback:^(BOOL result) {
        
        NSLog(@"registration status %d",result);
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
