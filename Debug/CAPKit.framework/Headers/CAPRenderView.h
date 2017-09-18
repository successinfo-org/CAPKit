#import <CAPKit/CAPPanelView.h>

@interface CAPRenderView : UIView {
    NSMutableArray *stack;
    UIView *contentView;
}

@property (nonatomic, assign) CGRect rect;

- (void) reloadSize;

- (void) pushView: (CAPPanelView<PagePanel> *) view animated: (BOOL) animated;

- (void) popViewAnimated: (BOOL) animated;

- (void) popToView: (CAPPanelView<PagePanel> *) view animated: (BOOL) animated;

- (NSArray *) listAllPanelViews;

- (void) setPanelViews: (NSArray *) list animated: (BOOL) animated;

- (CAPPanelView *) topPanelView;

@end
