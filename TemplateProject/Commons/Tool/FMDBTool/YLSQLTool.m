//
//  YLSQLTool.m
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import "YLSQLTool.h"
#import "MJExtension.h"
@implementation YLSQLTool

#pragma mark - create table sql
+ (NSString *)createTableSqlWithClass:(Class)obj andTableName:(NSString *)tableName andPrimaryKey:(NSString *)key {
    NSDictionary *dic = [self modelToDictionary:obj];
    NSMutableString *sqlString = [NSMutableString string];
    [sqlString appendFormat:@"CREATE TABLE %@ (",tableName];
    for (NSString *key in [dic allKeys]) {
        [sqlString appendFormat:@"%@", [NSString stringWithFormat:@"%@ %@ null,",key,dic[key]]];
    }
    if (key) {
        [sqlString appendFormat:@"primary key (%@))", key];
    }else {
        [sqlString appendFormat:@"primaryKey INTEGER PRIMARY KEY)"];
    }
    return sqlString;
}

#pragma mark - insert sql
+ (NSString *)getInsertDataSql:(id)data inTableName:(NSString *)tableName{
    NSDictionary *parameters = [data mj_keyValues];
    NSMutableString *names = [NSMutableString string];
    NSMutableString *values = [NSMutableString string];
    
    for (NSString *key in parameters.keyEnumerator) {
        [names appendFormat:@"%@, ",key];
        [values appendFormat:@"'%@', ",[self getString:[parameters objectForKey:key]]];
    }
    [names deleteCharactersInRange:NSMakeRange(names.length-2, 2)];
    [values deleteCharactersInRange:NSMakeRange(values.length-2, 2)];
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES (%@)",tableName,names,values];
    
    return sql;
}

+ (NSArray *)getInsertDataArraySql:(NSArray *)array inTableName:(NSString *)tableName{
    NSMutableArray *sqlArray = [NSMutableArray array];
    for (id data in array) {
        [sqlArray addObject:[self getInsertDataSql:data inTableName:tableName]];
    }
    return sqlArray;
}

#pragma mark - delete sql
+ (NSString *)getDeleteDataSqlInTable:(NSString *)tableName andCondition:(NSDictionary *)condition {
    NSMutableString *sql = [[NSMutableString alloc] initWithFormat:@"DELETE FROM %@  %@", tableName,[self getConWithConditions:condition]];
    return sql;
}

#pragma mark - update sql
+ (NSString *)getUpdateDataSql:(id)data inTableName:(NSString *)tableName conditions:(NSDictionary *)conditions{
    // 参数
    NSMutableString *par = [NSMutableString string];
    NSDictionary *parameters = [data mj_keyValues];
    for (NSString *key in parameters.keyEnumerator) {
        [par appendFormat:@"%@='%@', ",key,[self getString:[parameters objectForKey:key]]];
    }
    
    if(par.length > 2) [par deleteCharactersInRange:NSMakeRange(par.length-2, 2)];
    // 条件
    NSString *con = [self getConWithConditions:conditions];
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ %@",tableName,par,con];
    return sql;
}

