//
//  PicViewController.h
//  wgo
//
//  Created by Fabien Di Tore on 07.06.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicViewController : UIViewController{
    UIImagePickerController* imagePicker;
    UIImage * pic;
}
-(IBAction) startTakingPicture:(id)sender;
-(IBAction) startPickingArchive:(id)sender;
@end
