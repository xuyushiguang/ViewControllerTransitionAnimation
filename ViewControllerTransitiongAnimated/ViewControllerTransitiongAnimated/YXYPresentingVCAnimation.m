//
//  YXYPresentingVCAnimation.m
//  ViewControllerTransitiongAnimated
//
//  Created by LiuGen on 2018/10/20.
//  Copyright © 2018年 Test. All rights reserved.
//

#import "YXYPresentingVCAnimation.h"

@implementation YXYPresentingVCAnimation


#pragma mark =重写方法=
-(void)basicAnimateContext
{
    if (self.presentOperation == YXYViewControllerPresentStatePresented) {
        [self presentedTransitioning];
    }else if (self.presentOperation == YXYViewControllerPresentStateDismissed){
        [self dismissTransitioning];
    }
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.presentOperation = YXYViewControllerPresentStatePresented;
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.presentOperation = YXYViewControllerPresentStateDismissed;
    return self;
}

-(void)dismissTransitioning
{
    [self.containerView addSubview:self.toViewController.view];
    [self.containerView addSubview:self.fromViewController.view];
    self.fromViewController.view.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    self.fromViewController.view.clipsToBounds = YES;
    [UIView animateWithDuration:self.animateInterval animations:^{
        
        self.fromViewController.view.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/2, CGRectGetHeight([UIScreen mainScreen].bounds)/2, 4, 4);
        
    } completion:^(BOOL finished) {
        [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
    }];
}
-(void)presentedTransitioning
{
    [self.containerView addSubview:self.fromViewController.view];
    [self.containerView addSubview:self.toViewController.view];
    self.toViewController.view.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/2, CGRectGetHeight([UIScreen mainScreen].bounds)/2, 4, 4);
    self.toViewController.view.clipsToBounds = YES;
    [UIView animateWithDuration:self.animateInterval animations:^{
        self.toViewController.view.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    } completion:^(BOOL finished) {
        [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
    }];
}

@end
