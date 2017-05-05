//
//  ModelBuilder.h
//  EOSClient2
//
//  Created by Chang Sam on 10/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CAPKit/UIWidgetM.h>
#import <CAPKit/ViewM.h>

@class PageM;

@interface ModelBuilder : NSObject

+ (UIWidgetM *) buildModel: (NSDictionary *) dic;

+ (ViewM *) buildModelFromArray: (NSArray *) list;

+ (PageM *) buildPage: (NSDictionary *) dic;
+ (PageM *) buildPageFromURL: (NSURL *) pageURL;

@end
