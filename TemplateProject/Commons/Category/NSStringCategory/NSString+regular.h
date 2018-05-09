//
//  NSString+regular.h
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (regular)
//判断手机号码格式是否正确
- (BOOL)yl_valiMobile;
//利用正则表达式验证
- (BOOL)yl_isAvailableEmail;
@end
