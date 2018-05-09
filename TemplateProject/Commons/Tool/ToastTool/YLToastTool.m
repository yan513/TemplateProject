//
//  YLToastTool.m
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import "YLToastTool.h"
#import "SVProgressHUD.h"

@implementation YLToastTool

+ (void)toastInitlizationWithDuration:(NSTimeInterval)interval {
    [SVProgressHUD setMinimumDismissTimeInterval:interval];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

+ (void)showInfoMessage:(NSString*)infoMessage {
    [SVProgressHUD showInfoWithStatus:infoMessage];
}

+ (void)showStatusMessage:(NSString*)statusMessage {
    [SVProgressHUD showWithStatus:statusMessage];
}

+ (void)showSuccessMessage:(NSString*)successMessage {
    [SVProgressHUD showSuccessWithStatus:successMessage];
}

+ (void)showErrorMessage:(NSString*)errorMessage {
    [SVProgressHUD showErrorWithStatus:errorMessage];
}

+ (void)dismiss {
    [SVProgressHUD dismiss];
}

@end
