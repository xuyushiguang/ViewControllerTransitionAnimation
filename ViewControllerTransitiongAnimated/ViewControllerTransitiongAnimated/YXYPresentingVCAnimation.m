//
//  YXYPresentingVCAnimation.m
//  ViewControllerTransitiongAnimated
//
//  Created by LiuGen on 2018/10/20.
//  Copyright © 2018年 Test. All rights reserved.
//

#import "YXYPresentingVCAnimation.h"

@implementation YXYPresentingVCAnimation

-(instancetype)initWithAnimationOptions:(UIViewAnimationOptions)animationOperation
{
    if (self = [super init]) {
        self.animationOperation = animationOperation;
    }
    return self;
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

#pragma mark =重写方法=
-(void)basicAnimateContext
{
    switch (self.animationOperation) {
        case UIViewAnimationOptionTransitionCurlUp:
        {
            [self animationFlipFromLeft];
        }
            break;
            
        default:
        {
            if (self.presentOperation == YXYViewControllerPresentStatePresented) {
                [self presentedTransitioning];
            }else if (self.presentOperation == YXYViewControllerPresentStateDismissed){
                [self dismissTransitioning];
            }
        }
            break;
    }
    
}


-(void)animationFlipFromLeft
{
    if (self.presentOperation == YXYViewControllerPresentStatePresented) {
        
        [self.containerView addSubview:self.fromViewController.view];
       [self.containerView addSubview:self.toViewController.view];
        
        self.toViewController.view.frame = CGRectMake(0, 0, 100, 100);
        
        [UIView animateWithDuration:self.animateInterval delay:0 usingSpringWithDamping:1 initialSpringVelocity:10 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.toViewController.view.frame = CGRectMake(150, 250, 150,200);
        } completion:^(BOOL finished) {
            self.toViewController.view.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
            [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
        }];
        
        
    }else if (self.presentOperation == YXYViewControllerPresentStateDismissed){
        
        [self.containerView addSubview:self.toViewController.view];
        [self.containerView addSubview:self.fromViewController.view];
        self.toViewController.view.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
        
        [UIView animateWithDuration:self.animateInterval animations:^{
            
            self.fromViewController.view.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 1);
            
        } completion:^(BOOL finished) {
            self.fromViewController.view.layer.transform = CATransform3DIdentity;
            [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
            
        }];
    }
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
