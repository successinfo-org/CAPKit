//
//  ButtonWidget.h
//  EOSClient2
//
//  Created by Song on 10/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <CAPKit/CAPKit.h>
#import "ButtonM.h"

/**The Button Widget*/
@interface ButtonWidget : AbstractUIWidget{
    UIButton *buttonView;
    UIView *buttonMaskView;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, readonly) ButtonM *model;
@property (nonatomic, readonly) ButtonM *stableModel;
#pragma clang diagnostic pop

@end
