//
//  UIColor+hex.h
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/15.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (hex)

+ (UIColor *)hexStringToColor:(NSString *)stringToConvert;

+ (UIColor *)colorWithHexNumber:(NSUInteger)hexColor;

@end
