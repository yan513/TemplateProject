//
//  YLDeviceTool.m
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import "YLDeviceTool.h"
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation YLDeviceTool
+ (NSString*)inquireDeviceName {
    NSString* deviceName = [UIDevice currentDevice].name;
    return deviceName;
}

+ (NSString*)inquireDeviceModel {
    NSString* deviceModel = [UIDevice currentDevice].model;
    return deviceModel;
}

+ (NSString*)inquireDeviceType {
    NSString* deviceLocialModel = [UIDevice currentDevice].localizedModel;
    return deviceLocialModel;
}

+ (NSString*)inquireDeviceSystemName {
    NSString* systemName = [UIDevice currentDevice].systemName;
    return systemName;
}

+ (NSString*)inquireDeviceSystemVersion {
    NSString* systemVersion = [UIDevice currentDevice].systemVersion;
    return systemVersion;
}

+ (NSString*)inquireDeviceBrand {
    return @"Apple";
}

+ (NSString*)inquireDeviceDetailModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine
                                               encoding:NSUTF8StringEncoding];
    // 模拟器
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    else if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    // iPhone 系列
    else if ([deviceModel isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    else if ([deviceModel isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    else if ([deviceModel isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    else if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    else if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    else if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA/Verizon/Sprint)";
    else if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    else if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    else if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    else if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    else if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    else if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    else if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    else if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    else if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    else if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    else if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    else if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    else if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7 (CDMA)";
    else if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7 (GSM)";
    else if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus (CDMA)";
    else if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus (GSM)";
    else if ([deviceModel isEqualToString:@"iPhone10,1"])    return @"iPhone 8 (CDMA)";
    else if ([deviceModel isEqualToString:@"iPhone10,4"])    return @"iPhone 8 (GSM)";
    else if ([deviceModel isEqualToString:@"iPhone10,2"])    return @"iPhone 8 Plus (CDMA)";
    else if ([deviceModel isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus (GSM)";
    else if ([deviceModel isEqualToString:@"iPhone10,3"])    return @"iPhone X (CDMA)";
    else if ([deviceModel isEqualToString:@"iPhone10,6"])    return @"iPhone X (GSM)";
    
    // iPod 系列
    else if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    else if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    else if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    else if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    else if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    else if ([deviceModel isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
    
    // iPad 系列
    else if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    else if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    
    else if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    else if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    else if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    else if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    else if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    else if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    else if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    
    else if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    else if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    else if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    else if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    else if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    else if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    else if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air";
    else if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air";
    else if ([deviceModel isEqualToString:@"iPad4,3"])      return @"iPad Air";
    else if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2";
    else if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2";
    else if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    else if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    else if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    else if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    
    else if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4";
    else if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4";
    else if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    else if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    
    else if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad PRO (12.9)";
    else if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad PRO (12.9)";
    else if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad PRO (9.7)";
    else if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad PRO (9.7)";
    else if ([deviceModel isEqualToString:@"iPad6,11"])      return @"iPad 5";
    else if ([deviceModel isEqualToString:@"iPad6,12"])      return @"iPad 5";
    
    else if ([deviceModel isEqualToString:@"iPad7,1"])      return @"iPad PRO 2 (12.9)";
    else if ([deviceModel isEqualToString:@"iPad7,2"])      return @"iPad PRO 2 (12.9)";
    else if ([deviceModel isEqualToString:@"iPad7,3"])      return @"iPad PRO (10.5)";
    else if ([deviceModel isEqualToString:@"iPad7,4"])      return @"iPad PRO (10.5)";
    
    return deviceModel;
}

+ (NSString *)inquireIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}
@end
