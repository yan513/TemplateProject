//
//  YLToastTool.h
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLToastTool : NSObject

/**
 * 初始化toast控件，输入toast显示时长
 */
+ (void)toastInitlizationWithDuration:(NSTimeInterval)interval;

/**
 * 展示普通toast信息
 */
+ (void)showInfoMessage:(NSString*)infoMessage;

/**
 * 展示加载中的toast信息
 */
+ (void)showStatusMessage:(NSString*)statusMessage;

/**
 * 展示成功toast信息
 */
+ (void)showSuccessMessage:(NSString*)successMessage;

/**
 * 展示错误toast信息
 */
+ (void)showErrorMessage:(NSString*)errorMessage;

/**
 * 隐藏toast信息
 */
+ (void)dismiss;

@end
