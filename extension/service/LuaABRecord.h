//
//  LuaABRecord.h
//  EOSFramework
//
//  Created by Sam Chang on 4/17/14.
//  Copyright (c) 2014 HP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CAPKit/CAPKit.h>
#import "ContactsService.h"

@import AddressBook;

@interface LuaABRecord : AbstractLuaTableCompatible

@property (nonatomic, strong) ContactsService *service;
@property (nonatomic, assign) ABRecordID recordID;

- (instancetype) initWithRecordID: (ABRecordID) recordID
                      withService: (ContactsService *) service;
@end
