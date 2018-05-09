//
//  NSDate+string.h
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (string)

/**
 时间转字符串

 @param formate 格式
 @return 字符串
 */
- (NSString *)yl_dateToStringWithFormate:(NSString *)formate;

/**
 计算xx小时后的时间

 @param hours 小时
 @param formate 格式
 @return 时间
 */
- (NSString *)yl_stringFromHours:(NSInteger)hours andFormat:(NSString *)formate;
@end
