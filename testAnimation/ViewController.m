//
//  ViewController.m
//  testAnimation
//
//  Created by iOS-School-1 on 03.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView * visibleView;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 40, 50)];
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(makeInvisible) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(120, 20, 40, 50)];
    button2.backgroundColor = [UIColor grayColor];
    [button2 addTarget:self action:@selector(makeVisible) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(220, 20, 40, 50)];
    button3.backgroundColor = [UIColor redColor];
    [button3 addTarget:self action:@selector(rotateView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(320, 20, 40, 50)];
    button4.backgroundColor = [UIColor yellowColor];
    [button4 addTarget:self action:@selector(moveView) forControlEvents:UIControlEventTouchUpInside];
    
    self.visibleView = [[UIView alloc] initWithFrame:CGRectMake(100, 170, 100, 100)];
    self.visibleView.backgroundColor = [UIColor greenColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:button];
    [self.view addSubview:button2];
    [self.view addSubview:button3];
    [self.view addSubview:button4];
    
    [self.view addSubview:self.visibleView];
    

}

-(void) makeInvisible {
    [UIView animateWithDuration:3.0 animations:^{
        self.visibleView.alpha = 0.0;
    }];
}

-(void) makeVisible {
    [UIView animateWithDuration:3.0 animations:^{
        self.visibleView.alpha = 1.0;
    }];
}

-(void) rotateView {
    CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rand());
    [UIView animateWithDuration:3.0 animations:^{
        self.visibleView.transform = transform;
    }];
    
}

-(void) moveView {
    
    CGRect boundingRect = CGRectMake(-150, -150, 300, 300);
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithRect(boundingRect, NULL));//(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode = kCAAnimationRotateAuto;
    
    [self.visibleView.layer addAnimation:orbit forKey:@"orbit"];
    
    
   /* CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[ @0, @10, @-10, @10, @0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.4;
    
    animation.additive = YES;
    
    [self.visibleView.layer addAnimation:animation forKey:@"shake"];
    */
    /*
    CGPoint f = self.visibleView.center;
    f.x = rand() % 300; // new x
    f.y = rand() %300; // new y
    [UIView animateWithDuration:4.0 animations:^{
        self.visibleView.center = f;
    }];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
