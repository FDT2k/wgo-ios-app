//
//  PicDetailViewController.h
//  wgo
//
//  Created by Fabien Di Tore on 09.06.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicDetailViewController : UIViewController <UIPageViewControllerDelegate,UIPageViewControllerDataSource>
{
    NSMutableArray * _controllers;
    IBOutlet UIScrollView * scrollView;
}


@property(strong) NSMutableArray * pics;
@property (strong) UIPageViewController * pageViewController;
-(void) goToIndex:(NSInteger) index;
-(IBAction) popTopView:(id)sender;
@end
