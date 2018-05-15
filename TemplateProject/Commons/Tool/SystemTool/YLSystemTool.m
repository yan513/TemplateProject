//
//  YLSystemTool.m
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/15.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import "YLSystemTool.h"

@implementation YLSystemTool

+ (BOOL)isSyetemLanguageCN {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLang = [languages objectAtIndex:0];
    if ([currentLang isEqualToString:@"zh-Hans"] || [currentLang isEqualToString:@"zh-Hant"]) {
        return YES;
    }
    return NO;
}
@end
