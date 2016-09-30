@class AppSandbox;

@interface GlobalSandbox : DefaultSandbox <GlobalSandboxInterface, LuaObjectProxyCompatible>{
    LuaObjectProxy *proxy;

    NSMutableDictionary *pkgApps;
    NSMutableArray *pkgStrings;
    NSFileHandle *pkgFileHandle;
}

@property (nonatomic, weak, readonly) CAPContainer *container;

@property (nonatomic, strong) NSMutableDictionary *singletonServices;

@property (nonatomic, weak) id<GlobalSandboxDelegate> delegate;

- (id)initWithContainer: (CAPContainer *) cont;

- (NSString *) getSecureCode;

- (NSString *) getSessionId;

- (void) applyDefaults: (NSUserDefaults *) uds;

- (void) makeSafeMode;

- (void) preparePackage;

- (NSData *) resolveData: (NSString *) appId withPath: (NSString *) path;

@end
