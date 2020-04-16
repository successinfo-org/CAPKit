//
//  BSWebViewUserAgent.h
//  EOSFramework
//
//  Created by Sam on 5/29/12.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <CAPKit/CAPKit.h>
#import <WebKit/WebKit.h>

@interface BSWebViewUserAgent : NSObject {
	NSString *userAgent;
	WKWebView *webView;
}
@property (nonatomic, strong) NSString *userAgent;
-(NSString*)userAgentString;
@end
