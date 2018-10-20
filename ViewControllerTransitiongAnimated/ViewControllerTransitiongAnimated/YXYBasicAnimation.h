//
//  YXYBasicAnimation.h
//  ViewControllerTransitiongAnimated
//
//  Created by LiuGen on 2018/10/19.
//  Copyright © 2018年 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,YXYViewControllerPresentState)
{
    YXYViewControllerPresentStatePresented,
    YXYViewControllerPresentStateDismissed,
    
};

@interface YXYBasicAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval animateInterval;///<默认0.5s,动画时间
@property (nonatomic,readonly, weak) id <UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic,readonly, weak) UIViewController  *fromViewController;
@property (nonatomic,readonly, weak) UIViewController  *toViewController;
@property (nonatomic,readonly, weak) UIView            *containerView;

@property (nonatomic, assign) UINavigationControllerOperation operation;


/**
 子类重写此方法，在这个方法里写动画过程；
 */
-(void)basicAnimateContext;


@end
