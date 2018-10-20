//
//  YXYPushPopVCAnimation.m
//  ViewControllerTransitiongAnimated
//
//  Created by LiuGen on 2018/10/20.
//  Copyright © 2018年 Test. All rights reserved.
//

#import "YXYPushPopVCAnimation.h"


@interface YXYPushPopVCAnimation()

@property (nonatomic, weak) UIViewController  *fromVC;
@property (nonatomic, weak) UIViewController  *toVC;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentInteractive;///<能实现控制器跟随手指滑动的类

@end
@implementation YXYPushPopVCAnimation

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
        [self.toVC.navigationController popViewControllerAnimated:YES];
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

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    //返回动画
    self.operation = operation;
    return self;
    
}
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    //返回手势
    return self.percentInteractive;
}

#pragma mark =重写方法=
-(void)basicAnimateContext
{
    if (self.operation == UINavigationControllerOperationPush) {
        [self pushInteractiveTransitioning];
    }else if (self.operation == UINavigationControllerOperationPop){
        [self popInteractiveTransitioning];
    }
}
-(void)popInteractiveTransitioning
{
    [self.containerView addSubview:self.toViewController.view];
    [self.containerView addSubview:self.fromViewController.view];
    self.toViewController.view.frame = CGRectMake(-CGRectGetWidth([UIScreen mainScreen].bounds), 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    
    UIView *snapView = [self.fromViewController.navigationController.view snapshotViewAfterScreenUpdates:NO];
    [self.containerView addSubview:snapView];
    snapView.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));;
    snapView.backgroundColor = [UIColor redColor];
    
    self.toViewController.navigationController.navigationBar.frame = CGRectMake(-CGRectGetWidth([UIScreen mainScreen].bounds), 20, CGRectGetWidth(self.toViewController.navigationController.navigationBar.frame), CGRectGetHeight(self.toViewController.navigationController.navigationBar.frame));
    self.fromViewController.navigationItem.title = self.toViewController.title;
    [UIView animateWithDuration:self.animateInterval
                          delay:0.0f
         usingSpringWithDamping:1 initialSpringVelocity:0.f options:0 animations:^{
             
             self.toViewController.navigationController.navigationBar.frame = CGRectMake(0, 20, CGRectGetWidth(self.toViewController.navigationController.navigationBar.frame), CGRectGetHeight(self.toViewController.navigationController.navigationBar.frame));
             
             
             self.toViewController.view.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
             
             self.fromViewController.view.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds), 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
             snapView.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds), 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
             
         } completion:^(BOOL finished) {
             [snapView removeFromSuperview];
             self.toViewController.navigationController.navigationBar.frame = CGRectMake(0, 20, CGRectGetWidth(self.toViewController.navigationController.navigationBar.frame), CGRectGetHeight(self.toViewController.navigationController.navigationBar.frame));
             [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
         }];
}
-(void)pushInteractiveTransitioning
{
    [self.containerView addSubview:self.fromViewController.view];
    [self.containerView addSubview:self.toViewController.view];
    self.toViewController.view.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    [UIView animateWithDuration:self.animateInterval animations:^{
        self.toViewController.view.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    } completion:^(BOOL finished) {
        [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
    }];
}


@end
