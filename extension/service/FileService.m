//
//  FileService.m
//  EOSFramework
//
//  Created by Sam Chang on 14-9-15.
//  Copyright (c) 2014年 HP. All rights reserved.
//

#import "FileService.h"

@implementation FileService

+(void)load{
    [[ESRegistry getInstance] registerService: @"FileService" withName: @"file"];
}

-(BOOL)singleton{
    return NO;
}

- (void) setCurrentState: (lua_State *) value{
    L = value;
}

- (LuaData *) load: (NSString *) path{
    NSURL *url = [[[OSUtils getSandboxFromState: L] getAppSandbox] resolveFile: path];
    if ([url isFileURL]) {
        return [[LuaData alloc] initWithData: [NSData dataWithContentsOfFile: [url path]] withInfo: [url path]];
    } else {
        return nil;
    }
}

@end
