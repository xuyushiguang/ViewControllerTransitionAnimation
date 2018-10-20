//
//  YXYBasicAnimation.m
//  ViewControllerTransitiongAnimated
//
//  Created by LiuGen on 2018/10/19.
//  Copyright © 2018年 Test. All rights reserved.
//

#import "YXYBasicAnimation.h"

@interface YXYBasicAnimation()
@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, weak) UIViewController  *fromViewController;
@property (nonatomic, weak) UIViewController  *toViewController;
@property (nonatomic, weak) UIView            *containerView;


@end

@implementation YXYBasicAnimation

-(instancetype)init
{
    if (self = [super init]) {
        self.animateInterval = 0.25f;
    }
    return self;
}


#pragma mark =重写方法=
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return self.animateInterval;
    
}
#pragma mark =重写方法=
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.containerView      = [transitionContext containerView];
    self.transitionContext  = transitionContext;
    
    [self basicAnimateContext];
}

/**
 留给子类重写的方法，在此方法写动画过程
 */
-(void)basicAnimateContext
{
   
}





@end
