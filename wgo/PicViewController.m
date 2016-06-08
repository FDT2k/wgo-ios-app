//
//  PicViewController.m
//  wgo
//
//  Created by Fabien Di Tore on 07.06.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import "PicViewController.h"

@interface PicViewController ()

@end

@implementation PicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction) startTakingPicture:(id)sender{
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera ;
        
        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            
            imagePicker.cameraDevice =  UIImagePickerControllerCameraDeviceFront;
        } else {
            imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
        
        //  [self.navigationController presentViewController:imagePickerController animated:NO completion:nil];
        //  [self addChildViewController:imagePickerController];
        //  [imagePickerController didMoveToParentViewController:self];
        //  [self.view addSubview:imagePickerController.view];
        
        [self addChildViewController:imagePicker];
        [imagePicker didMoveToParentViewController:self];
        [self.view addSubview:imagePicker.view];
    }
    else {
        // do stuff ///....Alert
        UIAlertView * v = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support taking pictures" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [v show];
    }
    
    //   [self presentViewController:c animated:YES completion:^{
    
}

-(IBAction) startPickingArchive:(id)sender{
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
                
        //  [self.navigationController presentViewController:imagePickerController animated:NO completion:nil];
          [self addChildViewController:imagePicker];
          [imagePicker didMoveToParentViewController:self];
          [self.view addSubview:imagePicker.view];
    }
    else {
        // do stuff ///....Alert
        UIAlertView * v = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support photo library " delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [v show];
    }

    
    //   [self presentViewController:c animated:YES completion:^{
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    
    [self closePicker];
    
}

-(void) closePicker{
    [imagePicker.view removeFromSuperview];
    [imagePicker removeFromParentViewController];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self closePicker];
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
