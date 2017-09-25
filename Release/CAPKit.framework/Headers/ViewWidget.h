//
//  ViewWidget.h
//  EOSClient2
//
//  Created by Song on 10/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CAPKit/EOSView.h>

/**The View Widget*/
@interface ViewWidget : AbstractUIWidget<IViewWidget>{
    NSMutableArray *internalSubitems;
    CGRect contentRect;
    UIView *view;
    
    BOOL initedSubview;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, readonly) ViewM *model;
@property (nonatomic, readonly) ViewM *stableModel;
#pragma clang diagnostic pop

@property (nonatomic, readonly, getter=getSubitems) NSArray *subitems;

@property (nonatomic, assign) BOOL destroyOnRemoved;

- (void) addWidget: (AbstractUIWidget *) widget;
- (void) addWidget: (AbstractUIWidget *) widget At: (int) idx;

-(id)initWithModel:(UIWidgetM *)m withView: (UIView *) v withPageSandbox: (PageSandbox *) sandbox;

- (void) reLayoutChildren;
- (void) removeAllChildren;

#ifdef DEBUG_EOS
- (NSUInteger) childrenCount;
- (NSUInteger) affectCount;
#endif

@end
