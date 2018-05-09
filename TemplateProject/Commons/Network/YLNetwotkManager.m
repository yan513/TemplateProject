//
//  YLNetwotkManager.m
//  YLExtensionExample
//
//  Created by Lin Yan on 2017/9/27.
//  Copyright © 2017年 Lin Yan. All rights reserved.
//

#import "YLNetwotkManager.h"

static id instance;

@implementation YLNetwotkManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return instance;
}

+ (AFHTTPSessionManager *)defaultManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    return manager;
}
+ (NSString *)strUTF8Encoding:(NSString *)str{
    return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
}
#pragma mark - 网络监听

+ (void)startMonitoring {
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            {
                NSLog(@"未知网络");
                [YLNetwotkManager shareInstance].networkStatus = StatusUnknown;
                break;
            }
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
            {
                NSLog(@"没有网络");
                [YLNetwotkManager shareInstance].networkStatus = StatusNoReachable;
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
            {
                NSLog(@"手机自带网络");
                [YLNetwotkManager shareInstance].networkStatus = StatusReachableViaWAN;
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
            {
                [YLNetwotkManager shareInstance].networkStatus = StatusReachableViaWiFi;
                NSLog(@"WIFI--%lu",(unsigned long)[YLNetwotkManager shareInstance].networkStatus);
                break;
            }
        }
    }];
    [mgr startMonitoring];
}

+ (NSURLSessionTask *)getWithURL:(NSString *)url params:(NSDictionary *)params success:(YLResponseSuccess)success fail:(YLResponseFail)fail {
    if (url == nil) return nil;
    
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    
    AFHTTPSessionManager* manager = [self defaultManager];
    
    NSURLSessionTask *sessionTask = [manager GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        #pragma mark - 根据业务需求做具体处理
        if (success) success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (fail) fail(error);
        
    }];
    return sessionTask;
}

+ (NSURLSessionTask *)postWithURL:(NSString *)url params:(id)params response:(YLNetworkBaseViewModel *)baseViewModel success:(YLResponseSuccess)success fail:(YLResponseFail)fail {
    if (url == nil) return nil;
    
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    
    AFHTTPSessionManager* manager = [self defaultManager];
    
    baseViewModel.loadEvent = LOADING;
    
    NSURLSessionTask *sessionTask = [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success");
        #pragma mark - 根据业务需求做具体处理
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
    
    return sessionTask;
}

+ (NSURLSessionTask *)uploadWithImage:(UIImage *)image url:(NSString *)url fileName:(NSString *)fileName name:(NSString *)name params:(NSDictionary *)params progress:(YlUploadProgress)progress success:(YLResponseSuccess)success fail:(YLResponseFail)fail {
    
    if (url == nil) return nil;
    
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    
    AFHTTPSessionManager *manager=[self defaultManager];
    
    NSURLSessionTask *sessionTask = [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        NSString *imageFileName = fileName;
        if (fileName == nil || ![fileName isKindOfClass:[NSString class]] || fileName.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
        }
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
        
    }];
    
    [sessionTask resume];
    
    return sessionTask;
}

+ (NSURLSessionTask *)downloadWithUrl:(NSString *)url saveToPath:(NSString *)saveToPath needSuggestName:(BOOL)isNeed progress:(YLDownloadProgress)progressBlock success:(YLResponseSuccess)success failure:(YLResponseFail)fail {
    if (url==nil)  return nil;
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [self defaultManager];
    
    NSURLSessionTask *sessionTask = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progressBlock) {
                NSLog(@"%f",downloadProgress.fractionCompleted);
                progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (!saveToPath) {
            
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSLog(@"默认路径--%@",downloadURL);
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
            
        }else{
            if (isNeed) {
                return [NSURL fileURLWithPath:[saveToPath stringByAppendingString:response.suggestedFilename]];
            }
            else{
                return [NSURL fileURLWithPath:[saveToPath stringByAppendingString:@".mp3"]];
            }
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"下载文件成功");
        if (error == nil) {
            if (success) {
                success([filePath path]);//返回完整路径
            }
            
        } else {
            if (fail) {
                fail(error);
            }
        }
    }];
    
    [sessionTask resume]; //开始下载
    
    return sessionTask;
}
@end
