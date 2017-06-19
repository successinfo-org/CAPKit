//
//  ImageService.h
//  EOSFramework
//
//  Created by Sam Chang on 5/12/14.
//  Copyright (c) 2014 HP. All rights reserved.
//

#import <CAPKit/CAPKit.h>
#import "lua.h"

@interface ImageService : AbstractLuaTableCompatible <IService, LuaTableCompatible>{
    lua_State *L;
}

- (LuaImage *) load: (NSString *) path;

@end
