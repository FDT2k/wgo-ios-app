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
    _contentImageView.image = [UIImage imageNamed:_imageName];
}

#pragma mark Content

- (void)setImageName:(NSString *)name
{
    _imageName = name;
    _contentImageView.image = [UIImage imageNamed:_imageName];
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
    [self._parent goToIndex:self.itemIndex+1];
    
}
@end
