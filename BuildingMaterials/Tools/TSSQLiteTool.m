//
//  TSSQLiteTool.m
//  RoutineInspection
//
//  Created by Aries on 14-8-26.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#import "TSSQLiteTool.h"

@implementation TSSQLiteTool

static TSSQLiteTool *sharedInstance = nil;

+ (TSSQLiteTool *)sharedSQLite
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] initWithPath:[self databasePathWithFileName:@"ProInspection.db"]];
    });
    return sharedInstance;
}

- (void)openSqlite
{
    if (![[TSSQLiteTool sharedSQLite] open]) {
        NSLog(@"数据库打开失败");
    }
}

#pragma mark - 创建数据库
- (void)createSQLiteData
{
    BOOL createTable = NO;
    
    [[TSSQLiteTool sharedSQLite] openSqlite];
    //用户表
    if(![[TSSQLiteTool sharedSQLite] tableExists:@"tb_userInfo"]){
        createTable = [[TSSQLiteTool sharedSQLite] executeUpdate:@"CREATE TABLE  if not exists tb_userInfo ( accessSecret VARCHAR, accessToken VARCHAR, cellphone VARCHAR, companyName VARCHAR, displayName VARCHAR, email VARCHAR, groupList VARCHAR, subCompanyName VARCHAR, userName VARCHAR, companyId INTEGER(20), isValid INTEGER(20), projectId INTEGER(20), sex INTEGER(20), subCompanyId INTEGER(20), userId INTEGER(20), departmentId INTEGER(20), departmentTypeId INTEGER(20) )"];
        if (!createTable) {
            NSLog(@"tb_userinfo创建失败");
        }else{
            NSLog(@"tb_userinfo创建成功");
        }
    }
    
//    任务表
    if (![[TSSQLiteTool sharedSQLite] tableExists:@"tb_taskList"]) {
        createTable = [[TSSQLiteTool sharedSQLite] executeUpdate:@"CREATE TABLE  if not exists tb_taskList ( routineInspectionTaskId INTEGER(20), routineInspectionTaskName VARCHAR, routineInspectionTaskDesc VARCHAR, routineInspectionTaskStartDate VARCHAR, routineInspectionTaskEndDate VARCHAR, routineInspectionTaskFinishDate VARCHAR, routineInspectionUserId INTEGER(20), routineInspectionUserName VARCHAR, routineInspectionPlanId INTEGER(20), times INTEGER(20), departmentTypeId INTEGER(20), departmentId INTEGER(20), projectId INTEGER(20), subCompanyId INTEGER(20), companyId INTEGER(20), type INTEGER(20), isDelete INTEGER(20), taskState INTEGER(20), finished INTEGER(20) )"];
    }
    if (!createTable) {
        NSLog(@"tb_taskList创建失败");
    }else{
        NSLog(@"tb_taskList创建成功");
    }

//    检查项表
    if (![[TSSQLiteTool sharedSQLite] tableExists:@"tb_recordList"]) {
        createTable = [[TSSQLiteTool sharedSQLite] executeUpdate:@"CREATE TABLE  if not exists tb_recordList ( routineInspectionRecordId INTEGER(20), checkObjectId INTEGER(20), checkObjectType INTEGER(20), companyId INTEGER(20), departmentId INTEGER(20), fatherTypeId INTEGER(20), isDelete INTEGER(20), routineInspectionItemId INTEGER(20), routineInspectionResult VARCHAR,routineInspectionTaskId INTEGER(20), routineInspectionUserId INTEGER(20), subCompanyId INTEGER(20), type INTEGER(20),recordPicList VARCHAR, recordNameList VARCHAR, routineDevice VARCHAR, routineDeviceRoom VARCHAR, routineInspectionItemDesc VARCHAR, routineInspectionItemName VARCHAR, routineInspectionRecordDesc VARCHAR, routineInspectionUserName VARCHAR, routineLine VARCHAR, routinePoint VARCHAR, finished INTEGER(20), isEdit INTEGER(20), routinePointSignInDate VARCHAR DEFAULT 0, isUpload INTEGER(20) DEFAULT 0 )"];
    }
    if (!createTable) {
        NSLog(@"tb_recordList创建失败");
    }else{
        NSLog(@"tb_recordList创建成功");
    }

//   检查类型
    if (![[TSSQLiteTool sharedSQLite] tableExists:@"tb_typeList"]) {
        createTable = [[TSSQLiteTool sharedSQLite] executeUpdate:@"CREATE TABLE  if not exists tb_typeList ( companyId INTEGER(20), departmentId INTEGER(20), departmentTypeId INTEGER(20), isDelete INTEGER(20), routineInspectionPlanId INTEGER(20), routineInspectionTypeDesc VARCHAR, routineInspectionTypeId INTEGER(20), routineInspectionTypeName VARCHAR, subCompanyId INTEGER(20) )"];
    }
    if (!createTable) {
        NSLog(@"tb_typeList创建失败");
    }else{
        NSLog(@"tb_typeList创建成功");
    }
//巡检设备房     deviceRoomList

    if (![[TSSQLiteTool sharedSQLite] tableExists:@"tb_deviceRoomList"]) {
        createTable = [[TSSQLiteTool sharedSQLite] executeUpdate:@"CREATE TABLE if not exists tb_deviceRoomList ( routineDeviceRoomId INTEGER(20), routineDeviceRoomName VARCHAR, routineDeviceRoomAddress VARCHAR, departmentId INTEGER(20), companyId INTEGER(20), subCompanyId INTEGER(20), projectId INTEGER(20), routineInspectionPlanId INTEGER(20), isDelete INTEGER(20) )"];
    }
    if (!createTable) {
        NSLog(@"tb_deviceRoomList创建失败");
    }else{
        NSLog(@"tb_deviceRoomList创建成功");
    }
//    巡检设备表 deviceList
    if (![[TSSQLiteTool sharedSQLite] tableExists:@"tb_deviceList"]) {
        createTable = [[TSSQLiteTool sharedSQLite] executeUpdate:@"CREATE TABLE if not exists tb_deviceList ( routineDeviceId INTEGER(20), routineDeviceName VARCHAR, routineDeviceNumber VARCHAR, routineDeviceModel VARCHAR, routineDeviceVender VARCHAR, productDate VARCHAR, installationSite VARCHAR, status INTEGER(20), routineDeviceTypeId INTEGER(20), departmentId INTEGER(20), companyId INTEGER(20), subCompanyId INTEGER(20), projectId INTEGER(20), routineInspectionPlanId INTEGER(20), isDelete INTEGER(20) )"];
    }
    if (!createTable) {
        NSLog(@"tb_deviceList创建失败");
    }else{
        NSLog(@"tb_deviceList创建成功");
    }

//    工程部维修表  maintainList
    if (![[TSSQLiteTool sharedSQLite] tableExists:@"tb_maintainList"]) {
        createTable = [[TSSQLiteTool sharedSQLite] executeUpdate:@"CREATE TABLE if not exists tb_maintainList ( routineInspectionMaintainId INTEGER(20), routineInspectionResult INTEGER(20), routineInspectionMaintainDesc VARCHAR, routineInspectionUserId INTEGER(20), routineInspectionUserName VARCHAR, checkObjectType INTEGER(20), checkObjectId INTEGER(20), routineInspectionMaintainFinishTime VARCHAR, routineInspectionTaskId INTEGER(20), source INTEGER(20), departmentId INTEGER(20), companyId INTEGER(20), subCompanyId INTEGER(20), isDelete INTEGER(20), routineDeviceRoomAddress VARCHAR, routineDeviceRoomId INTEGER(20), routineDeviceRoomName VARCHAR, installationSite VARCHAR, routineDeviceId INTEGER(20), routineDeviceModel INTEGER(20), routineDeviceName VARCHAR, routineDeviceNumber VARCHAR, routineDeviceTypeId INTEGER(20), routineInspectionDefect VARCHAR, recordPicList VARCHAR, finished INTEGER(20), isEdit INTEGER(20), isUpload INTEGER(20) DEFAULT 0 )"];
    }
    if (!createTable) {
        NSLog(@"tb_maintainList创建失败");
    }else{
        NSLog(@"tb_maintainList创建成功");
    }

//    安保部巡逻表  pointList
    if (![[TSSQLiteTool sharedSQLite] tableExists:@"tb_pointList"]) {
        createTable = [[TSSQLiteTool sharedSQLite] executeUpdate:@"CREATE TABLE if not exists tb_pointList ( routinePointId INTEGER(20), routinePointName  VARCHAR, routinePointDesc  VARCHAR, routinePointType INTEGER(20), departmentId INTEGER(20), companyId INTEGER(20), subCompanyId INTEGER(20), projectId INTEGER(20), routineInspectionPlanId INTEGER(20), isDelete INTEGER(20), x INTEGER(20), y INTEGER(20) )"];
    }
    if (!createTable) {
        NSLog(@"tb_pointList创建失败");
    }else{
        NSLog(@"tb_pointList创建成功");
    }
    
//    维修人员列表和报事类型列表
    if (![[TSSQLiteTool sharedSQLite] tableExists:@"tb_InspectionUserList"]) {
        createTable = [[TSSQLiteTool sharedSQLite] executeUpdate:@"CREATE TABLE if not exists tb_InspectionUserList ( userId INTEGER NOT NULL PRIMARY KEY, userName VARCHAR ,isValid INTEGER(20), departmentTypeId INTEGER(20) )"];
    }
    if (!createTable) {
        NSLog(@"tb_InspectionUserList创建失败");
    }else{
        NSLog(@"tb_InspectionUserList创建成功");
    }
    
//   报事类型列表
    if (![[TSSQLiteTool sharedSQLite] tableExists:@"tb_DefectTypeList"]) {
        createTable = [[TSSQLiteTool sharedSQLite] executeUpdate:@"CREATE TABLE if not exists tb_DefectTypeList ( defectTypeId INTEGER NOT NULL PRIMARY KEY, defectTypeName VARCHAR )"];
    }
//    BOOL isCreate = [[TSSQLiteTool sharedSQLite] executeUpdate:@"CREATE UNIQUE INDEX if not exists tb_DefectTypeList_idx3 ON tb_DefectTypeList(defectTypeId);"];
    if (!createTable) {
        NSLog(@"tb_DefectTypeList创建失败");
    }else{
        NSLog(@"tb_DefectTypeList创建成功");
    }
    
//    报事表
    if (![[TSSQLiteTool sharedSQLite] tableExists:@"tb_DefectList"]) {
        createTable = [[TSSQLiteTool sharedSQLite] executeUpdate:@"CREATE TABLE if not exists tb_DefectList ( id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, routineDefectTypeId INTEGER(20), address VARCHAR, routineInspectionDefectDesc VARCHAR, isUpload INTEGER(20) DEFAULT 0 )"];
    }
    if (!createTable) {
        NSLog(@"tb_DefectList创建失败");
    }else{
        NSLog(@"tb_DefectList创建成功");
    }
    
//    派工单表
    if (![[TSSQLiteTool sharedSQLite] tableExists:@"tb_disptchList"]) {
        createTable = [[TSSQLiteTool sharedSQLite] executeUpdate:@"CREATE TABLE if not exists tb_disptchList ( id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, routineInspectionRecordIds VARCHAR, checkObjectType INTEGER(20), checkObjectId INTEGER(20), routineInspectionTaskName VARCHAR, routineInspectionTaskDesc VARCHAR, routineInspectionUserId INTEGER(20), routineInspectionUserName VARCHAR, isUpload INTEGER(20) DEFAULT 0 )"];
    }
    if (!createTable) {
        NSLog(@"tb_disptchList创建失败");
    }else{
        NSLog(@"tb_disptchList创建成功");
    }

    [[TSSQLiteTool sharedSQLite] close];
}

//返回路径
+ (NSString *)databasePathWithFileName:(NSString *)fileName
{
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath=[path stringByAppendingPathComponent:fileName];
    NSLog(@"path:%@",path);
    return dbPath;
}

@end
