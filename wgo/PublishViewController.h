//
//  PublishViewController.h
//  wgo
//
//  Created by Fabien Di Tore on 08.06.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishViewController : UIViewController{
    IBOutlet UIImageView * _imageView;
    IBOutlet UIDatePicker * _dpPicker;
}

@property (strong,nonatomic) UIImage * pic;

@end
