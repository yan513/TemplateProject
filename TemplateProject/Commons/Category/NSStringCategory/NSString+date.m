//
//  NSString+date.m
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import "NSString+date.h"

@implementation NSString (date)

- (NSDate *)yl_stringToDate {
    NSDateFormatter *formate = [self yl_stringToDateFromatter:@"yyyy-MM-dd HH:mm:ss"];
    return [self yl_stringToDateWithFormate:formate];
}

- (NSDateFormatter *)yl_stringToDateFromatter:(NSString *)formate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formate];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    return dateFormatter;
}

- (NSDate *)yl_stringToDateWithFormate:(NSDateFormatter *)dataFormatter {
    return [dataFormatter dateFromString:self];
}
@end
