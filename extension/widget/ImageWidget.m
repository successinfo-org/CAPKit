//
//  ImageWidget.m
//  EOSClient2
//
//  Created by Song on 10/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageWidget.h"
#import "ImageM.h"
#import "ASIHTTPRequest.h"
#import "NSData+Base64.h"
#import "AnimatedGIFImageSerialization.h"

@interface ImageWidget ()

@property (nonatomic, retain) ASIHTTPRequest *req;

@end

@implementation ImageWidget

+(void)load{
    [WidgetMap bind: @"image" withModelClassName: @"ImageM" withWidgetClassName: @"ImageWidget"];
}

-(id)initWithModel:(UIWidgetM *)m withPageSandbox: (PageSandbox *) sandbox{
    self = [super initWithModel: m withPageSandbox: sandbox];
    if (self) {
    }
    return self;
}

- (void) onCreateView{
    view = [[UIView alloc] initWithFrame: [self getActualCurrentRect]];
    view.autoresizingMask = UIViewAutoresizingNone;
    view.clipsToBounds = YES;
    if (self.model.hasTouchDisabled) {
        view.userInteractionEnabled = !self.model.touchDisabled;
    }else{
        view.userInteractionEnabled = NO;
    }
    imageView = [[UIImageView alloc] initWithFrame: view.bounds];
//    imageView.contentMode = UIViewContentModeCenter;
    [view addSubview: imageView];
    
    if (self.model.src != nil) {
        [self applySrc];
    }
}

