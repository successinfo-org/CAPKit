//
//  TextfieldWidget.h
//  EOSClient2
//
//  Created by Song on 10/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CAPKit/CAPKit.h>
#import "ITextfieldWidget.h"
#import "EOSTextField.h"

/**The Textfield Widget*/
@interface TextfieldWidget : AbstractUIWidget <UITextFieldDelegate, ITextfieldWidget>{
    EOSTextField *textfieldView;
    BOOL focus;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, readonly) TextfieldM *model;
@property (nonatomic, readonly) TextfieldM *stableModel;
#pragma clang diagnostic pop

@end
