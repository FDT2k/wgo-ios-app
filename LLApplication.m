//
//  LLApplication.m
//  ArcBaseApplication
//
//  Created by Fabien Di Tore on 11.02.13.
//  Copyright (c) 2013 Fabien Di Tore. All rights reserved.
//

#import "LLApplication.h"

@implementation LLApplication

- (id)init
{
    if ((self = [super init]))
    {
        [self setGlobalTimer];
    }
    return self;
}
-(void) setGlobalTimer{
#ifdef LL_TICKER
    if(!_globalTimer){
        _globalTimer = [NSTimer scheduledTimerWithTimeInterval:LL_TICKER_DELAY target:self selector:@selector(timerDidTick:) userInfo:nil repeats:YES];
    }
#endif
}

-(void) timerDidTick:(NSTimer*) timer
{
#ifdef LL_TICKER
    [[NSNotificationCenter defaultCenter] postNotificationName:LL_TICKER_DIDTICK object:nil userInfo:nil];
#endif
}

@end
