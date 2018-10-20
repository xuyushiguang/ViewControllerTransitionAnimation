//
//  PresentViewController.m
//  ViewControllerTransitiongAnimated
//
//  Created by LiuGen on 2018/10/20.
//  Copyright © 2018年 Test. All rights reserved.
//

#import "PresentViewController.h"
//#import "YXYPresentingAnimation.h"
@interface PresentViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation PresentViewController
-(void)dealloc
{
    NSLog(@"*****dealloc PresentViewController");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor = [UIColor redColor];
    bt.frame = CGRectMake(100, 100, 100, 50);
    [bt setTitle:@"dismiss" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(actionForButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];

//    self.transitioningDelegate = self;
    
}

-(void)actionForButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
