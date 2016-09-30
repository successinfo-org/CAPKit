@class PageSandbox;
@class AppSandbox;

@protocol GlobalSandboxInterface <DefaultSandboxInterface>

- (void) scanApps DEPRECATED_ATTRIBUTE;

- (EOSList *) listApps: (NSString *) category DEPRECATED_ATTRIBUTE;

- (AppSandbox *) getAppSandbox: (NSString *) appId DEPRECATED_ATTRIBUTE;
- (AppSandbox *) getAppSandboxById: (NSString *) appId DEPRECATED_ATTRIBUTE;

- (PageSandbox *) getPageSandbox: (NSString *) appId :(NSString *) pageId DEPRECATED_ATTRIBUTE;
- (PageSandbox *) getPageSandbox: (NSString *) appId DEPRECATED_ATTRIBUTE;

@end
