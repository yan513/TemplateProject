//
//  NSString+contain.m
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import "NSString+contain.h"

@implementation NSString (contain)

- (BOOL)yl_isContainString:(NSString *)string {
    NSRange _range = [self rangeOfString:string];
    if (_range.location != NSNotFound) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)yl_isContainChinese {
    for(NSInteger i = 0; i < [self length]; i++){
        int a = [self characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)yl_isAllNum {
    unichar c;
    for (int i=0; i<self.length; i++) {
        c = [self characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}
@end
