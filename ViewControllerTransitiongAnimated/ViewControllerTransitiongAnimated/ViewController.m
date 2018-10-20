//
//  ViewController.m
//  ViewControllerTransitiongAnimated
//
//  Created by LiuGen on 2018/10/19.
//  Copyright © 2018年 Test. All rights reserved.
//

#import "ViewController.h"
#import "PushViewController.h"
#import "PresentViewController.h"

#import "YXYPushPopVCAnimation.h"
#import "YXYPresentingVCAnimation.h"
#import "YXYPresentingInteractiveAnimation.h"


@interface ViewController ()
{
    YXYPresentingVCAnimation *present;
    YXYPushPopVCAnimation *push;
    YXYPresentingInteractiveAnimation *presentInteractive;
}


@end

@implementation ViewController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"viewcontroller";
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor = [UIColor redColor];
    bt.frame = CGRectMake(100, 100, 100, 50);
    [bt setTitle:@"push" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(actionForButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];

    UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt2.backgroundColor = [UIColor redColor];
    bt2.frame = CGRectMake(100, 160, 100, 50);
    [bt2 setTitle:@"present" forState:UIControlStateNormal];
    [bt2 addTarget:self action:@selector(actionForButton2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt2];
    
    UIButton *bt3 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt3.backgroundColor = [UIColor redColor];
    bt3.frame = CGRectMake(100, 220, 200, 50);
    [bt3 setTitle:@"present手势" forState:UIControlStateNormal];
    [bt3 addTarget:self action:@selector(actionForButton3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt3];
}

-(void)actionForButton3
{
    PresentViewController *vc = [[PresentViewController alloc] init];
    presentInteractive = [[YXYPresentingInteractiveAnimation alloc] initWithFromViewController:self andToViewController:vc];
    vc.transitioningDelegate = presentInteractive;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)actionForButton2
{
    PresentViewController *vc = [[PresentViewController alloc] init];
    present = [YXYPresentingVCAnimation new];
    vc.transitioningDelegate = present;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)actionForButton
{
    PushViewController *vc = [[PushViewController alloc] init];
    push = [[YXYPushPopVCAnimation alloc] initWithFromViewController:self andToViewController:vc];
    self.navigationController.delegate = push;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
