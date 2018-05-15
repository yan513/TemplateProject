//
//  YLFileTool.h
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLFileTool : NSObject
//获取document路径
+(NSString*)getDocPath;

//获取Library路径
+ (NSString*)getLibraryPath;

// 获取Caches目录路径
+ (NSString*)getCachesPath;

// 获取tmp目录路径
+(NSString*)getTmpPath;

//复制源路径的文件到目标路径的文件
+ (BOOL)copyFileFromSourcePath:(NSString*)sourcePath toTargetPath:(NSString*)targetPath;

//复制原路径的文件夹到目标路径的文件夹
+ (BOOL)copyDirectoryFromSourcePath:(NSString*)sourcePath toTargetPath:(NSString*)targetPath;

//删除指定路径下的文件
+ (BOOL)deleteFileAtPath:(NSString*)path;

//创建目录
+ (void)createDirectory:(NSString*)directory;

//遍历文件夹获得文件夹大小，返回字节
+ (long long )folderSizeAtPath:(NSString*) filePath;

//转换文件大小为KB\MB\GB
+(NSString*)transformSizeToString:(long long)fileSize;

//单个文件的大小
+ (long long)fileSizeAtPath:(NSString*)filePath;

//获取bundle文件路径
+ (NSString *)getBundlePath:(NSString *)sourceName type:(NSString *)type;

@end
