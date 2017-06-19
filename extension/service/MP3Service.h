//
//  MP3Service.h
//  EOSFramework
//
//  Created by Sam Chang on 9/7/15.
//  Copyright (c) 2015 HP. All rights reserved.
//

#import <CAPKit/CAPKit.h>
#import "AQRecorder.h"
#import <AudioToolbox/AudioSession.h>
#import <AVFoundation/AVFoundation.h>

@interface MP3Service : NSObject <IService, LuaTableCompatible, AVAudioPlayerDelegate, AVAudioRecorderDelegate> {
    lua_State *L;

    AQRecorder *recorder;

    AVAudioPlayer *player;

    NSString *lastRecordPath;

    Float64 samplerate;

    LuaFunction *onplayercomplete;

    NSString *previewCategory;
}

@end
