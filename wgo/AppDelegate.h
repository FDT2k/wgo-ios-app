//
//  AppDelegate.h
//  wgo
//
//  Created by Fabien Di Tore on 26.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UIColor * topColor ;
    UIColor * bottomColor;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong,atomic) NSString* authenticationToken;
@property (strong,atomic) NSDictionary * config;
@property (nonatomic, retain) CAGradientLayer *gradient;
@end

