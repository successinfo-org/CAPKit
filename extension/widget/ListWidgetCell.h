//
//  ListWidgetCell.h
//  EOSFramework
//
//  Created by Chang Sam on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CAPKit/CAPKit.h>
#import "BMXSwipableCell.h"

@class ListWidget;
@interface ListWidgetCell : BMXSwipableCell

@property (nonatomic, strong) AbstractUIWidget *widget;
@property (nonatomic, strong) AbstractUIWidget *action;
@property (nonatomic, strong) NSMutableDictionary *dp;
@property (nonatomic, weak) ListWidget *listWidget;

@property (nonatomic, strong) NSIndexPath *indexPath;


@end
