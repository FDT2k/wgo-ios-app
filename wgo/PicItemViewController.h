//
//  PicItemViewController.h
//  wgo
//
//  Created by Fabien Di Tore on 09.06.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicItemViewController : UIViewController
// Item controller information
@property (nonatomic) NSUInteger itemIndex;
@property (nonatomic, strong) NSString *imageName;

// IBOutlets
@property (nonatomic, weak) IBOutlet UIImageView *contentImageView;
@end
