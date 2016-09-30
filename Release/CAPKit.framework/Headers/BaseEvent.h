
@interface BaseEvent : AbstractLuaTableCompatible

@property (nonatomic, readonly) BOOL broadcast;
@property (nonatomic, readonly) BOOL propagationStopped;
@property (nonatomic, readonly) EventKey key;

- (void) stopPropagation;

+ (id) event;


@end
