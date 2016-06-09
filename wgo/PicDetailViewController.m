//
//  PicDetailViewController.m
//  wgo
//
//  Created by Fabien Di Tore on 09.06.16.
//  Copyright © 2016 Fabien Di Tore. All rights reserved.
//

#import "PicDetailViewController.h"
#import "PicItemViewController.h"
@interface PicDetailViewController ()

@end

@implementation PicDetailViewController
@synthesize pics;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPageViewController];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)createPageViewController
{
   /* _contentImages = @[@"nature_pic_1",
                       @"nature_pic_2",
                       @"nature_pic_3",
                       @"nature_pic_4"];
    */
    UIPageViewController *pageController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageController"];
    
    pageController.dataSource = self;
    [pageController.view setBackgroundColor:[UIColor clearColor]];
    if([self.pics count])
    {
        NSArray *startingViewControllers = @[[self itemControllerForIndex:0]];
        [pageController setViewControllers:startingViewControllers
                                 direction:UIPageViewControllerNavigationDirectionForward
                                  animated:NO
                                completion:nil];
    }
    
    
    
    self.pageViewController = pageController;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)setupPageControl
{
    [[UIPageControl appearance] setPageIndicatorTintColor:[UIColor grayColor]];
    [[UIPageControl appearance] setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
    [[UIPageControl appearance] setBackgroundColor:[UIColor darkGrayColor]];
}

#pragma mark UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    PicItemViewController *itemController = (PicItemViewController *)viewController;
    
    if (itemController.itemIndex > 0)
    {
        return [self itemControllerForIndex:itemController.itemIndex-1];
    }
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    PicItemViewController *itemController = (PicItemViewController *)viewController;
    
    if (itemController.itemIndex+1 < [pics count])
    {
        return [self itemControllerForIndex:itemController.itemIndex+1];
    }
    
    return nil;
}

- (PicItemViewController *)itemControllerForIndex:(NSUInteger)itemIndex
{
    if (itemIndex < [pics count])
    {
        PicItemViewController *picItemViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemController"];
        picItemViewController.itemIndex = itemIndex;
        picItemViewController.imageName = pics[itemIndex];
        return picItemViewController;
    }
    
    return nil;
}

@end