- (void) updateImageFrame{
    NSString *scale = self.model.scale;
    CGRect rect = [self innerView].frame;
    scale = [scale stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([scale isEqualToString: @"none"]) {
        [imageView sizeToFit];
    }else if ([scale isEqualToString: @"center"]){
        [imageView sizeToFit];
        CGFloat x = (rect.size.width - imageView.image.size.width) / 2;
        CGFloat y = (rect.size.height - imageView.image.size.height) / 2;
        imageView.frame = CGRectMake(x, y, imageView.image.size.width, imageView.image.size.height);
    }else if ([scale isEqualToString: @"fill"] || [scale hasPrefix: @"clip"]) {
        imageView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    }else if (scale == nil || [scale isEqualToString: @"fitWidth"]) {
        float scale = imageView.image.size.width / rect.size.width;
        float height = imageView.image.size.height / scale;
        imageView.frame = CGRectMake(0, 0, rect.size.width, height);
    }else if([scale isEqualToString: @"fitHeight"]){
        float scale = imageView.image.size.height / rect.size.height;
        float width = imageView.image.size.width / scale;
        imageView.frame = CGRectMake(0, 0, width, rect.size.height);
    }
}

- (BOOL) reloadImage: (UIImage *) image{
    BOOL hasSet = NO;
    if ([((ImageM *)self.model).scale hasPrefix: @"clip"]) {
        NSString *clip = [((ImageM *)self.model).scale substringFromIndex: [@"clip" length]];
        clip = [clip stringByReplacingOccurrencesOfString: @"(" withString: @""];
        clip = [clip stringByReplacingOccurrencesOfString: @")" withString: @""];
        NSArray *items = [clip componentsSeparatedByString: @","];
        
        NSMutableArray *trimedItems = [[NSMutableArray alloc] initWithCapacity: [items count]];
        for (NSString *item in items) {
            [trimedItems addObject: [item stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        }
        int top = 0,right = 0,bottom = 0,left = 0;
        if ([trimedItems count] >= 2) {
            top = [[trimedItems objectAtIndex: 0] intValue];
            right = [[trimedItems objectAtIndex: 1] intValue];
            if ([trimedItems count] >= 4) {
                bottom = [[trimedItems objectAtIndex: 2] intValue];
                left = [[trimedItems objectAtIndex: 3] intValue];
            }else{
                bottom = top;
                left = right;
            }
            
            UIImage *clippedImage = nil;
            if ([image respondsToSelector: @selector(resizableImageWithCapInsets:resizingMode:)]) {
                clippedImage = [image resizableImageWithCapInsets: UIEdgeInsetsMake(top, left, bottom, right)
                                                     resizingMode: UIImageResizingModeStretch];
            } else{
                clippedImage = [image stretchableImageWithLeftCapWidth: left topCapHeight: top];
            }
            imageView.image = clippedImage;
            hasSet = YES;
        }
    }
    if (!hasSet){
        if (image != nil) {
            imageView.image = image;
            [self updateImageFrame];
        }
    }
    
    return YES;
}

- (void)processImageData:(id)imagePath {
    imageView.image = nil;
    if ([imagePath isKindOfClass: [NSString class]]) {
        UIImage *image = [[ImageCache sharedInstance] get: imagePath];
        [self reloadImage: image];
    }else if ([imagePath isKindOfClass: [UIImage class]]){
        [self reloadImage: (UIImage *)imagePath];
    }
    
    [OSUtils executeDirect: self.model.onload withSandbox: self.pageSandbox withObject: self];
}

- (void) applySrc{
    if ([self.model.src isKindOfClass: [UIImage class]]) {
        [self reloadImage: self.model.src];
    } else if ([self.model.src isKindOfClass: [LuaImage class]]) {
        LuaImage *luaImage = (LuaImage *) self.model.src;

        __weak id weakSelf = self;
        [luaImage getImage:^(UIImage *img) {
            [weakSelf reloadImage: img];
        }];
    } else if ([self.model.src isKindOfClass: [NSString class]]){
        if ([self.model.src hasPrefix: @"data:"] && ![self.model.src hasPrefix: @"data://"]) {
            UIImage *image = [OSUtils imageFromDataString: self.model.src];
            [self processImageData: image];
        }else{
            NSURL *imageURL = [self.pageSandbox resolveFile: self.model.src];
            if ([imageURL isFileURL]) {
                [self processImageData:[imageURL path]];
            }else if([imageURL isKindOfClass: [NSURL class]]){
                NSString *suffix = [imageURL pathExtension];
                NSString *cachePath = [self.pageSandbox getDataFile: @"imagecache"];
                NSString *cacheHashName = [cachePath stringByAppendingPathComponent: [OSUtils getHash: [imageURL absoluteString] withContainer: [self.pageSandbox getGlobalSandbox].container]];
                NSString *cacheName = cacheHashName;
                if (suffix) {
                    cacheName = [cacheHashName stringByAppendingPathExtension:suffix];
                }
                //NSLog(@"#cacheName--->%@",cacheName);
                NSFileManager *fm = [NSFileManager defaultManager];
                [fm createDirectoryAtPath: cachePath withIntermediateDirectories: YES attributes: nil error: nil];
                if (![fm fileExistsAtPath: cacheName]) {
                    if ([((ImageM *)self.model).placeholder isKindOfClass: [NSString class]]) {
                        NSURL *placeHolderURL = [self.pageSandbox resolveFile: ((ImageM *)self.model).placeholder];
                        if ([placeHolderURL isFileURL]) {
                            [OSUtils runBlockOnMain:^{
                                [self processImageData:[placeHolderURL path]];
                            }];
                        }
                    }

                    NSObject *taskSrc = self.model.src;
                    if (_req && [_req isExecuting]) {
                        [_req clearDelegatesAndCancel];
                    }

                    NSLog(@"%@", imageURL);

                    _req = [ASIHTTPRequest requestWithURL: imageURL];
                    [_req setDownloadDestinationPath: cacheName];

                    __weak ImageWidget *weakSelf = self;

                    [_req setCompletionBlock:^{
                        if (![weakSelf.model.src isEqual: taskSrc]) {
                            return;
                        }

                        if (weakSelf.req.responseStatusCode < 300 && weakSelf.req.responseStatusCode >= 200 && weakSelf.req.error == nil) {
                            [OSUtils runBlockOnMain:^{
                                [weakSelf processImageData: cacheName];
                            }];
                        }else{
                            NSDictionary *resp = @{@"responseCode": [NSNumber numberWithInt: weakSelf.req.responseStatusCode]};
                            [OSUtils executeDirect: weakSelf.model.onerror withSandbox: weakSelf.pageSandbox withObject: weakSelf withObject: resp];
                            NSLog(@"image download failed! - %@ - %@", imageURL, weakSelf.req.error);
                            [fm removeItemAtPath: cacheName error: nil];
                        }
                    }];

                    [_req setFailedBlock:^{
                        NSDictionary *resp = @{@"responseCode": [NSNumber numberWithInt: weakSelf.req.responseStatusCode], @"error": weakSelf.req.error};
                        [OSUtils executeDirect: weakSelf.model.onerror withSandbox: weakSelf.pageSandbox withObject: weakSelf withObject: resp];
                        NSLog(@"image download failed! - %@ - %@", imageURL, weakSelf.req.error);
                        [fm removeItemAtPath: cacheName error: nil];
                    }];

                    [_req startAsynchronous];
                }else{
                    [self processImageData:cacheName];
                }
            }
        }
    }
}

- (void) onReload{
    BOOL needRefreshSrc = NO;
    APPLY_DIRTY_MODEL_PROP_DO(src, {
        needRefreshSrc = YES;
    });
    APPLY_DIRTY_MODEL_PROP_DO(scale, {
        needRefreshSrc = YES;
    });

    if (imageView.image && [imageView.image isKindOfClass: NSClassFromString(@"_UIAnimatedImage")]) {
        UIImage *image = imageView.image;
        imageView.image = nil;
        imageView.image = image;
    }

    if (needRefreshSrc) {
        [self applySrc];
    }
}

- (void)setData:(NSObject *) data{
    if ([data isKindOfClass: [NSString class]]) {
        self.model.src = (NSString *) data;
    } else if ([data isKindOfClass: [NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *) data;
        if ([dic valueForKey: @"src"]) {
            self.model.src = [dic valueForKey: @"src"];
        }
    }
}

-(UIView *)innerView{
    return view;
}

-(void)setViewFrame:(CGRect)rect{
    [super setViewFrame: rect];
    
    if (imageView.image == nil) {
        return;
    }else{
        [self updateImageFrame];
    }
    
}

- (void) setImage: (UIImage *) img{
    self.model.src = img;
    [self reload];
}

- (UIImage *) getImage{
    return imageView.image;
}

#pragma mark Lua API Begin
- (void) _LUA_setImage: (id) img{
    self.model.src = img;
    [self reload];
}

- (LuaImage *) _LUA_getImage{
    return [[LuaImage alloc] initWithImage: imageView.image];
}

- (void) setSrc: (NSObject *) src{
    self.model.src = src;
    
    [self reload];
}

- (NSObject *)getSrc{
    return self.model.src;
}

- (void) setPlaceHolder: (NSString *) src{
    self.model.placeholder = src;
    
    [self reload];
}

- (NSString *) getPlaceholder{
    return self.model.placeholder;
}

- (void) setScale: (NSString *) scale{
    self.model.scale = scale;
    
    [self reload];
}

- (NSString *) getScale{
    return self.model.scale;
}

#pragma mark Lua API End

@end
