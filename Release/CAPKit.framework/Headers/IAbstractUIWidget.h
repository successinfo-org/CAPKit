@class LuaImage;

@protocol IAbstractUIWidget <NSObject>

- (void) _LUA_setAlpha: (NSNumber *) value;

- (float) getAlpha;

- (void) reload;

- (void) reset;

- (void) mark;

- (NSDictionary *) getModel;

- (NSString *) getXml;

- (void) suspendLayout;

- (void) resumeLayout;

- (LuaImage *) _COROUTINE_getSnapshot;

- (LuaImage *) _COROUTINE_getContentSnapshot;

- (PackedArray *) getRect;

@end
