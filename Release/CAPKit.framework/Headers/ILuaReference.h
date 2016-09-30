@protocol ILuaReference <NSObject>

- (void) setRef: (int) value;
- (int) getRef;

- (int) getEnvRef;

- (void) __gc;

@end
