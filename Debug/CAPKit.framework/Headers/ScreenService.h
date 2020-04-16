//
//  ScreenService.h
//  BookShelf
//
//  Created by Sam Chang on 1/2/14.
//  Copyright (c) 2014 Jian-Guo Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CAPKit/CAPKit.h>

@interface ScreenService : AbstractLuaTableCompatible <IService, LuaTableCompatible>{
    lua_State *L;

    UIWindow *window;    
    UIScreen *screen;
    
    BOOL hidden;
}

@property (nonatomic, strong) CAPAbstractUIWidget *contentWidget;
@property (nonatomic, strong) UIViewController *rootViewController;

- (void)refreshScreen: (NSNotification *)notification;
- (void) hide;

@end
