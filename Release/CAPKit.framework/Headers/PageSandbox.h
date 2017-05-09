@interface PageSandbox : DefaultSandbox <PageSandboxInterface>{
    AppSandbox *appSandbox;
    NSMutableArray *editingFocusStack;
    
    @public
    NSInteger widgetCount;
}

@property (nonatomic, weak) CAPPanelView<PagePanel> *panelView;

@property (nonatomic, readonly) int envRef;
@property (nonatomic, readonly) LuaState *state;

@property (nonatomic, strong) PageM *model;
@property (nonatomic, readonly) id<PageLifecycle> lifecycle;
@property (nonatomic, readonly) NSString *pageId;

@property (nonatomic, readonly) NSMapTable *weakFunctions;

- (id) initWithAppSandbox: (AppSandbox *) sandbox withPageId: (NSString *) pid;

- (void) runLuaBuffer: (NSString *) buffer;

- (NSURL *) resolveFile: (NSString *) path;

- (NSString *) getDataFile: (NSString *) path;

- (AppSandbox *) getAppSandbox;

- (GlobalSandbox *) getGlobalSandbox;

- (NSInteger) getWidgetCount;

- (void) loadScripts: (PageM *) pagem;

- (void) pushEditingFocus: (AbstractUIWidget *) view;
- (void) removeEditingFocus: (AbstractUIWidget *) view;
- (AbstractUIWidget *) lastEditingFocus;

@end
