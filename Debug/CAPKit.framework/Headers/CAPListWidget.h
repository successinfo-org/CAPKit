//
//  ListWidget.h
//  EOSFramework
//
//  Created by Chang Sam on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CAPKit/CAPKit.h>
#import "IListWidget.h"
#import "CAPListM.h"
#import "EGORefreshTableHeaderView.h"

@interface ListSectionModel : NSObject 

@property (nonatomic, readonly) NSMutableDictionary *header;
@property (nonatomic, readonly) NSMutableDictionary *footer;
@property (nonatomic, readonly) NSMutableArray *items;
@property (nonatomic, readonly) NSString *section;
@property (nonatomic, assign) int order;
@property (nonatomic, strong) NSString *indexTitle;

-(id)initWithSection: (NSString *) s;

@end

@protocol ListWidgetDelegate <NSObject>

@optional
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end

@interface CAPListWidget : CAPAbstractUIWidget <UITableViewDataSource, UITableViewDelegate, IListWidget, EGORefreshTableHeaderDelegate>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, readonly) CAPListM *model;
@property (nonatomic, readonly) CAPListM *stableModel;
#pragma clang diagnostic pop

@property (nonatomic, strong) NSMutableArray *sectionList;
@property (nonatomic, strong) NSMutableArray *sectionIndexTitles;
@property (nonatomic, strong) NSMutableDictionary *sectionHeaderWidgetMap;
@property (nonatomic, strong) NSMutableDictionary *sectionFooterWidgetMap;

@property (nonatomic, strong) NSMutableDictionary *heightCache;

@property (nonatomic, strong) NSMutableArray *pendingReloadCellIndexPaths;
@property (nonatomic) BOOL reloadPending;

@property (nonatomic) BOOL dragDowning;

@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) EGORefreshTableHeaderView *refreshTableView;

@property (nonatomic, weak) id<ListWidgetDelegate> delegate;

- (void) setDataProvider: (id) data;

- (void) reloadCellAtIndexPath: (NSIndexPath *) path;

@end
