//
//  LoginViewController.m
//  wgo
//
//  Created by Fabien Di Tore on 31.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import "LoginViewController.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "LocalData.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginButtonClicked:(id)sender
{
    if (![[LocalData sharedInstance] loggedInWithFacebook]){
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login
         logInWithReadPermissions: @[@"email"]
         fromViewController:self
         handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
             if (error) {
                 NSLog(@"Process error");
             } else if (result.isCancelled) {
                 NSLog(@"Cancelled");
             } else {
                 NSLog(@"Logged in");
                 [self performSegueWithIdentifier:@"nickname" sender:self];
                 NSLog(@"FBToken: %@",result.token.tokenString);
                 // register and store the user on wgo backend
                 
             }
         }];
    }else if(![[LocalData sharedInstance] hasNickname]){
        [self performSegueWithIdentifier:@"nickname" sender:self];
    }else{
        [self performSegueWithIdentifier:@"tomainview" sender:self];
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
