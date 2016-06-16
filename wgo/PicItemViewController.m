//
//  PicItemViewController.m
//  wgo
//
//  Created by Fabien Di Tore on 09.06.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import "PicItemViewController.h"

@interface PicItemViewController ()

@end

@implementation PicItemViewController



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _contentImageView.image = [UIImage imageNamed:[_imageName objectAtIndex:0]];
    [lblDate setText:[_imageName objectAtIndex:1]];
}

#pragma mark Content

- (void)setImageName:(NSArray *)name
{
    _imageName = name;
    if (_contentImageView){
    _contentImageView.image = [UIImage imageNamed:[_imageName objectAtIndex:0]];
    }
    if(lblDate){
        [lblDate setText:[_imageName objectAtIndex:1]];
    }
    }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction) vote:(id)sender{
    /*[self._parent.pageViewController setViewControllers:[self._parent itemControllerForIndex:self.itemIndex+1] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
*/
    score +=1;
    [lblLike setText:[NSString stringWithFormat:@"%ld Likes",score]];
    
}
@end
