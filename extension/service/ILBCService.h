//
//  ILBCService.h
//  EOSFramework
//
//  Created by Sam Chang on 15/8/20.
//  Copyright (c) 2015年 HP. All rights reserved.
//

#import <CAPKit/CAPKit.h>
#import "AQRecorder.h"
#import <AudioToolbox/AudioSession.h>
#import <AVFoundation/AVFoundation.h>

@interface ILBCService : NSObject <IService, LuaTableCompatible, AVAudioPlayerDelegate> {
    lua_State *L;
    AQRecorder *recorder;

    AVAudioPlayer *player;

    NSString *lastRecordPath;

    LuaFunction *onplayercomplete;

    NSString *previewCategory;
}

@end
