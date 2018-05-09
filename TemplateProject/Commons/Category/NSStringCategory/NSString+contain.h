//
//  NSString+contain.h
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (contain)

/**
 是否包含另一个字符串

 @param string 字符串
 @return 判断结果
 */
- (BOOL)yl_isContainString:(NSString *)string;

/**
 是否包含中文

 @return 结果
 */
- (BOOL)yl_isContainChinese;


/**
 是否全是数字

 @return 结果
 */
- (BOOL)yl_isAllNum;
@end
