//
//  PublishViewController.m
//  wgo
//
//  Created by Fabien Di Tore on 08.06.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import "PublishViewController.h"

@interface PublishViewController ()

@end
 
@implementation PublishViewController
@synthesize pic;

- (void)viewDidLoad {
    [super viewDidLoad];
    [_imageView setImage:self.pic];
    [_dpPicker setMaximumDate:[NSDate date]];
    [_dpPicker setValue:[UIColor whiteColor] forKey:@"textColor"];
    SEL selector = NSSelectorFromString( @"setHighlightsToday:" );
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature :
                                [UIDatePicker
                                 instanceMethodSignatureForSelector:selector]];
    BOOL no = NO;
    [invocation setSelector:selector];
    [invocation setArgument:&no atIndex:2];
    [invocation invokeWithTarget:_dpPicker];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:1.5 animations:^{
        
        _imageView.alpha=0.5;
        
    } completion:^(BOOL finished) {
        
        _dpPicker.alpha=1;
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) setPic:(UIImage *)_pic{
    pic = _pic;
    if(_imageView){
        [_imageView setImage:self.pic];
    }
}
@end
