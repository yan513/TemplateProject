//
//  YLNetwotkManager.h
//  YLExtensionExample
//
//  Created by Lin Yan on 2017/9/27.
//  Copyright © 2017年 Lin Yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "YLNetworkBaseViewModel.h"
typedef NS_OPTIONS(NSUInteger, YLNetworkStatus) {
    StatusNoReachable      = 0,//没有网络
    StatusReachableViaWAN  = 1,//手机网络
    StatusReachableViaWiFi = 2,//wifi网络
    StatusUnknown          = 3 //未知网络
};

typedef void(^YLResponseSuccess)(id response);
typedef void(^YLResponseFail)(NSError* error);
typedef void(^YlUploadProgress)(int64_t bytesProgress, int64_t totalBytesProgress);
typedef void(^YLDownloadProgress)(int64_t bytesProgress, int64_t totalBytesProgress);

@interface YLNetwotkManager : NSObject

@property (nonatomic) YLNetworkStatus networkStatus;

+ (YLNetwotkManager *)shareInstance;

/**
 *     默认网络请求设置
 *
 *  @return 返回默认设置AFHTTPSessionManager
 */
+ (AFHTTPSessionManager *)defaultManager;
/**
 *  开启网络监测
 */
+(void)startMonitoring;

/**
 *  get请求方法，block回调
 *
 *  @param url     请求连接的URL
 *  @param params  请求参数
 *  @param success 请求成功回调
 *  @param fail    请求失败回调
 *
 *  @return 返回请求task
 */
+(NSURLSessionTask *)getWithURL:(NSString *)url
                         params:(NSDictionary *)params
                        success:(YLResponseSuccess)success
                           fail:(YLResponseFail)fail;

/**
 *  post请求方法，block回调
 *
 *  @param url     请求连接的URL
 *  @param params  请求参数
 *  @param success 请求成功回调
 *  @param fail    请求失败回调
 *
 *  @return 返回请求task
 */
+(NSURLSessionTask *)postWithURL:(NSString *)url
                          params:(id)params
                        response:(YLNetworkBaseViewModel*)baseViewModel
                         success:(YLResponseSuccess)success
                            fail:(YLResponseFail)fail;

/**
 *  上传图片方法
 *
 *  @param image      上传的图片
 *  @param url        请求连接，根路径
 *  @param fileName   图片的名称(如果不传则以当时间命名)
 *  @param name       上传图片时填写的图片对应的参数
 *  @param params     参数
 *  @param progress   上传进度
 *  @param success    请求成功返回数据
 *  @param fail       请求失败
 *
 *  @return 上传操作的task
 */
+ (NSURLSessionTask*)uploadWithImage:(UIImage *)image
                                  url:(NSString*)url
                             fileName:(NSString*)fileName
                                 name:(NSString*)name
                               params:(NSDictionary*)params
                             progress:(YlUploadProgress)progress
                              success:(YLResponseSuccess)success
                                 fail:(YLResponseFail)fail;

/**
 *  下载文件方法
 *
 *  @param url           下载地址
 *  @param saveToPath    文件保存的路径,如果不传则保存到Documents目录下，以文件本来的名字命名
 *  @param progressBlock 下载进度回调
 *  @param success       下载完成
 *  @param fail          失败
 *
 *  @return 返回请求任务对象，便于操作
 */
+ (NSURLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                      needSuggestName:(BOOL)isNeed
                             progress:(YLDownloadProgress)progressBlock
                              success:(YLResponseSuccess)success
                              failure:(YLResponseFail)fail;

@end
