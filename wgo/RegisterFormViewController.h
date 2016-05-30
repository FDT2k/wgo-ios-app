//
//  RegisterFormViewController.h
//  wgo
//
//  Created by Fabien Di Tore on 30.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterFormViewController : UIViewController{
    IBOutlet UITextField * _email;
    IBOutlet UITextField * _password;
}

-(IBAction)submitForm:(id)sender;

@end
