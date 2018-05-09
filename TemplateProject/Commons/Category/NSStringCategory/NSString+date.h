//
//  NSString+date.h
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (date)

/**
 字符串转 NSDate

 @return 时间
 */
- (NSDate *)yl_stringToDate;
/**
 字符串转 NSDateFormatter

 @param formate 格式
 @return NSDateFormatter
 */
- (NSDateFormatter *)yl_stringToDateFromatter:(NSString *)formate;
/**
 字符串转 NSDate

 @param dataFormatter 格式
 @return 时间
 */
- (NSDate *)yl_stringToDateWithFormate:(NSDateFormatter *)dataFormatter;

@end
