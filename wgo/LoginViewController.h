//
//  LoginViewController.h
//  wgo
//
//  Created by Fabien Di Tore on 31.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController{
    IBOutlet UIButton * _btFacebook;
    IBOutlet UIButton * _btEmail;
}
@property (strong) IBOutlet UIButton * btFacebook;
-(IBAction)loginButtonClicked:(id)sender;
@end
