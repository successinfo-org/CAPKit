@interface SettingsManager : NSObject {

}

+ (NSUserDefaults *) loadUserSettings:(NSString *)aKey;
@end
