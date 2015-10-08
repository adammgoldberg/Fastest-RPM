//
//  ViewController.m
//  FastestRPM
//
//  Created by Adam Goldberg on 2015-10-08.
//  Copyright (c) 2015 Adam Goldberg. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIImage *speedometerImage = [UIImage imageNamed:@"speedometerimage"];
    
    
    UIImageView *speedometer = [[UIImageView alloc] initWithImage:speedometerImage];
    
    speedometer.center = self.view.center;
    
    [self.view addSubview:speedometer];
    
    UIImage *pointerImage = [UIImage imageNamed:@"speedometerpointer"];
    
    
    UIImageView *pointer = [[UIImageView alloc] initWithImage:pointerImage];
    
    speedometer.center = self.view.center;
    
    [self.view addSubview:speedometer];
    
    pointer.frame = CGRectMake(80, 110, 100, 100);
    
    [speedometer addSubview:pointer];
    
    self.needleSpot = pointer;
    
    self.needleSpot.transform = CGAffineTransformMakeRotation(2.36);
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveNeedle:)];
        [panRecognizer setMinimumNumberOfTouches:1];
        [panRecognizer setMaximumNumberOfTouches:1];
        [self.view addGestureRecognizer:panRecognizer];
    
    
    
    
    
    
    
    
    
    

    
    
    
}





-(void)moveNeedle:(UIPanGestureRecognizer*)panRecog {
    [self.panTime invalidate];
    self.panTime = nil;
    
    if (panRecog.state == UIGestureRecognizerStateChanged) {
        CGPoint currentPoint = [panRecog velocityInView:self.view];
        CGFloat velocityMagnitude = sqrt((currentPoint.x * currentPoint.x) + (currentPoint.y * currentPoint.y));
        NSLog(@"velocity: %f", velocityMagnitude);
        CGFloat factor = 0.007;
        CGFloat radians = (2.36 + (velocityMagnitude * factor));
        radians = MAX(radians, (M_2_PI + M_PI_4));
        self.needleSpot.transform = CGAffineTransformMakeRotation(radians);
        
        self.panTime = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(resetNeedle:) userInfo:nil repeats:NO];
        
        [[NSRunLoop currentRunLoop] addTimer:self.panTime forMode:NSDefaultRunLoopMode];
        
    }
    else if (panRecog.state == UIGestureRecognizerStateCancelled || panRecog.state == UIGestureRecognizerStateFailed || panRecog.state == UIGestureRecognizerStateEnded) {
        self.needleSpot.transform = CGAffineTransformMakeRotation(2.36);
    }
    
}

- (void)resetNeedle:(NSTimer *)timer {
    self.needleSpot.transform = CGAffineTransformMakeRotation(2.36);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
