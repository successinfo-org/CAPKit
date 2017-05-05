#import <AssetsLibrary/AssetsLibrary.h>

#define KIND_THUMBNAIL      @"KIND_THUMBNAIL"
#define KIND_FULLSCREEN     @"KIND_FULLSCREEN"
#define KIND_FULL           @"KIND_FULL"

@interface LuaImage : AbstractLuaTableCompatible

@property (nonatomic, readonly) ALAsset *asset;
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) NSString *path;
@property (nonatomic, readonly) NSString *kind;

- (instancetype) initWithALAsset: (ALAsset *) asset;
- (instancetype) initWithImage: (UIImage *) img;
- (instancetype) initWithPath: (NSString *) path;
- (instancetype) initWithALAsset: (ALAsset *) asset withKind: (NSString *) kd;

- (UIImage *) getImage;

- (LuaImage *) getThumbnail;
- (LuaImage *) getFullScreenImage;
- (LuaImage *) getFullResolutionImage;

- (NSString *) getBase64String;

- (NSData *) getPNGData;
- (NSData *) getJPEGData: (float) compress;

- (LuaData *) _LUA_getPNGData;
- (LuaData *) _LUA_getJPEGData: (float) compress;

- (PackedArray *) getSize;
- (LuaImage *) scale: (int) width : (int) height;
- (LuaImage *) crop: (int) x : (int) y : (int) width : (int) height;
- (LuaImage *) mask: (LuaImage *) mask;

- (BOOL) save: (NSString *) path : (NSString *) format;

@end
