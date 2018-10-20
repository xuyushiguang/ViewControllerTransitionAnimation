//
//  YXYPresentingInteractiveAnimation.h
//  ViewControllerTransitiongAnimated
//
//  Created by LiuGen on 2018/10/20.
//  Copyright © 2018年 Test. All rights reserved.
//
//带返回手势的模态

#import "YXYBasicAnimation.h"


@interface YXYPresentingInteractiveAnimation : YXYBasicAnimation<UIViewControllerTransitioningDelegate>

@property (nonatomic,assign) YXYViewControllerPresentState presentOperation;

-(instancetype)initWithFromViewController:(UIViewController *)fromVC andToViewController:(UIViewController *)toVC;



@end
