//
//  LocalData.h
//  wgo
//
//  Created by Fabien Di Tore on 30.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalData : NSObject{
    NSMutableDictionary * _points;
    
}

+ (id)sharedInstance;

@end
