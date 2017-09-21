@class PageSandbox;
@class ViewWidget;

@interface CAPPanelView : UIView <PagePanel, UIGestureRecognizerDelegate> {
    UIInterfaceOrientation lastOrientation;
    CGRect latestReloadFrame;
    
    BOOL tap_to_hide_keyboard;
    BOOL no_swipe;
    BOOL no_tap;

    UIStatusBarStyle statusBarStyle;
    BOOL statusBarHidden;

    UIStatusBarStyle lastStatusBarStyle;
    BOOL lastStatusBarHidden;

    dispatch_once_t created;
}

@property (nonatomic, strong, readonly) NSURL *pageURL;

@property (nonatomic, weak) CAPRenderView *renderView;

@property (nonatomic, strong, readonly, getter=getSandbox) PageSandbox *sandbox;
@property (nonatomic, strong, readonly) PageM *model;
@property (nonatomic, strong, readonly) ViewWidget *root;

@property (nonatomic, readonly) AppContext *context;

- (instancetype)initWithURL: (NSURL *) url withSandbox: (PageSandbox *) sandbox;

- (void) reloadSize;

- (void) willOnFront;

@end
