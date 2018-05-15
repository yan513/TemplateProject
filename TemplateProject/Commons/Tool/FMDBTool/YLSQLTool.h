//
//  YLSQLTool.h
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLSQLTool : NSObject

#pragma mark - create table sql
+ (NSString *)createTableSqlWithClass:(Class)obj andTableName:(NSString *)tableName andPrimaryKey:(NSString *)key;

#pragma mark - insert sql
+ (NSString *)getInsertDataSql:(id)data inTableName:(NSString *)tableName;
+ (NSArray *)getInsertDataArraySql:(NSArray *)array inTableName:(NSString *)tableName;

#pragma mark - delete sql
+ (NSString *)getDeleteDataSqlInTable:(NSString *)tableName andCondition:(NSDictionary *)condition;

#pragma mark - update sql
+ (NSString *)getUpdateDataSql:(id)data inTableName:(NSString *)tableName conditions:(NSDictionary *)conditions;;

#pragma mark - select sql
+ (NSString *)getSelectTableSqlWithTable:(NSString *)tableName conditions:(NSDictionary *)conditions orderBy:(NSArray *)orderBy limit:(NSRange)range;

#pragma mark - alter sql
+ (NSString *)getAlterSqlWithTable:(NSString *)tableName column:(NSString *)columnName type:(NSString *)type;
#pragma mark - delete table sql
+ (NSString *)getDeleteTableSqlWithTable:(NSString *)tableName;
#pragma mark - clear table sql
+ (NSString *)getClearTableSqlWithTable:(NSString *)tableName;
@end
