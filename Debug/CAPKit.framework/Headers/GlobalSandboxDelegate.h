@class AppSandbox;
@class PageSandbox;
@protocol PagePanel;

@protocol GlobalSandboxDelegate <NSObject>

- (void) onAppSandboxCreated: (AppSandbox *) sandbox;

- (void) onPageSandboxCreated: (PageSandbox *) sandbox;

- (void) onPagePanelCreated: (id<PagePanel>) pagepanel;

@end
