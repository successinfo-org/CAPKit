//
//  DownloadService.h
//  EOSFramework
//
//  Created by Sam Chang on 1/11/13.
//
//

#import <CAPKit/CAPKit.h>
#import "FMDatabase.h"
#import <CAPKit/IDownloadService.h>

@interface DownloadService : AbstractLuaTableCompatible <IService, LuaObjectProxyCompatible, IDownloadService>{
    FMDatabase *downloaddb;
    NSMutableDictionary *downloadInfos;
}

@end
