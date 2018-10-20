//
//  YXYPresentingInteractiveAnimation.m
//  ViewControllerTransitiongAnimated
//
//  Created by LiuGen on 2018/10/20.
//  Copyright © 2018年 Test. All rights reserved.
//

#import "YXYPresentingInteractiveAnimation.h"

@interface YXYPresentingInteractiveAnimation()
@property (nonatomic, weak) UIViewController  *fromVC;
@property (nonatomic, weak) UIViewController  *toVC;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentInteractive;///<能实现控制器跟随手指滑动的类

@end


@implementation YXYPresentingInteractiveAnimation

-(instancetype)initWithFromViewController:(UIViewController *)fromVC andToViewController:(UIViewController *)toVC
{
    if (self = [super init]) {
        self.fromVC = fromVC;
        self.toVC = toVC;
        UIScreenEdgePanGestureRecognizer *leftPanGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(leftPanGestureRecognizer:)];
        leftPanGesture.edges = UIRectEdgeLeft;
        [self.toVC.view addGestureRecognizer:leftPanGesture];
    }
    return self;
}

-(void)leftPanGestureRecognizer:(UIScreenEdgePanGestureRecognizer*)recognizer
{
    // 手指滑动距离和屏幕宽的比例
    CGFloat progress = [recognizer translationInView:self.toVC.view].x / (CGRectGetWidth(self.toVC.view.frame));
    // 修正比例值，便于视图和手指同步
    progress = MIN(1.0, MAX(0, progress)) * 0.5;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        //初始化能实现控制器跟随手指滑动的类
        self.percentInteractive = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.fromVC dismissViewControllerAnimated:YES completion:nil];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // 更新view
        [self.percentInteractive updateInteractiveTransition:progress];
        
    } else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded) {
        // 停止滑动
        if (progress > 0.18) {
            [self.percentInteractive finishInteractiveTransition];
        }else{
            [self.percentInteractive cancelInteractiveTransition];
        }
        self.percentInteractive = nil;
    }
}

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
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return self.percentInteractive;
}


-(void)dismissTransitioning
{
    [self.containerView addSubview:self.toViewController.view];
    [self.containerView addSubview:self.fromViewController.view];
    self.fromViewController.view.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    self.fromViewController.view.clipsToBounds = YES;
    [UIView animateWithDuration:self.animateInterval animations:^{
        
        self.fromViewController.view.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds),CGRectGetHeight([UIScreen mainScreen].bounds));
        
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
