//
//  YLFileTool.m
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import "YLFileTool.h"

@implementation YLFileTool
//获取document路径
+(NSString*)getDocPath {
    NSString* docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return docPath;
}

//获取Library路径
+ (NSString*) getLibraryPath {
    NSString* libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    return libraryPath;
}

// 获取Caches目录路径
+ (NSString*) getCachesPath {
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return cachesPath;
}

// 获取tmp目录路径
+(NSString*)getTmpPath {
    NSString* tmpPath = NSTemporaryDirectory();
    return tmpPath;
}

+(NSString*)getTmpPathOfSubpath:(NSString*)subpath {
    NSString* tmpPath = [self getTmpPath];
    NSString* path = [tmpPath stringByAppendingPathComponent:@"subpath"];
    return path;
}

//复制源路径的文件到目标路径的文件
+ (BOOL) copyDirectoryFromSourcePath:(NSString*)sourcePath toTargetPath:(NSString*)targetPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *tmpPath = [self getTmpPathOfSubpath:@"uploadTmpFile"];
    NSError* error = nil;
    [fileManager copyItemAtPath:sourcePath toPath:tmpPath error:&error];
    if(error) NSLog(@"error = %@",error);
    
    NSArray* tmpSubpathComponentArrayI = [fileManager contentsOfDirectoryAtPath:tmpPath error:nil];
    for (NSString* tmpSubpathComponent in tmpSubpathComponentArrayI) {
        NSString* tmpSubpath = [tmpPath stringByAppendingPathComponent:tmpSubpathComponent];
        NSString* targetSubpath = [targetPath stringByAppendingPathComponent:tmpSubpathComponent];
        
        NSURL *soureUrl = [NSURL fileURLWithPath:tmpSubpath];
        NSURL *targetUrl = [NSURL fileURLWithPath:targetSubpath];
        
        NSError *error = nil;
        [fileManager replaceItemAtURL:targetUrl withItemAtURL:soureUrl backupItemName:nil options:NSFileManagerItemReplacementUsingNewMetadataOnly resultingItemURL:nil error:&error];
    }
    return true;
}

+ (BOOL) copyFileFromSourcePath:(NSString*)sourcePath toTargetPath:(NSString*)targetPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError* error = nil;
    [fileManager copyItemAtPath:sourcePath toPath:targetPath error:&error];
    if(error) return false;
    else return true;
}

//删除指定路径下的文件
+ (BOOL) deleteFileAtPath:(NSString*) path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        BOOL result = [fileManager removeItemAtPath:path error:&error];
        if (!result) NSLog(@"error = %@", error);
        return result;
    }
    return true;
}

//创建目录
+ (void)createDirectory:(NSString*)directory {
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:directory]) {
        return ;
    }
    else {
        [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

//转换文件大小为KB\MB\GB
+(NSString*)transformSizeToString:(long long)fileSize {
    return [NSByteCountFormatter stringFromByteCount:fileSize countStyle:NSByteCountFormatterCountStyleFile];
}

//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//遍历文件夹获得文件夹大小，返回字节
+ (long long ) folderSizeAtPath:(NSString*) filePath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath])
        return 0;
    NSString* fileName = [filePath copy];
    long long folderSize = 0;
    
    BOOL isdir;
    [manager fileExistsAtPath:fileName isDirectory:&isdir];
    if (isdir != YES) {
        return [self  fileSizeAtPath:fileName];
    }
    else
    {
        NSArray * items = [manager contentsOfDirectoryAtPath:fileName error:nil];
        for (int i =0; i<items.count; i++) {
            BOOL subisdir;
            NSString* fileAbsolutePath = [fileName stringByAppendingPathComponent:items[i]];
            
            [manager fileExistsAtPath:fileAbsolutePath isDirectory:&subisdir];
            if (subisdir==YES) {
                folderSize += [self folderSizeAtPath:fileAbsolutePath]; //文件夹就递归计算
            }
            else
            {
                folderSize += [self fileSizeAtPath:fileAbsolutePath];//文件直接计算
            }
        }
    }
    return folderSize; //folderSize/(1024*1024)递归时候会运算两次出错，所以返回字节。在外面再计算
}
@end
