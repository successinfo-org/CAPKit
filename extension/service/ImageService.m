#import "ImageService.h"

@implementation ImageService

+(void)load{
    [[ESRegistry getInstance] registerService: @"ImageService" withName: @"image"];
}

-(BOOL)singleton{
    return NO;
}

- (void) setCurrentState: (lua_State *) value{
    L = value;
}

- (LuaImage *) load: (NSString *) path{
    NSURL *url = [[OSUtils getSandboxFromState: L] resolveFile: path];
    if ([url isFileURL]) {
        return [[LuaImage alloc] initWithPath: [url path]];
    } else {
        return nil;
    }
}

@end
