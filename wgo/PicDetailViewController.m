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
    _controllers = [[NSMutableArray alloc] init];
    [self createPageViewController];
    //[self initViews];
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

-(void) initViews{
    for (int i = 0 ; i < pics.count; i++) {
        UIImageView * iv = [[UIImageView alloc] init];
        [iv setImage:[UIImage imageNamed:[pics objectAtIndex:i]]];
        [_controllers addObject:iv];
        iv.frame = CGRectMake(40, 118, 240, 200);
        [self.view addSubview:iv];
    }
}
-(IBAction) popTopView:(id)sender{
    UIView * v = _controllers.lastObject;
    [_controllers removeLastObject];
    [UIView animateWithDuration:0.5 animations:^{
        
        [v setFrame:CGRectMake(v.frame.origin.x+320, v.frame.origin.y, v.frame.size.width, v.frame.size.height)];
    } completion:^(BOOL finished) {
        
        if(_controllers.count == 0){
            [self performSegueWithIdentifier:@"map" sender:self];
        }
        
    }];
    
}

- (void)createPageViewController
{
    CGFloat contentHeight= 0;
    for (NSUInteger itemIndex = 0; itemIndex< [pics count]; itemIndex++){
        PicItemViewController *picItemViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PicView"];
       /* picItemViewController.itemIndex = itemIndex;
        picItemViewController._parent = self;
        picItemViewController.imageName = pics[itemIndex];*/
        [_controllers addObject:picItemViewController];
        [picItemViewController setImageName:[pics objectAtIndex:itemIndex]];
        [scrollView addSubview:picItemViewController.view];
        CGRect frame = CGRectMake(0, contentHeight, self.view.frame.size.width, 300);
        picItemViewController.view.frame = frame;
        contentHeight += picItemViewController.view.frame.size.height;
    }
    
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, contentHeight)];

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
        return [_controllers objectAtIndex:itemIndex];
    }
    
    return nil;
}


-(void) goToIndex:(NSInteger) index{
    if (index < [pics count]){
    UIViewController * test = [self itemControllerForIndex:index];
    [self.pageViewController setViewControllers:@[test] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }else{
        [self performSegueWithIdentifier:@"map" sender:self];
    }

}
@end
