//
//  YLFMDBTool.m
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import "YLFMDBTool.h"
#import "YLFileTool.h"
#import "YLSQLTool.h"
#import "FMDB.h"

@interface YLFMDBTool()
{
    FMDatabaseQueue *dbQueue;
}
@property (strong, nonatomic) NSString *dbPath;
@end

static YLFMDBTool *instance = nil;

@implementation YLFMDBTool

-(id) init
{
    self = [super init];
    if(self){
        NSString *path = [[YLFileTool getDocPath] stringByAppendingPathComponent:@"database"];
        [YLFileTool createDirectory:path];
        path = [path stringByAppendingPathComponent:@"default.sqlite"];
        dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    }
    return self;
}

+(YLFMDBTool*) shareDatabase
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

#pragma mark - create table

- (void)createTableWithClass:(Class)obj andTableName:(NSString *)tableName andPrimaryKey:(NSString *)key{
    NSString *sql = [YLSQLTool createTableSqlWithClass:obj andTableName:tableName andPrimaryKey:key];
    [self createTableWithSql:sql andTableName:tableName];
}
- (void)createTableWithSql:(NSString *)sql andTableName:(NSString *)tableName {
    [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            [db executeUpdate:sql];
        }
    }];
}
#pragma mark - clear
// 删除表
- (void)deleteTable:(NSString *)tableName {
    NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE %@", tableName];
    [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            [db executeUpdate:sqlstr];
        }
    }];
}
// 清空表
- (void)deleteAllDataFromTable:(NSString *)tableName {
    NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
    [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            [db executeUpdate:sqlstr];
        }
    }];
}
#pragma mark - insert
- (void)insertData:(id)obj inTableName:(NSString *)tableName{
    NSString *sql = [YLSQLTool getInsertDataSql:obj inTableName:tableName];
    [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            [db executeUpdate:sql];
        }
    }];
}
- (void)insertDataArray:(NSArray *)array inTableName:(NSString *)tableName{
    NSArray *sqlArray = [YLSQLTool getInsertDataArraySql:array inTableName:tableName];
    for (NSString *sql in sqlArray) {
        [dbQueue inDatabase:^(FMDatabase *db) {
            BOOL result = [db executeUpdate:sql];
            if (result == NO) {
                NSLog(@"数据插入失败");
            }
        }];
    }
}
#pragma mark - delete
- (void)deleteDataWithTableName:(NSString *)tableName conditions:(NSDictionary *)conditions {
    NSString *sql = [YLSQLTool getDeleteDataSqlInTable:tableName andCondition:conditions];
    [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            [db executeUpdate:sql];
        }
    }];
}
#pragma mark - inquire
- (NSArray *)selectDataWithTableName:(NSString *)tableName conditions:(NSDictionary *)conditions {
    return [self selectDataWithTableName:tableName conditions:conditions orderBy:nil];
}
- (NSArray *)selectDataWithTableName:(NSString *)tableName conditions:(NSDictionary *)conditions orderBy:(NSArray *)orderBy {
    return [self selectDataWithTableName:tableName conditions:conditions orderBy:orderBy limit:NSMakeRange(0, 0)];
}
- (NSArray *)selectDataWithTableName:(NSString *)tableName conditions:(NSDictionary *)conditions orderBy:(NSArray *)orderBy limit:(NSRange)range {
    NSString *sql = [YLSQLTool getSelectTableSqlWithTable:tableName conditions:conditions orderBy:orderBy limit:range];
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next])
        {
            [array addObject:[rs resultDictionary]];
        }
        [rs close];
        
    }];
    return array;
}

#pragma mark - update
- (void)updateData:(id)obj inTableName:(NSString *)tableName conditions:(NSDictionary *)conditions{
    NSString *sql = [YLSQLTool getUpdateDataSql:obj inTableName:tableName conditions:conditions];
    [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            [db executeUpdate:sql];
        }
    }];
}

#pragma mark - search
- (NSArray *)searchDataWithTableName:(NSString *)tableName conditionSql:(NSString *)conditionSql {
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:conditionSql];
        while ([rs next])
        {
            [array addObject:[rs resultDictionary]];
        }
        [rs close];
        
    }];
    return array;
}

@end
