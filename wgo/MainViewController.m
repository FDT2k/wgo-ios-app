//
//  MainViewController.m
//  wgo
//
//  Created by Fabien Di Tore on 30.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import "MainViewController.h"
#import "LocalData.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timer:) name:LL_TICKER_DIDTICK object:nil];
    
    _loaded = [[NSDate date] timeIntervalSince1970];
    // _lblTitle.adjustsFontSizeToFitWidth = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated{
    if(_done){
        [_lblWelcome setText:[NSString stringWithFormat:@"Welcome %@",[[LocalData sharedInstance] getNickname]]];
        [UIView animateWithDuration:0.5 animations:^{
            
            [_lblTitle setAlpha:0];
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:1 animations:^{
                
                [_lblWelcome setAlpha:1];
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:1 animations:^{
                    
                    [_lblWelcome setAlpha:1];
                    
                } completion:^(BOOL finished) {
                    
                    
                }];
            }];
        }];
        
    }
    [super viewDidAppear:animated];
}

-(void) timer:(NSTimer*)timer{
    if (_loaded + 3 < [[NSDate date] timeIntervalSince1970] && !_done){
        
        [self performSegueWithIdentifier:@"to_description" sender:self];
        _done =YES;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
