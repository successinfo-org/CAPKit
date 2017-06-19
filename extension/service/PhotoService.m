//
//  PhotoService.m
//  EOSFramework
//
//  Created by Sam Chang on 5/12/14.
//  Copyright (c) 2014 HP. All rights reserved.
//

#import "PhotoService.h"

@implementation PhotoService

+(void)load{
    [[ESRegistry getInstance] registerService: @"PhotoService" withName: @"photo"];
}

-(BOOL)singleton{
    return YES;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return self;
}

- (void) load: (LuaFunction *) func{
    if (![func isKindOfClass: [LuaFunction class]]) {
        return;
    }
    
    NSMutableArray *groups = [NSMutableArray array];
    [_assetsLibrary enumerateGroupsWithTypes: ALAssetsGroupAll
                                  usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                      if (group) {
                                          [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                                          NSString *name = [group valueForProperty: ALAssetsGroupPropertyName];
                                          NSNumber *type = [group valueForProperty: ALAssetsGroupPropertyType];
                                          
                                          NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [group numberOfAssets]];
                                          
                                          if ([group numberOfAssets] > 0) {
                                              [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                                  if (result) {
                                                      [photos addObject: [[LuaImage alloc] initWithALAsset: result]];
                                                  }
                                              }];
                                          }
                                          
                                          [groups addObject: @{@"name": name, @"type": type, @"photos": photos}];
                                      } else {
                                          *stop = YES;
                                          [func executeWithoutReturnValue: groups, nil];
                                      }
                                  }
                                failureBlock:^(NSError *error) {
                                    NSLog(@"Error: %@", [error localizedDescription]);
                                    [func executeWithoutReturnValue];
                                }];
}

@end
