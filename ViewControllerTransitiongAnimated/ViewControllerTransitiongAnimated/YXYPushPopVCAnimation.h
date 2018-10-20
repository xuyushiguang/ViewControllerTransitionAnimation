//
//  YXYPushPopVCAnimation.h
//  ViewControllerTransitiongAnimated
//
//  Created by LiuGen on 2018/10/20.
//  Copyright © 2018年 Test. All rights reserved.
//

#import "YXYBasicAnimation.h"

@interface YXYPushPopVCAnimation : YXYBasicAnimation<UINavigationControllerDelegate>

-(instancetype)initWithFromViewController:(UIViewController *)fromVC andToViewController:(UIViewController *)toVC;


@end
