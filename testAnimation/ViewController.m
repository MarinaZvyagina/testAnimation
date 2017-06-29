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
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 20, 40, 50)];
    button2.backgroundColor = [UIColor grayColor];
    [button2 addTarget:self action:@selector(makeVisible) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(180, 20, 40, 50)];
    button3.backgroundColor = [UIColor redColor];
    [button3 addTarget:self action:@selector(rotateView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(260, 20, 40, 50)];
    button4.backgroundColor = [UIColor yellowColor];
    [button4 addTarget:self action:@selector(moveView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button5 = [[UIButton alloc] initWithFrame:CGRectMake(340, 20, 40, 50)];
    button5.backgroundColor = [UIColor orangeColor];
    [button5 addTarget:self action:@selector(groupAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.visibleView = [[UIView alloc] initWithFrame:CGRectMake(100, 170, 100, 100)];
    self.visibleView.backgroundColor = [UIColor greenColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:button];
    [self.view addSubview:button2];
    [self.view addSubview:button3];
    [self.view addSubview:button4];
    [self.view addSubview:button5];
    
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

}

-(void) groupAnimation {
    
    CABasicAnimation *zPosition = [CABasicAnimation animation];
    zPosition.keyPath = @"zPosition";
    zPosition.fromValue = @-1;
    zPosition.toValue = @1;
    zPosition.duration = 1.2;
    
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.values = @[ @0, @0.14, @0 ];
    rotation.duration = 1.2;
    rotation.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
    
    CAKeyframeAnimation *position = [CAKeyframeAnimation animation];
    position.keyPath = @"position";
    position.values = @[
                        [NSValue valueWithCGPoint:CGPointZero],
                        [NSValue valueWithCGPoint:CGPointMake(110, -20)],
                        [NSValue valueWithCGPoint:CGPointZero]
                        ];
    position.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
    position.additive = YES;
    position.duration = 1.2;
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[ zPosition, rotation, position ];
    group.duration = 1.2;
    group.beginTime = 0.5;
    
    [self.visibleView.layer addAnimation:group forKey:@"shuffle"];
    
    self.visibleView.layer.zPosition = 1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
