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

-(void) viewDidUnload{
    NSLog(@"unloaded");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"deallocing");
}

-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if(_done){
        [_lblWelcome setText:[NSString stringWithFormat:@"Welcome %@",[[LocalData sharedInstance] getNickname]]];
        [UIView animateWithDuration:0.1 animations:^{
            
            [_lblTitle setAlpha:0];
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:1 animations:^{
                
                [_lblWelcome setAlpha:1];
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:1 animations:^{
                    
                    [_lblWelcome setAlpha:0];
                    
                } completion:^(BOOL finished) {
                    [_lblWelcome setText:@"Let's have a look around"];
                    [UIView animateWithDuration:1 animations:^{
                        
                        [_lblWelcome setAlpha:1];
                        
                    } completion:^(BOOL finished) {
                       // [_lblWelcome setText:@"Let's have look around"];
                        
                    }];
                }];
            }];
        }];
        
    }
    
}

-(void) timer:(NSTimer*)timer{
    //return;
    if (_loaded + 3 < [[NSDate date] timeIntervalSince1970] && !_done){
        
        [self performSegueWithIdentifier:@"to_description" sender:self];
        _done =YES;
    }
}

-(IBAction) startTakingPicture{
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera | UIImagePickerControllerSourceTypePhotoLibrary;
        
        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            
            imagePickerController.cameraDevice =  UIImagePickerControllerCameraDeviceFront;
        } else {
            imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
        
      //  [self.navigationController presentViewController:imagePickerController animated:NO completion:nil];
      //  [self addChildViewController:imagePickerController];
      //  [imagePickerController didMoveToParentViewController:self];
      //  [self.view addSubview:imagePickerController.view];
    }
    else {
        // do stuff ///....Alert 
    }
    
 //   [self presentViewController:c animated:YES completion:^{
      
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    
//    [imagePickerController.view removeFromSuperview];
//    [imagePickerController removeFromParentViewController];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
 //   [imagePickerController.view removeFromSuperview];
 //   [imagePickerController removeFromParentViewController];
  //  [self.navigationController popToRootViewControllerAnimated:NO];
   // [self dismissViewControllerAnimated:NO completion:nil];
   [picker performSegueWithIdentifier:@"exit" sender:self];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [_lblTitle setAlpha:0];
    [_btCamera setAlpha:1];
    if ([[segue identifier] isEqualToString:@"imagepicker"]){
        UIImagePickerController * picker = [[segue destinationViewController] init];
        picker.delegate = self;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}


@end
