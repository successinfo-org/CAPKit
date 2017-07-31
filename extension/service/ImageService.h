#import <CAPKit/CAPKit.h>
#import "lua.h"

@interface ImageService : AbstractLuaTableCompatible <IService, LuaTableCompatible>{
    lua_State *L;
}

- (LuaImage *) load: (NSString *) path;

@end
