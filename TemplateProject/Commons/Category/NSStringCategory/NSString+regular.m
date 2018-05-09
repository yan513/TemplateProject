//
//  NSString+regular.m
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import "NSString+regular.h"

@implementation NSString (regular)
//判断手机号码格式是否正确
- (BOOL)yl_valiMobile{
    NSString *regular =@"^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    if ([pred evaluateWithObject:self]) {
        return YES;
    }else{
        return NO;
    }
}
//利用正则表达式验证
- (BOOL)yl_isAvailableEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
@end
