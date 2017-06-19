//
//  PhotoService.h
//  EOSFramework
//
//  Created by Sam Chang on 5/12/14.
//  Copyright (c) 2014 HP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CAPKit/CAPKit.h>

#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoService : AbstractLuaTableCompatible <IService, LuaTableCompatible>

@property (nonatomic, readonly) ALAssetsLibrary * assetsLibrary;

- (void) load: (LuaFunction *) func;

@end
