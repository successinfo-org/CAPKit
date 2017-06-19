//
//  MotionService.m
//  EOSFramework
//
//  Created by Sam Chang on 6/4/14.
//  Copyright (c) 2014 HP. All rights reserved.
//

#import "MotionService.h"

@implementation MotionService

+(void)load{
    [[ESRegistry getInstance] registerService: @"MotionService" withName: @"motion"];
}

-(BOOL)singleton{
    return YES;
}

- (void) start{
    if (motionManager.accelerometerAvailable) {
        [motionManager startAccelerometerUpdates];
    }
}

- (void) stop{
    if (motionManager.accelerometerAvailable) {
        [motionManager stopAccelerometerUpdates];
    }
}

- (PackedArray *) getAccelerometer{
    CMAcceleration acceleration = motionManager.accelerometerData.acceleration;
    return [[PackedArray alloc] initWithArray: @[[NSNumber numberWithDouble: acceleration.x],
                                                 [NSNumber numberWithDouble: acceleration.y],
                                                 [NSNumber numberWithDouble: acceleration.z]]];
}

-(void)onLoad{
    motionManager = [[CMMotionManager alloc] init];
    
    if (motionManager.accelerometerAvailable) {
        motionManager.accelerometerUpdateInterval = 0.01;
        referenceAttitude = motionManager.deviceMotion.attitude;
    }
}

@end
