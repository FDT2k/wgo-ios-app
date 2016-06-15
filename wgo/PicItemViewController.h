//
//  PicItemViewController.h
//  wgo
//
//  Created by Fabien Di Tore on 09.06.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PicDetailViewController.h"

@interface PicItemViewController : UIViewController{
    IBOutlet UILabel * lblLike;
    NSInteger score;
}
// Item controller information
@property (nonatomic) NSUInteger itemIndex;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, weak) PicDetailViewController * _parent;
// IBOutlets
@property (nonatomic, weak) IBOutlet UIImageView *contentImageView;

-(IBAction) vote:(id)sender;
@end
