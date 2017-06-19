//
//  CanvasDisplayView.h
//  EOSFramework
//
//  Created by Sam on 5/9/12.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CanvasDisplayView : UIView{
    CGRect needDisplayRect;
    BOOL schedulingNeedsDisplay;
    NSRecursiveLock *lock;
    @public
    CGContextRef bitmapContext;
    NSRecursiveLock *bitmapLock;
}

- (void) addNeedsDisplayRect: (CGRect) rect;
@end
