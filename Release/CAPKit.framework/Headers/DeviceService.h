//
//  DeviceService.h
//  EOSFramework
//
//  Created by Sam Chang on 5/29/14.
//  Copyright (c) 2014 HP. All rights reserved.
//

#import <CAPKit/CAPKit.h>
#import "AbstractLuaTableCompatible.h"
#import "IService.h"
#import "LuaFunction.h"
#import "ViewWidget.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface DeviceService : AbstractLuaTableCompatible <IService, MFMessageComposeViewControllerDelegate> {
    lua_State *L;
    NSMutableDictionary *soundMap;
}

@property (nonatomic, strong) CTTelephonyNetworkInfo *networkInfo;

+ (NSString *) getMacAddress;

+ (NSString *) getUUID;

- (NSNumber *) getWlan;

- (NSString *) getUserAgent;

- (void) setUserAgent: (NSString *) ua;

- (NSNumber *) getBatteryLevel;

- (BOOL) call: (NSString *) num;

- (BOOL) sms: (id) obj;

- (NSString *) getNetworkType;

@end
