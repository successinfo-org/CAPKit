//
//  SwitchWidget.m
//  EOSFramework
//
//  Created by Sam on 6/20/12.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "SwitchWidget.h"
#import "SwitchM.h"

@implementation SwitchWidget

+(void)load{
    [WidgetMap bind: @"switch" withModelClassName: @"SwitchM" withWidgetClassName: @"SwitchWidget"];
}

-(void)onCreateView{
    container = [[UIView alloc] initWithFrame: [self getActualCurrentRect]];
    switchView = [[UISwitch alloc] initWithFrame: CGRectZero];
    switchView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [switchView addTarget: self action: @selector(valueChanged) forControlEvents: UIControlEventValueChanged];
    switchView.on = ((SwitchM *) self.model).checked;
    [container addSubview: switchView];
}

- (void) valueChanged{
    ((SwitchM *) self.model).checked = switchView.on;
    
    [OSUtils executeDirect: ((SwitchM *) self.model).onchange withSandbox: self.pageSandbox];
}

-(UIView *)innerView{
    return container;
}

#pragma mark Lua API Begin

- (void) _LUA_setChecked: (NSNumber *) ckd{
    if (![ckd respondsToSelector: @selector(boolValue)]) {
        return;
    }
    ((SwitchM *) self.model).checked = [ckd boolValue];

    [OSUtils runBlockOnMain:^{
        switchView.on = [ckd boolValue];
    }];
}

- (NSNumber *) _LUA_getChecked{
    return [NSNumber numberWithBool: ((SwitchM *) self.model).checked];
}

#pragma mark Lua API End

@end
