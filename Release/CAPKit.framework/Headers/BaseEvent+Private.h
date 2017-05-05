//
//  BaseEvent+Private.h
//  EOSFramework
//
//  Created by Sam on 7/4/12.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#ifndef EOSLib2_BaseEvent_Private_h
#define EOSLib2_BaseEvent_Private_h

#import "BaseEvent.h"

@interface BaseEvent (Private)

- (id) initWithKey: (EventKey) k withBroadcast: (BOOL) isBroadcast;
+ (id) eventWithKey: (EventKey) k withBroadcast: (BOOL) isBroadcast;
- (id) initWithKey: (EventKey) k;

@end

#endif
