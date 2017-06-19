//
//  ScrollViewWidget.h
//  EOSClient2
//
//  Created by Chang Sam on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CAPKit/CAPKit.h>
#import "IScrollViewWidget.h"
#import "ScrollViewM.h"
#import "EGORefreshScrollView.h"

@interface ScrollViewWidget : ViewWidget <IScrollViewWidget, UIScrollViewDelegate, EGORefreshScrollViewDelegate>{
    CGPoint oldContentOffset;
    CGSize currentContentSize;
    CGPoint currentContentOffset;
    
    CGRect originalRect;
    
    BOOL dragDowning;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, readonly) ScrollViewM *model;
@property (nonatomic, readonly) ScrollViewM *stableModel;
#pragma clang diagnostic pop

@property (nonatomic, strong) AbstractUIWidget *editingFocusView;

@property (nonatomic, readonly) EGORefreshScrollView *refreshScrollView;

@end
