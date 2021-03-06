//
//  ITextfieldWidget.h
//  EOSFramework
//
//  Created by Sam Chang on 3/21/12.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <CAPKit/CAPKit.h>

@protocol ITextfieldWidget <NSObject>

- (NSObject *) getText;
- (void) setText: (NSObject *) txt;
- (void) setFocus;
- (void) clearFocus;

@end
