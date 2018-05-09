//
//  YLDeviceTool.h
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLDeviceTool : NSObject
//获取设备所有者的名称
+ (NSString*)inquireDeviceName;

//获取设备的型号
+ (NSString*)inquireDeviceModel;

//获取本地化版本
+ (NSString*)inquireDeviceType;

//获取当前运行的系统
+ (NSString*)inquireDeviceSystemName;

//获取当前系统的版本
+ (NSString*)inquireDeviceSystemVersion;

//获取设备的具体型号
+ (NSString*)inquireDeviceDetailModel;

//获取手机品牌
+ (NSString*)inquireDeviceBrand;

//获取设备 IP 地址
+ (NSString*)inquireIPAddress;
@end
