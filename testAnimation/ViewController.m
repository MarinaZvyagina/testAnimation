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
@property (nonatomic, strong) NSArray <UIButton *> *buttons;
@end

static NSUInteger countOfButtons = 5;

@implementation ViewController

-(void) initButtons {
    NSArray <UIColor *> * colors = @[UIColor.blueColor, UIColor.grayColor, UIColor.redColor, UIColor.yellowColor, UIColor.orangeColor];
    NSMutableArray <UIButton *> *currentButtons = [NSMutableArray<UIButton *> new];
    
    for (NSUInteger i = 0; i<countOfButtons; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*50 + 20, 20, 40, 50)];
        button.backgroundColor = colors[i];
        [currentButtons addObject:button];
        [self.view addSubview:button];
    }
    self.buttons = [[NSArray<UIButton *> alloc] initWithArray:currentButtons];;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self initButtons];

    [self.buttons[0] addTarget:self action:@selector(makeInvisible) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons[1] addTarget:self action:@selector(makeVisible) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons[2] addTarget:self action:@selector(rotateView) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons[3] addTarget:self action:@selector(moveView) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons[4] addTarget:self action:@selector(groupAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    self.visibleView = [[UIView alloc] initWithFrame:CGRectMake(100, 170, 100, 100)];
    self.visibleView.backgroundColor = [UIColor greenColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    orbit.path = CFAutorelease(CGPathCreateWithRect(boundingRect, NULL));    orbit.duration = 4;
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
