@interface LuaRef : NSObject{
    lua_State *L;
}

@property (nonatomic, readonly) int ref;

- (id)initWithRef: (int) value withState: (lua_State *) st;

- (void) unref;

- (BOOL) isValid;

- (lua_State *) getState;

@end
