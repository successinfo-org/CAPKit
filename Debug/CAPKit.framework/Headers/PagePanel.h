//
//  PagePanel.h
//  EOSClient2
//
//  Created by Chang Sam on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

@class PageSandbox;
@class PageM;
@class ManifestM;

@protocol PagePanel

/**invoked when this `Panel` is fully created.*/
- (void) onCreated;

/**invoked when this `Panel` is going to destory*/
- (void) onDestroy;

/**invoked when this `Panel` is move to front of this screen*/
- (void) onFronted;

/**invoked when this `Panel` is move to backend of this screen*/
- (void) onBackend;

- (PageM *) getModel;

- (void) setContext: (AppContext *) context;

- (PageSandbox *) getSandbox;

- (void) reloadSize;

-(id)initWithURL: (NSURL *) url withSandbox: (PageSandbox *) sandbox;

@end
