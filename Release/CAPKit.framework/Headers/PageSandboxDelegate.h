@class PageSandbox;

@protocol PageSandboxDelegate <NSObject>

- (void) onFronted: (PageSandbox *) sandbox;
- (void) onIdle: (PageSandbox *) sandbox;

@end

