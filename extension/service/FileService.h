//
//  FileService.h
//  EOSFramework
//
//  Created by Sam Chang on 14-9-15.
//  Copyright (c) 2014年 HP. All rights reserved.
//

#import <CAPKit/CAPKit.h>
#import "lua.h"

@interface FileService : AbstractLuaTableCompatible <IService, LuaTableCompatible> {
    lua_State *L;
}

- (LuaData *) load: (NSString *) path;

@end
