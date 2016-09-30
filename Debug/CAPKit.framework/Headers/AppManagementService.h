#define APPID_FRAMEWORK @"framework"

@interface AppManagementService : AbstractLuaTableCompatible <IService>{
    NSMutableDictionary *appPathsMap;
    NSMutableDictionary *manifestsMap;
    
    NSMutableDictionary *appSandboxMap;
}

@property (nonatomic, weak) GlobalSandbox *globalSandbox;

- (BOOL) _COROUTINE_installFile: (NSString *) filePath : (NSString *) appId;
- (BOOL) _COROUTINE_installURL: (NSString *) urlString : (NSString *) appId;

- (void) scan;
- (BOOL) remove: (NSString *) appId;
- (BOOL) remove: (NSString *) appId :(BOOL) removeAll;

- (NSArray *) list: (NSString *) category;

- (NSString *) pathForApp: (NSString *) appId;

- (AppSandbox *) getAppSandbox: (NSString *) appId;

- (PageSandbox *) getPageSandbox: (NSString *) appId :(NSString *) pageId;
- (PageSandbox *) getPageSandbox: (NSString *) appId;

@end
