//
//  TestViewController.h
//  wgo
//
//  Created by Fabien Di Tore on 30.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController{


IBOutlet UITextField * _email;
IBOutlet UITextField * _password;
    IBOutlet UIButton * _button;
}

-(IBAction)postAuthenticate:(id)sender;
@end
