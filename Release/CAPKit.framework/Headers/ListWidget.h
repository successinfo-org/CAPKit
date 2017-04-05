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
#import "ListM.h"
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

@interface ListWidget : AbstractUIWidget <UITableViewDataSource, UITableViewDelegate, IListWidget, EGORefreshTableHeaderDelegate> {
    NSMutableArray *sectionList;
    NSMutableArray *sectionIndexTitles;
    NSMutableDictionary *sectionHeaderWidgetMap;
    NSMutableDictionary *sectionFooterWidgetMap;

    NSMutableDictionary *heightCache;
    
    NSMutableArray *pendingReloadCellIndexPaths;
    BOOL reloadPending;

    BOOL dragDowning;
}

@property (nonatomic, readonly) ListM *model;
@property (nonatomic, readonly) ListM *stableModel;

@property (nonatomic, readonly) UITableView *listView;
@property (nonatomic, readonly) EGORefreshTableHeaderView *refreshTableView;

@property (nonatomic, weak) id<ListWidgetDelegate> delegate;

- (void) setDataProvider: (id) data;

- (void) reloadCellAtIndexPath: (NSIndexPath *) path;

@end
