//
//  TSSQLiteTool.h
//  RoutineInspection
//
//  Created by Aries on 14-8-26.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#import "FMDB.h"

@interface TSSQLiteTool : FMDatabase

+ (TSSQLiteTool *)sharedSQLite;
- (void)openSqlite;
- (void)createSQLiteData;
@end
