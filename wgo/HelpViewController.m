//
//  HelpViewController.m
//  wgo
//
//  Created by Fabien Di Tore on 31.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import "HelpViewController.h"
#import "LocalData.h"
@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timer:) name:LL_TICKER_DIDTICK object:nil];
    _loaded = [[NSDate date] timeIntervalSince1970];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //let's mark the app as readed
    
    [[LocalData sharedInstance] setHelpRead];
}

-(void) timer:(NSTimer*)timer{
    //return;
    if (_loaded + 3 < [[NSDate date] timeIntervalSince1970] && !_done){
        
        [self performSegueWithIdentifier:@"to_login" sender:self];
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
