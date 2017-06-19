//
//  BusyWidget.m
//  EOSFramework
//
//  Created by Chang Sam on 12/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BusyWidget.h"

@implementation BusyWidget

+(void)load{
    [WidgetMap bind: @"busy" withModelClassName: @"BusyM" withWidgetClassName: @"BusyWidget"];
}

-(id)initWithModel:(UIWidgetM *)m withPageSandbox:(PageSandbox *)sandbox{
    self = [super initWithModel: m withPageSandbox: sandbox];
    
    if (self) {
        indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
        containView = [[UIView alloc] initWithFrame: CGRectZero];
        containView.backgroundColor = [UIColor clearColor];
        [containView addSubview: indicatorView];
    }
    return self;
}

-(void)setViewFrame:(CGRect)rect{
    [super setViewFrame: rect];
    
    indicatorView.center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
}

-(UIView *)innerView{
    return containView;
}

@end
