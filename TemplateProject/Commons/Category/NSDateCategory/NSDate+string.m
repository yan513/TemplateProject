//
//  NSDate+string.m
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import "NSDate+string.h"
#import "NSString+date.h"
@implementation NSDate (string)

- (NSString *)yl_dateToStringWithFormate:(NSString *)formate {
    NSDateFormatter *dataFormatter = [formate yl_stringToDateFromatter:formate];
    return [dataFormatter stringFromDate:self];
}

- (NSString *)yl_stringFromHours:(NSInteger)hours andFormat:(NSString *)formate {
    NSDateFormatter *dataFormatter = [formate yl_stringToDateFromatter:formate];
    NSTimeInterval secondsPerDay = hours * 60 * 60;
    NSDate *result = [self dateByAddingTimeInterval:secondsPerDay];
    return [dataFormatter stringFromDate:result];
}
@end
