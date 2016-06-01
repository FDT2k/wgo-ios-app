//
//  MainViewController.h
//  wgo
//
//  Created by Fabien Di Tore on 30.05.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UIImagePickerControllerDelegate>{
    
    UIImagePickerController * imagePickerController;
    IBOutlet UIView * _lblTitle;
    IBOutlet UIButton * _btCamera;
    IBOutlet UILabel * _lblWelcome;
    NSTimeInterval  _loaded;
    BOOL _done;
}

-(IBAction) startTakingPicture;
@end
