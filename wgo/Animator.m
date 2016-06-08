//
//  Animator.m
//  NavigationTransitionTest
//
//  Created by Chris Eidhof on 9/27/13.
//  Copyright (c) 2013 Chris Eidhof. All rights reserved.
//

#import "Animator.h"

@implementation Animator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
   /* toViewController.view.alpha = 0;
    fromViewController.view.alpha = 0;
    toViewController.view.alpha = 1;
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
   */
    [UIView animateWithDuration:[self transitionDuration:transitionContext]/2 animations:^{
        //fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        fromViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
       
        [UIView animateWithDuration:[self transitionDuration:transitionContext]/2 animations:^{
            //fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
            toViewController.view.alpha = 1;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
    }];
}

@end
