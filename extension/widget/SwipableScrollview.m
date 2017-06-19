//
//  SwipableScrollview.m
//  EOSFramework
//
//  Created by Sam Chang on 1/25/16.
//  Copyright © 2016 HP. All rights reserved.
//

#import "SwipableScrollview.h"

@implementation SwipableScrollview

-(BOOL)touchesShouldCancelInContentView:(UIView *)view{
    NSLog(@"%@", view);
    return NO;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}

@end
