//
//  ImageCache.h
//  EOSFramework
//
//  Created by Sam Chang on 14-7-3.
//  Copyright (c) 2014年 HP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CAPKit/LruCache.h>

@interface ImageCache : LruCache

@property (nonatomic, assign) BOOL disabled;

+ (ImageCache *) sharedInstance;

@end
