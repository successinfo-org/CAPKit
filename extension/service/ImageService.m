//
//  ImageService.m
//  EOSFramework
//
//  Created by Sam Chang on 5/12/14.
//  Copyright (c) 2014 HP. All rights reserved.
//

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