#pragma mark - select sql
+ (NSString *)getSelectTableSqlWithTable:(NSString *)tableName conditions:(NSDictionary *)conditions orderBy:(NSArray *)orderBy limit:(NSRange)range {
    if ([tableName isEqualToString:@""]) {
        return nil;
    }
    // 条件
    NSString *con = [self getConWithConditions:conditions];
    // 排序顺序
    NSMutableString *order = [NSMutableString string];
    if (orderBy != nil && orderBy.count != 0) {
        [order appendString:@"ORDER BY "];
        
        int count = 0;
        while (count != orderBy.count) {
            NSDictionary *dic = [orderBy objectAtIndex:count];
            [order appendFormat:@"%@ ",[dic objectForKey:@"order_name"]];
            if ([[dic objectForKey:@"order_is_asc"]boolValue]) {
                [order appendString:@"ASC "];
            } else {
                [order appendString:@"DESC "];
            }
            [order appendString:@", "];
            count++;
        }
        [order deleteCharactersInRange:NSMakeRange(order.length-2, 2)];
    }
    // 截取指定序号数据
    NSString *limit = @"";
    if (range.length != 0) {
        limit = [NSString stringWithFormat:@" LIMIT %lu,%lu ",(unsigned long)range.location,(unsigned long)range.length];
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ %@ %@ %@",tableName,con,order,limit];
    
    return sql;
}

#pragma mark - alter sql
+ (NSString *)getAlterSqlWithTable:(NSString *)tableName column:(NSString *)columnName type:(NSString *)type {
    NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@",tableName,columnName,type];
    return sql;
}

#pragma mark - delete table sql
+ (NSString *)getDeleteTableSqlWithTable:(NSString *)tableName {
    return [NSString stringWithFormat:@"DROP TABLE %@", tableName];
}

#pragma mark - clear table sql
+ (NSString *)getClearTableSqlWithTable:(NSString *)tableName {
    return [NSString stringWithFormat:@"DELETE FROM %@", tableName];
}

#pragma mark - *************** runtime
+ (NSDictionary *)modelToDictionary:(Class)cls
{
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithCapacity:0];
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        const char * type = property_getAttributes(property);
        NSString * typeString = [NSString stringWithUTF8String:type];
        id value = [self createSqlStringWithPropertyType:typeString];
        if (value) {
            [mDic setObject:value forKey:propertyName];
        }
    }
    free(properties);
    return mDic;
}

#pragma mark - private
+ (NSString *)createSqlStringWithPropertyType:(NSString *)typeStr{
    NSString *str = @"";
    if ([typeStr hasPrefix:@"T@\"NSString\""]) {
        str = @"varchar";
    } else if ([typeStr hasPrefix:@"T@\"NSData\""]) {
        str = @"longBlob";
    } else if ([typeStr hasPrefix:@"T@\"NSDate\""]) {
        str = @"date";
    } else if ([typeStr hasPrefix:@"Tf"] ||
               [typeStr hasPrefix:@"Td"]){
        str= @"float";
    } else if ([typeStr hasPrefix:@"Ti"] ||
               [typeStr hasPrefix:@"TI"] ||
               [typeStr hasPrefix:@"Ts"] ||
               [typeStr hasPrefix:@"TS"] ||
               [typeStr hasPrefix:@"TB"] ||
               [typeStr hasPrefix:@"Tq"] ||
               [typeStr hasPrefix:@"TQ"] ||
               [typeStr hasPrefix:@"T@\"NSNumber\""]) {
        str = @"integer";
    }
    return str;
}

+ (NSString*)getString:(NSObject *)obj {
    if ([obj isKindOfClass:[NSString class]]) {
        return [(NSString *)obj stringByReplacingOccurrencesOfString:@"'" withString:@"''"]; // 添加替换单引号，避免sqlite单引号关键字
    }
    else if ([obj isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)obj stringValue];
    }
    else if ([obj isKindOfClass:[NSDate class]]) {
        return [NSString stringWithFormat:@"%f",[(NSDate *)obj timeIntervalSince1970]];
    }
    else {
        return @"";
    }
}

// 查询条件部分
+ (NSString *)getConWithConditions:(NSDictionary *)conditions {
    NSMutableString *con = [NSMutableString string];
    if (conditions != nil && conditions.count != 0) {
        [con appendString:@"WHERE "];
        for (NSString *key in conditions.keyEnumerator) {
            // obj为数组时使用IN关键字，如果不是则使用“=”
            if ([[conditions objectForKey:key]isKindOfClass:[NSArray class]]) {
                NSArray *array = [conditions objectForKey:key];
                [con appendFormat:@"%@ IN ( ",key];
                NSInteger count = array.count;
                while (count--) {
                    [con appendFormat:@"'%@', ",[self getString:[array objectAtIndex:count]]];
                }
                [con deleteCharactersInRange:NSMakeRange(con.length-2, 2)];
                [con appendString:@") "];
            } else {
                [con appendFormat:@"%@='%@' ",key,[self getString:[conditions objectForKey:key]]];
            }
            [con appendString:@"AND "];
        }
        [con deleteCharactersInRange:NSMakeRange(con.length-4, 4)];
    }
    return con;
}

@end
