//
//  ImageWidget.h
//  EOSClient2
//
//  Created by Song on 10/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <CAPKit/CAPKit.h>
#import "IImageWidget.h"
#import "ImageM.h"

/**The Image Widget*/
@interface ImageWidget : AbstractUIWidget <IImageWidget>{
    UIImageView *imageView;
    UIView *view;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, readonly) ImageM *model;
@property (nonatomic, readonly) ImageM *stableModel;
#pragma clang diagnostic pop

- (void) setImage: (UIImage *) img;
- (UIImage *) getImage;
@end
