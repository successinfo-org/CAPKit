#import <MessageUI/MessageUI.h>
#import <Reachability.h>

@interface CAPAppDelegate : UIResponder <UIApplicationDelegate, GlobalSandboxDelegate, MFMessageComposeViewControllerDelegate>{
    CAPContainer *container;
//    NSTimeInterval lastChangeViewStack;
    Reachability *reachability;
}

#define PROTECT_VIEW_STACK(blk)    \
if ([NSDate timeIntervalSinceReferenceDate] - lastChangeViewStack < 0.5) {    \
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((0.5 - ([NSDate timeIntervalSinceReferenceDate] - lastChangeViewStack)) * NSEC_PER_SEC)), dispatch_get_main_queue(), blk); \
    return YES;  \
} else {    \
    lastChangeViewStack = [NSDate timeIntervalSinceReferenceDate];  \
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong, readonly) UIViewController *rootViewController;

@end
