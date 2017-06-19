//
//  MotionService.h
//  EOSFramework
//
//  Created by Sam Chang on 6/4/14.
//  Copyright (c) 2014 HP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <CAPKit/CAPKit.h>

@interface MotionService : AbstractLuaTableCompatible <IService> {
    CMMotionManager *motionManager;
    CMAttitude *referenceAttitude;

    NSMutableArray *watchers;
}

@end
