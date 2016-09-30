@protocol IService <NSObject>

- (BOOL) singleton;

@optional
- (void) onLoad;

@end
