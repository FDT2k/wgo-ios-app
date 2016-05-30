//
//  LLApplication.h
//  ArcBaseApplication
//
//  Created by Fabien Di Tore on 11.02.13.
//  Copyright (c) 2013 Fabien Di Tore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLApplication : UIApplication{
    NSTimer * _globalTimer;
}

-(void) setGlobalTimer;

@end
