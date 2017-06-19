//
//  CanvasDisplayView.m
//  EOSFramework
//
//  Created by Sam on 5/9/12.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "CanvasDisplayView.h"

@implementation CanvasDisplayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clearsContextBeforeDrawing = NO;
        
        lock = [[NSRecursiveLock alloc] init];
        needDisplayRect = CGRectZero;
        schedulingNeedsDisplay = NO;
    }
    return self;
}

- (void) addNeedsDisplayRect: (CGRect) rect{
    [lock lock];
    needDisplayRect = CGRectUnion(needDisplayRect, rect);
    
    if (!schedulingNeedsDisplay) {
        schedulingNeedsDisplay = YES;
        
        double delayInSeconds = 0.05;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [lock lock];
            //NSLog(@"needsDisplay:%@", NSStringFromCGRect(needDisplayRect));
//            [self setNeedsDisplayInRect: needDisplayRect];
            [self setNeedsDisplay];
            needDisplayRect = CGRectZero;
            schedulingNeedsDisplay = NO;
            [lock unlock];
        });
    }
    [lock unlock];
}

- (void)drawRect:(CGRect)rect
{
    //NSLog(@"drawRect:%@", NSStringFromCGRect(rect));
	CGRect bos = self.bounds;
    rect.origin.y = bos.size.height - rect.origin.y - rect.size.height;
	
    CGRect flipped = CGRectIntersection( bos, rect );
    
    @autoreleasepool {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        
        [bitmapLock lock];
        CGImageRef imgRef = CGBitmapContextCreateImage(bitmapContext);
        CGImageRef crop = CGImageCreateWithImageInRect(imgRef, flipped);
        
        CGContextDrawImage(context, rect, crop);
        CGImageRelease(crop);
        CGImageRelease(imgRef);
        [bitmapLock unlock];
        
        CGContextRestoreGState(context);
    }
}

@end
