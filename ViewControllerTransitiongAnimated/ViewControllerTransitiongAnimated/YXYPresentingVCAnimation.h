//
//  YXYPresentingVCAnimation.h
//  ViewControllerTransitiongAnimated
//
//  Created by LiuGen on 2018/10/20.
//  Copyright © 2018年 Test. All rights reserved.
//

#import "YXYBasicAnimation.h"



@interface YXYPresentingVCAnimation : YXYBasicAnimation<UIViewControllerTransitioningDelegate>

@property (nonatomic,assign) YXYViewControllerPresentState presentOperation;
@property (nonatomic,assign) UIViewAnimationOptions animationOperation;

-(instancetype)initWithAnimationOptions:(UIViewAnimationOptions)animationOperation;


@end
